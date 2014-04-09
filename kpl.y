%{
	#include<stdio.h>
	int yywrap() {
		return 1;
	}

	void yyerror(char* str) {
		printf("error: %s\n", str);
	}

	int main() {
		yyparse();

		return 0;
	}

	void x(int i) {
		while(i--) printf("\t");
	}

	int i = 0;
%}

%union {
	char* name;
}
%token GET PUT NUM STR TO ADD SUB MUL FROM TIMES DIV BY IF GT LT OR AND EQ THEN DONE STORE ELSE MOD DQ
%token <name> ID
%token <name> NUMVAL
%token <name> SLIT
%type <name> val
%%

prog	: stmt '\n' prog
		| block '\n' prog
		| stmt '\n'
		| block '\n'
		| '\n'
		|
		;

stmt	: GET NUM ID { x(i); printf("%s = input()\n", $3 ); }
		| GET STR ID { x(i); printf("%s = input()\n",$3); }
        | ADD val TO ID { x(i); printf("%s = %s + %s\n",$4,$4,$2);}
		| SUB val FROM ID { x(i); printf("%s = %s - %s\n",$4,$4,$2);}
		| MUL ID val TIMES { x(i); printf("%s = %s * %s\n",$2,$2,$3);}
		| DIV ID BY val { x(i); printf("%s = %s / %s\n",$2,$2,$4);}
		| STORE val TO ID { x(i); printf("%s = %s\n",$4,$2);}
		| PUT val { x(i); printf("print %s\n", $2); }
		| ID MOD val { x(i); printf("%s = %s %% %s\n",$1,$1,$3);}
		| PUT DQ SLIT DQ { x(i); printf("print \"%s\"\n",$3); }
		;

block	: if_block		
		;

if_block	: if cond incc then '\n' prog DONE decc
			| if cond incc then '\n' prog decc elsei incc '\n' prog DONE decc
			| if cond incc then '\n' prog decc else if_block

then	: THEN { printf(" :\n"); }
		;

val		: ID { $$ = $1;}
		| NUMVAL { $$ = $1;}
		;

if		: IF { x(i); printf("if "); }
		;

else	: ELSE { x(i); printf("el"); }
		;

elsei	: ELSE { x(i); printf("else :\n"); }
		;

cond	: val GT val { printf("%s > %s", $1, $3); }
		| val LT val { printf("%s < %s", $1, $3); }
		| val LT OR EQ val { printf("%s <= %s", $1, $5); }
		| val GT OR EQ val { printf("%s >= %s", $1, $5); }
		| val EQ val { printf("%s == %s", $1, $3); }
		| cond or cond
		| cond and cond
		;

or		: OR { printf(" or "); }
		;

and		: AND { printf(" and "); }
		;

incc	: { i++; }
		;

decc	: { i--; }
		;

%%
