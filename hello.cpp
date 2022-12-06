#include <lua.hpp>

#include <iostream>
#include <string>

using std::string; using std::cout;

static int l_hello(lua_State* l)
{
	const std::string name = luaL_checkstring(l,-1);
	cout << "Hello, " << name << "\n";
	return 1;
}

extern "C" int luaopen_hello(lua_State* l)
{
	const struct luaL_Reg lib[] = {
		{"hello",l_hello},{NULL,NULL}};
	luaL_newlib(l,lib);
	return 1;
}