# 概要
+ 这一部分的代码就是加工润色部分的，课本24到25面的代码。
其实这一部分和assemble文件夹中的内部没有什么区别。
只是更有组织了。

但是这个程序的组织更是体现了了数据是有结构的这一特点，
而且最重要的是，这个结构告诉了我们，512字的内容里面，都是数字，
但是一部分是指令，一部分是数据，指令是用来运行的，数据是信息，是给指令
以某种方式解释的。怎么解释看指令是如何操作数据。

代码：
第一部分是告诉程序，这个软盘用了什文件系统格式，是fat12的文件系统格式，就遵守这个文件系统格式的规定，知道了这个软盘是怎么放文件的，我们就可以利用这个规定，的到软盘上面放了什么文件。找到软盘上文件的过程，就是文件系统实现的过程。当然这是后面的事情，现在还不太了解到文件系统。只是当做给自己的复习。

第二部分才是真正的指令部分，虽然也是用bd 0xb8..这种定义字节的汇编格式，但是这里的数字已经表示的是指令了。指令是用来执行的。
cpu取这部分的指令，译码，执行。

第三部分的内容是就是信息了，是要显示的数据了，第二部分的指令就是用来把这一部分的信息送到screen上，显示出来的。

第四部分，没有什么用，目前来说，丢了也不会影响结果




在更高的抽象层次理解 这一部分程序：
第一部分，只是一个表示fat12的文件系统的结构

```c
strutct fat12
{
jmp to code 
char name[]="helloipl";
short sector=512;
int   cluster=1;
short fat_start=1;
char  fat_number=2
short root_size=224;
short disk_size=2880;
char  disk_type=0xf0;
short fat_length=9;
short onetrack=18;
short heads=2;
int  partition_num=0;
int  disk_size=2880;
char a=0,b=0,c=0x29 ; fixed
int  fixed=0xffffffff;

char diskname[]="hello-os   ";
char diskformat[]="fat12   "
char resb[18]={0};
}
```
第二部分的代码，下在则伪代码：
disp(p);//显示指针P的内容到screen.
第三部分更简单：伪代码如下：
char *p="\n\nhello, world\n\0";

上面的这个数据结构，就是代表了fat12的文件格式。

几个新的汇编指令
db :1byte
dw :2bytes
dd :4bytes

db "hellow,world" 说明db可以用来定义字符串。

resb 0x1fe-$  保留到0x1fe，但是0x1fe这个空间没有被用。


boot sector 软盘的第一个扇区，对软盘的读写操作都是惟cluster为单位，
但是1cluster=1sector,软盘总共有2880个sectors

ipl:initial program loader   8个字节。
	  :so helloipl

boot:bootstrap,自力更生，完成任务。


从汇编中，抽象出数据结构，函数，字符串指针的 特点。只有在这个角度学习，才会把书本关了，仍然知道这个汇编的结构，可以容易的写出伪代码，
以top-down的思路，细化下去，当然只有对汇编有了更深入的了解才能把
第二部分的条码写出来。


注意：开始没有出现hello world，检查了一下hello.img是不是512字节，结果是的，知道没有掉下一个字节，检查code部分，发现db的时候错了一个字节。改过了就ok了。



