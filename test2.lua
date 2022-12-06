local e = package.loadlib('./hello.so','l_openhello')
hello = e().hello
print(e)
print(hello)
hello('yassin')