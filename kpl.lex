%{
	#include "y.tab.h"
	int scheck = 0;
%}

%s STRING

%%
\" { scheck ^=1; if(scheck) BEGIN(STRING); else BEGIN(0); return DQ;}
<STRING>[^\"]* { yylval.name = strdup(yytext); return SLIT; }
[\ \t] {} 
"get" { return GET;}
"put" { return PUT;}
"number" { return NUM; }
"string" { return STR; }
"to" { return TO; }
"add" { return ADD; }
"subtract" { return SUB; }
"multiply" { return MUL; }
"from" { return FROM; }
"times" { return TIMES; }
"divide" { return DIV; }
"by" { return BY; }
"if" { return IF; }
"greater than" { return GT; }
"less than" { return LT; }
"or" { return OR; }
"and" { return AND; }
"equal to" { return EQ; }
"then" { return THEN; }
"done" { return DONE; }
"store" { return STORE; }
"else" { return ELSE; }
"modulus" { return MOD; }
[a-zA-Z][a-zA-Z0-9]* { yylval.name = strdup(yytext); return ID; }
[0-9]+ { yylval.name = strdup(yytext); return NUMVAL; }
[\n] { return '\n'; }
%%
