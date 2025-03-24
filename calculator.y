%{
#include <stdio.h>
#include <stdlib.h>

double us_al(double taban, double us) {
    double sonuc = 1;
    for(int i=0; i<us; i++) sonuc *= taban;
    return sonuc;
}

void yyerror(const char *s);
int yylex(void);
%}

%union {
    double sayi;
}

%token EXIT           
%token <sayi> SAYI
%token ARTI EKSI CARPI BOLU USLU SOLPAR SAGPAR

%type <sayi> ifade

%left ARTI EKSI
%left CARPI BOLU
%right USLU

%%

giris:
    | giris ifade '\n' { printf("Sonuç: %.2f\n", $2); }
    | giris EXIT '\n'  { printf("Çıkılıyor...\n"); exit(0); } 
    | giris '\n'      { }
    | giris error '\n' { yyerrok; }
    ;

ifade:
      ifade ARTI ifade    { $$ = $1 + $3; }
    | ifade EKSI ifade    { $$ = $1 - $3; }
    | ifade CARPI ifade   { $$ = $1 * $3; }
    | ifade BOLU ifade    { 
                             if($3 == 0) { 
                                yyerror("işlem hatası.Sıfıra bölünmez"); 
                                exit(1); 
                             } 
                             $$ = $1 / $3; 
                           }
    | ifade USLU ifade   { $$ = us_al($1, $3); }
    | SOLPAR ifade SAGPAR { $$ = $2; }
    | SAYI                { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    printf("hata algılandı: %s\n", s);
}

int main(void) {
    printf("Basit Hesap Makinesi (Çıkmak için 'exit' yazın)\n"); 
    yyparse();
    return 0;
}