# Cpp learning notes

=================================================
https://google.github.io/styleguide/cppguide.html
=================================================

define guard


1. 类定义中，方法默认是内联的，一旦离开类定义，必须显式使用inline关键字声明其为内联函数，template函数不受此约束。(考虑优化mdf函数)

2. 可直接在header中define的三种类型的函数: inline static template

3. 为什么不要在header中define common function?


Recommended including order for google:
Related header, System headers, std headers, other headers in your project.

using ::name - 强制在全局作用域中查找名称
using name 从当前作用域开始查找名称，若找到了则使用最接近的那个name

说到底编译过程实在太复杂了，对绝大多数人来说仅是个黑盒，我们不断通过外部信息调整对编译系统和语言细节的认识

Single-line nested namespace declarations

namespace: Avoid collipsion. However, it sometimes leads to messy codes.

考虑可见性的应用。

三种static storage duratino ->

smart pointer是为了解决什么问题? 对动态资源的智能管理，自动析构。

learncpp.com

基本类型的运算符不可以重载

Prefer to use 'type var { value }' instead of 'type var = value' in basic types context.

进程在内存中占用的五个区域:
text segment | bss segment | data segment | heap segment | stack segment

Most people learn as much or more from following the examples as they do from reading the text.
少部分天才可以越过这一步

Member functions can also be (forward) declared inside the class definition, and defined after the class definition.

identifier: the name implies that it is the unique.

Is main function always running before any other function? No, and give a example.

EXIT_SUCCESS(0) and EXIT_FAILURE(1) from the standard C library.

Tell the ODR principle in cpp.

Option styles:

Unix short: a dash and an alpha character
GNU long option: two dashes and a word
DOS/windows: backslash
BSD: no dash

GDB stl pretty output:
1. Check /usr/share/gcc-\*/
2. add ~/.gdbinit
python
import sys
sys.path.insert(0, '/usr/share/gcc-\*/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(gdb.current_objfile())
end

Qt GUI development integrated with GDB:
1. source /path/to/qt5/qtbase/libexec/qt5printers.py ( pretty printer )
2. QT_LOGGING_RULES="category[.subcat]=true;othercat.debug=false;\*=false"
