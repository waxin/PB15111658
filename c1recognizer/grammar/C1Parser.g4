parser grammar C1Parser;
options { tokenVocab = C1Lexer; }

compilationUnit: ;
decl: ;
constdecl: ;
constdef: ;
vardecl: ;
vardef: ;
funcdef: ;
block: ;
stmt: ;
lval: ;
cond: ;
exp:
    exp (Multiply | Divide | Modulo) exp
    | exp (Plus | Minus) exp
    | (Plus | Minus) exp
    | LeftParen exp RightParen
    | Number
;
