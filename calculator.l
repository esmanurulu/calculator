%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
%}

%%
[0-9]+(\.[0-9]+)?    { yylval.sayi = atof(yytext); return SAYI; }
"exit"               { return EXIT; }  
"**"                 { return USLU; }
"^"                  { return USLU; }
"+"                  { return ARTI; }
"-"                  { return EKSI; }
"*"                  { return CARPI; }
"/"                  { return BOLU; }
"("                  { return SOLPAR; }
")"                  { return SAGPAR; }
\n                   { return '\n'; }
[ \t]+               { /* boşlukları pass gec*/ }
.                    { 
                       yyerror("geçersiz karakter girildi"); 
                       return 0; 
                     }
%%

int yywrap(void) { return 1; }