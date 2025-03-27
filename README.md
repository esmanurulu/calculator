# calculator
Esmanur Ulu 231101024
<br />
<br />

o Implement support for floating-point numbers. ->[0-9]+(\.[0-9]+)?    { yylval.sayi = atof(yytext); return SAYI; }
<br />
(\.[0-9]+)? Ondalık kısım
<br />
atof(yytext) burası da double sayılar için.
<br />
<br />
. 
<br />
üs alma işlemi lex -> "**"                
             <br />
üs alma işlemi yacc -> | ifade USLU ifade   { $$ = us_al($1, $3); } 
<br />
————
<br />
Compile komutları ödev dosyasındakilerle aynı: 
yacc -d calculator.y
lex calculator.l
gcc lex.yy.c y.tab.c -o hesap_makinesi

<br />
error handling
	•	geçersiz bir karakter → Geçersiz karakter
 <br />
	•	mantık hatası. sıfıra bölme yapılamaz. → Sıfıra bölme hatası
——
exit yazılarak çıkılabilir.
