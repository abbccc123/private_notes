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
