# calculator
Esmanur Ulu 231101024
o Implement support for floating-point numbers. ->[0-9]+(\.[0-9]+)?    { yylval.sayi = atof(yytext); return SAYI; }(\.[0-9]+)? Ondalık kısım
atof(yytext) burası da double sayılar için.
 o Extend the grammar to handle exponentiation (^ or **) and handle error reporting for 
invalid expressions. üs alma işlemi lex -> "**"                 { return USLU; }
"^"                  { return USLU; } 

üs alma işlemi yacc -> | ifade USLU ifade   { $$ = us_al($1, $3); } 

————

Compile komutları ödev dosyasındakilerle aynı: 
yacc -d calculator.y
lex calculator.l
gcc lex.yy.c y.tab.c -o hesap_makinesi

—-
	•	geçersiz bir karakter karakter → Geçersiz karakter
	•	mantık hatası. sıfıra bölme yapılamaz. → Sıfıra bölme hatası
——
exit yazılarak çıkılabilir.
