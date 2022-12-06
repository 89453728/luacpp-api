#include <lua.hpp>

#ifdef MATRIX
#include <octave/oct.h>
#endif

#ifdef BLAS
#include "ublas/matrix.hpp"
#endif

#include <iostream>
#include <string>

using std::string; using std::cout;

static int l_hello(lua_State* l)
{
    const std::string name = luaL_checkstring(l,-1);
    cout << "Hello, " << name << "\n";
    return 1;
}

#ifdef MATRIX
static int l_matrix(lua_State* l)
{
    auto m = Matrix(dim_vector(2,2));
    for (octave_idx_type i = 0;i < 4;++i)
	m(i/2,i%2) = i;
    std::cout << m << std::endl;
    return 1;
}
#endif

#ifdef BLAS
static void print_matrix(const boost::numeric::ublas::matrix<double> &d)
{
    for (int i=0;i<d.size1()*d.size2();++i){
	std::cout << ((i%d.size2() == 0)? "[ " : "") << d(i/d.size1(),i%d.size2()) << \
	    ((i%d.size2() == d.size2()-1)? " ]\n" : " ");
    }
}
//
static int l_matrixblas(lua_State* l)
{
    auto m = boost::numeric::ublas::matrix<double>(3,3);
    for (int i = 0;i < m.size1()*m.size2();++i)
	m(i/m.size2(),i%m.size2()) = i;
    print_matrix(m);
    
    return 1;
}
#endif

extern "C" int luaopen_hello(lua_State* l)
{
    const struct luaL_Reg lib[] = {
	{"hello",l_hello},
	
#ifdef MATRIX
	{"matrix",l_matrix},
#endif
#ifdef BLAS
	{"matrix",l_matrixblas},
#endif
	{NULL,NULL}};
    luaL_newlib(l,lib);
    return 1;
}
