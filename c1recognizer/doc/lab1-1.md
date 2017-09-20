# lab1-1实验报告

## 1.实验中遇到的问题

- 1 ：在表示'//'注释的正规式时需要用到'\'符号，但是在正规式中直接引用'\'会报错。原因在于'\'用于转义字符前，要表示'\'需要引用'\\\'，由此问题解决。
- 2 ：在.g4的文法规则中，[]中表示的是一个集合，各个自字符之间不需要用'|'分隔。      

## 2.分析与设计

### 2.1实验分析

本次实验的主要内容在于完善C1Lexer.g4文件，其中最困难的部分在于如何表示注释，下面简述我的分析

- 1：'//'注释的处理，'//'注释需要满足在行未利用'\'进行连接，但是需要注意这个'\'连接符一定是在行未起作用，换句话就是在换行符前。由此可以将'//'注释语句分成三个基本部分，第一部分即注释头部，用'//'表示，中间部分为一行以'\'以及换行符结尾的行（'\'之前可以不含其它字符），最后一行结尾不含'\'。用规定的文法表示如下		Note: '//'((~[\r\n])\*'\\\'[\r\n])*(~[\r\n])\* -> skip;
- 2: '/\*'注释的处理相对简单一些。Notes:'/\*'.\*?'*/' ->skip; 在两个配对的'/\*'之间尽量匹配少的字符

### 2.2实验设计(过程)

- 1:完善C1Lexer.g4文件，完善后的内容如下

```
lexer grammar C1Lexer;

tokens {
    Comma,
    SemiColon,
    Assign,
    LeftBracket,
    RightBracket,
    LeftBrace,
    RightBrace,
    LeftParen,
    RightParen,
    If,
    Else,
    While,
    Const,
    Equal,
    NonEqual,
    Less,
    Greater,
    LessEqual,
    GreaterEqual,
    Plus,
    Minus,
    Multiply,
    Divide,
    Modulo,

    Int,
    Void,

    Identifier,
    Number
}

Comma: ',';
SemiColon: ';';
Assign: '=';
LeftBracket: '[';
RightBracket: ']';
LeftBrace: '{';
RightBrace: '}';
LeftParen: '(';
RightParen: ')';
If: 'if';
Else: 'else';
While: 'while';
Const: 'const';
Equal: '==';
NonEqual: '!=';
Less: '<';
Greater: '>';
LessEqual: '<=';
GreaterEqual: '>=';
Plus: '+' ;
Minus: '-' ;
Multiply: '*' ;
Divide: '/' ;
Modulo: '%' ;

Int: 'int';
Void: 'void';

Identifier:[_a-zA-Z][_a-zA-Z0-9]*;
Number: [0-9]+ | '0x' [0-9a-fA-F]+ ;

Note: '//'((~[\r\n])*'\\'[\r\n])*(~[\r\n])* -> skip;
Notes:'/*'.*?'*/' ->skip;
WhiteSpace: [ \t\r\n]+ -> skip;
```

- 2：编写测试文件，test1是一个完整的程序，包含基本的Token，test2主要测试注释，不是一个完整的程序
- 3：根据实验指导进行测试

 