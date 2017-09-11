# H1

> 1.源代码

    #include <stdio.h>
    #include <stdlib.h>
    
    int main(){	
    	printf ("hello world\n");
        return(0);
    }
> 2.-S选项

```
.file   "hello.c"

        .section        .rodata

.LC0:

        .string "hello world"				//定义字符串"hello world"
        .text
        .globl  main
        .type   main, @function

main:

.LFB2:

        .cfi_startproc						//Call Frame Instrctions，标志函数开始
        pushq   %rbp						//基址寄存器压栈
        .cfi_def_cfa_offset 16				// 此处距离CFA地址为16字节
        .cfi_offset 6, -16					//把第6号寄存器原先的值保存在距离CFA - 16的位置
        movq    %rsp, %rbp					//rsp->rbp
        .cfi_def_cfa_register 6				//从这里开始, 使用rbp作为计算CFA的基址寄存器
        movl    $.LC0, %edi					//将字符串地址存入edi
        call    puts						//调用puts函数
        movl    $0, %eax					//0->eax
        popq    %rbp						//基址出栈
        .cfi_def_cfa 7, 8
        ret									//返回
        .cfi_endproc						//标志函数终止

.LFE2:

        .size   main, .-main
        .ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
        .section        .note.GNU-stack,"",@progbits
```



> 3.-m32选项

```
 .file   "hello.c"

        .section        .rodata

.LC0:

        .string "hello world"				//定义字符串"hello world"
        .text
        .globl  main
        .type   main, @function

main:

.LFB2:

        .cfi_startproc						//Call Frame Instrctions，标志函数开始
        leal    4(%esp), %ecx				//将esp的值加4存入ecx中			
        .cfi_def_cfa 1, 0					
        andl    $-16, %esp					//esp与上-16
        pushl   -4(%ecx)					//ecx-4压栈
        pushl   %ebp
        .cfi_escape 0x10,0x5,0x2,0x75,0
        movl    %esp, %ebp					//esp->ebp
        pushl   %ecx						//ecx压栈
        .cfi_escape 0xf,0x3,0x75,0x7c,0x6
        subl    $4, %esp					//esp-4
        subl    $12, %esp					//esp-12
        pushl   $.LC0						//字符串地址压栈
        call    puts						//调用puts函数
        addl    $16, %esp					//esp与上16
        movl    $0, %eax					//0->eax
        movl    -4(%ebp), %ecx			
        .cfi_def_cfa 1, 0
        leave
        .cfi_restore 5
        leal    -4(%ecx), %esp
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc						//函数结束

.LFE2:

        .size   main, .-main
        .ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
        .section        .note.GNU-stack,"",@progbits
```



> 4.-m64选项

```
 .file   "hello.c"

        .section        .rodata

.LC0:

        .string "hello world"				//定义字符串"hello world"
        .text
        .globl  main
        .type   main, @function

main:

.LFB2:

        .cfi_startproc						//Call Frame Instrctions，标志函数开始
        pushq   %rbp						//基址寄存器压栈
        .cfi_def_cfa_offset 16				// 此处距离CFA地址为16字节
        .cfi_offset 6, -16					//把第6号寄存器原先的值保存在距离CFA - 16的位置
        movq    %rsp, %rbp					//rsp->rbp
        .cfi_def_cfa_register 6				//从这里开始, 使用rbp作为计算CFA的基址寄存器
        movl    $.LC0, %edi					//将字符串地址存入edi
        call    puts						//调用puts函数
        movl    $0, %eax
        popq    %rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc						//标志函数终止

.LFE2:
  .size   main, .-main
  .ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
  .section        .note.GNU-stack,"",@progbits
```