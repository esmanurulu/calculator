
# Basit Hesap Makinesi // 

**esmanur ulu 231101024**

Bu proje, Lex ve Yacc kullanılarak geliştirilmiş basit bir hesap makinesi uygulamasıdır. Proje iki dosyadan oluşur:

- **calculator.l**: Lex dosyası – giriş (input) karakterlerini tarar ve tanımlı token'lara dönüştürür.
- **calculator.y**: Yacc dosyası – hesap makinesinin dilbilgisini (grammar) tanımlar ve hesaplamaları gerçekleştirir.

---

## Dosyaların İşlevleri

### Lex Dosyası (calculator.l)

- **Sayı Tanımlama:**
  - `[0-9]+(\.[0-9]+)?` ifadesiyle hem tamsayı hem de ondalıklı sayıları yakalar.
  - Yakalanan sayı, `atof(yytext)` ile `double` tipine dönüştürülür ve `SAYI` token'ı olarak döndürülür.

- **Anahtar Kelimeler ve Operatörler:**
  - `"exit"`: Programdan çıkmak için `EXIT` token'ı döndürülür.
  - `"**"` ve `"^"`: Üs alma işlemini temsil eden `USLU` token'ı döndürülür.
  - `"+"`, `"-"`, `"*"`, `"/"`: Toplama, çıkarma, çarpma ve bölme işlemleri için ilgili token'lar (`ARTI`, `EKSI`, `CARPI`, `BOLU`) döndürülür.
  - `"("` ve `")"`: Parantez açma ve kapama işlemleri için (`SOLPAR`, `SAGPAR`) token'lar döndürülür.

- **Hata Yönetimi:**
  - Tanımlı olmayan karakterler için `yyerror("geçersiz karakter girildi")` çağrılır ve hata mesajı basılır.
  -   Sıfıra bölme hatası kontrol edilir.

- **Diğer:**
  - `yywrap()` fonksiyonu, dosya sonuna gelindiğinde Lex tarayıcısının durması için `1` döndürür.

---

### Yacc Dosyası (calculator.y)

- **Token Tanımlamaları:**
  - Lex dosyasından gelen token'lar (`SAYI`, `ARTI`, `EKSI`, `CARPI`, `BOLU`, `USLU`, `SOLPAR`, `SAGPAR`, `EXIT`) kullanılır.
  - `union` yapısı sayesinde `SAYI` token'ı bir `double` olarak saklanır.

- **Gramer Kuralları:**
  - **Aritmetik İşlemler:** Toplama, çıkarma, çarpma ve bölme işlemleri için ilgili kurallar tanımlanmıştır.
  - **Bölme İşlemi:** Bölme işlemi sırasında, bölen 0 ise hata mesajı basılır ve program sonlandırılır.
  - **Üs Alma İşlemi:** İki sayı arasındaki üs alma işlemi `us_al()` fonksiyonu kullanılarak gerçekleştirilir.
  - **Parantez Kullanımı:** İfadelerin parantez içindeki hesaplanmasını sağlar.
  - **Sayı İşlemleri:** Tek başına sayı olan ifadeler doğrudan döndürülür.

- **Giriş (Parser) Yapısı:**
  - **giris** kuralı, kullanıcıdan alınan her satırdaki ifadeyi değerlendirir.
  - `exit` komutu girildiğinde, program "Çıkılıyor..." mesajı vererek sonlanır.
  - Hatalı ifadeler girildiğinde `yyerrok;` ifadesiyle hata atlatılır.

- **Destek Fonksiyonlar:**
  - `us_al(double taban, double us)`: Verilen taban ve üs değerlerine göre üs alma işlemi yapar.
  - `yyerror(const char *s)`: Hata mesajlarını ekrana basar.
  - `main()`: Hesap makinesini başlatır ve kullanıcıdan giriş alır.

---

## Derleme ve Çalıştırma

Projenin derlenmesi ve çalıştırılması için aşağıdaki adımlar izlenir:

1. **Yacc Derlemesi:**
   ```bash
   yacc -d calculator.y
 - Bu komut `y.tab.c` ve `y.tab.h` dosyalarını üretir.
     
    
   
    
2.  **Lex Derlemesi:**
    

	`lex calculator.l` 
   
   -   Bu komut `lex.yy.c` dosyasını üretir.
       
3.  **GCC ile Bağlama:**

   `gcc lex.yy.c y.tab.c -o hesap_makinesi` 
   
   -   Bu komut, `hesap_makinesi` isimli çalıştırılabilir dosyayı oluştur


## **Başlatma**:
    
    ./hesap_makinesi
## Kullanım

-   **Giriş Formatı**: İşlemler satır satır girilir. Her satır sonunda  `Enter`  tuşlanır.
**Örnekler**:
 3 + 5 * 2           → Sonuç: 13.00
(4 - 1) ** 3        → Sonuç: 27.00
10 / 2              → Sonuç: 5.00
7.5 / 0             → Hata: "işlem hatası.Sıfıra bölünmez"
exit                → Program sonlanır.

## 🚨 Hata Mesajları



`5 % 2`

`geçersiz karakter girildi`



`10 / 0`

`işlem hatası.Sıfıra bölünmez`
