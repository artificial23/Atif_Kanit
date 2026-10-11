# AtıfKanıt — Doçentlik ve Akademik Teşvik için Atıf Tespit ve Kanıt Paketi Üreticisi

Yayınlarınıza (ilk / ortak / son / sorumlu yazar olduğunuz tüm eserler) gelen atıfları **Web of Science, Scopus, Google Scholar,
ResearchGate, DergiPark / TR Dizin, OpenAlex, OpenCitations, Semantic Scholar** üzerinden toplar; ÜAK doçentlik ve Akademik Teşvik
kurallarına göre sınıflandırır; her atıf için **4 parçalı vurgulu kanıt görseli + birleşik PDF** ve kümülatif
**Atif_Ana_Takip_Tablosu.xlsx** üretir. Birden fazla akademisyen kendi profiliyle kullanabilir.

> ⚠️ Karar destek aracıdır. Nihai değerlendirme jüri/komisyona aittir. Puan tabloları temel alana ve döneme göre değişir;
> `kurallar.yaml` içindeki puanlar **örnek şablondur**, kendi temel alanınızın güncel ÜAK tablosuyla doğrulayın.

---

## 1. Kurulum (bir kez)

Gereken: **Python 3.10+** (python.org). Ardından klasördeki başlatıcıya çift tıklayın:

| Sistem | Dosya |
|---|---|
| Windows | `Baslat_Windows.bat` |
| macOS | `Baslat_Mac.command` (ilk seferde sağ tık → Aç) |
| Linux | `./baslat_linux.sh` |

Başlatıcı sanal ortam kurar, bağımlılıkları yükler, Chromium'u (ekran görüntüleri için) indirir ve **web arayüzünü** açar.

Elle kurulum:
```bash
python -m venv .venv && source .venv/bin/activate      # Windows: .venv\Scripts\activate
pip install -e .                                        # veya: pip install -r requirements.txt
python -m playwright install chromium
atifkanit init        # profil sihirbazı
atifkanit arayuz      # web arayüzü  (veya komut satırı: atifkanit calistir)
```

İnternetsiz deneme (tamamen **kurgusal** verilerle örnek arşiv üretir):
```bash
atifkanit demo --klasor ~/AtifKanit_Demo
```

## 2. Hızlı başlangıç

1. **Profil**: unvanınızı (Öğr. Gör. / Dr. Öğr. Üyesi / Doç. Dr. / Prof. Dr.) ve **ÜAK temel alanınızı** listeden seçin.
   Seçiminize göre geçerli kurallar (doçentlik atıf puanları, asgari/azami, teşvik grubu A1–A4, alanınıza özgü kanıt notları)
   ekranda gösterilir ve tüm hesaplar buna göre yapılır. Ardından ad, soyad, ORCID, doktora tarihi, (varsa) Google Scholar profil kimliği.
2. **Pano → Otomatik taramayı başlat**: eserleriniz ORCID'den, atıflar açık veritabanlarından bulunur (anahtar gerekmez).
3. **Atıf Tarama → Tarayıcıyı aç**: Scopus, Web of Science ve Google Scholar kurum erişiminizle açılır; sağ alttaki
   AtıfKanıt kutusu adımları gösterir. *Dışa aktar*'a bastığınız dosyalar ve açtığınız Scholar *Alıntılanma* sayfaları
   otomatik işlenir. Bitince tarayıcıyı kapatın.
4. **Atıflar**: sınıflandırmayı gözden geçirin; yanlışları tabloda düzeltin (düzeltmeler kalıcıdır).
5. **Kanıt Üret** → **Rapor & İndir**.

Komut satırında: `atifkanit calistir` (otomatik kısım) ve `atifkanit rehberli` (Scopus/WoS/Scholar).

### Unvan ve temel alana göre değişenler (`alanlar.yaml`)
| | |
|---|---|
| **Doçentlik — Atıflar maddesi** | Doktora sonrası eserlerinize yapılan atıflardan en az 5, en fazla 10 puan. SCIE/SSCI/AHCI/ESCI/Scopus 3 • BKCI kitap 2 • TR Dizin 2 • diğer kitap/dergi 1 |
| **Teşvik grupları** | A1: Eğitim, Fen, Mühendislik, Sağlık, Ziraat • A2: Filoloji, Hukuk, İlahiyat, Sosyal, Spor • A3: Mimarlık • A4: Güzel Sanatlar |
| **Teşvik atıf puanı** | A1: SCI/SSCI/AHCI 4, ESCI/Scopus/TR Dizin/diğer uluslararası 1, uluslararası yayınevi kitabı 4 • A2–A4: 6 / 2 / 8; tavan 30 |
| **Unvan** | Dr. Öğr. Üyesi: doçentlik + teşvik • Öğr. Gör.: teşvik (doktoralıysa doçentlik de) • Doç. Dr./Prof. Dr.: teşvik (doçentlik bilgi amaçlı) |
| **Alan notları** | Hukuk/İlahiyat/Filoloji: kitap ve dipnot atıfları; Sağlık: Vancouver/üst simge; Güzel Sanatlar/Mimarlık: katalog-sergi atıfları (doğrulama önerilir) |

Değerler ikincil kaynak özetlerinden derlenmiştir; ÜAK'ın güncel temel alan tablosuyla farklıysa `alanlar.yaml`'ı düzeltin.

## 3. Mevzuat kuralları nasıl uygulanıyor?

| Kural | Uygulama |
|---|---|
| **1 — Öz-atıf (çift yönlü)** | Atıf yapan eserin yazarları, eserinizin **tüm yazar listesiyle** karşılaştırılır. Siz varsanız `Öz-Atıf (Birincil)`, ortak yazarlarınızdan biri varsa `Şüpheli (Ortak Yazar)`, yoksa `Bağımsız`. Eşleştirme önce **ORCID / OpenAlex kimliği**, yoksa Türkçe karakter duyarlı *soyad + başharf* (ı/i, ş/s, ğ/g…). ORCID'ler farklıysa aynı isim bile eşleşmez. |
| **2 — Tek makale = tek atıf** | (Eserim, atıf yapan eser) çifti veritabanında tektir. Metin içindeki tüm geçişler kanıtta vurgulanır, tabloda 1 satırdır. Farklı kaynaklardan gelen aynı kayıt ve **preprint + dergi sürümü** birleştirilir/işaretlenir. Bir makale iki ayrı eserinize atıf yapıyorsa 2 satırdır (ÜAK: "atıf yapılan her eseri için"). |
| **3 — İndeks hiyerarşisi + Delisted** | SCI/SCI-E > SSCI/AHCI > ESCI > Scopus > TR Dizin > Uluslararası Diğer > Ulusal/Kitap/Diğer. Kategori **atıfın yayımlandığı yıla** göre belirlenir (bkz. §5). Atıf yılından sonra indeksten çıkan dergi `Şüpheli: sonradan Delisted`, önce çıkmışsa `Delisted — atıf tarihinde indeks dışı`. |
| **4 — Teşvik yılı / doktora** | Teşvik faaliyet yılı = başvuru yılı − 1. **Erken görünüm** atıflar, künyesini (cilt/sayı/sayfa) aldığı yılda sayılır. Doktora sonrası = **atıf alan eserinizin** yayım tarihi > doktora mezuniyet tarihi (ÜAK asgari şartı doktora sonrası eserlere yapılan atıflarla sağlanır; tezden üretilen eserler *Eserlerim*'de işaretlenebilir). Atıfın kendi tarihi ayrı sütunda. |
| **5 — Eser türü** | Makale / Kitap / Kitap Bölümü / Bildiri / Tez / Erken Görünüm (+ Preprint, Erratum, Çeviri). Tez, preprint, erratum, çeviri → *Puan Harici / Bilgilendirme*. |

### Eklediğim kontroller
- **"et al." sorunu**: Kaynakçada liste kısaltıldığı için "Teke" hiç geçmeyebilir. Kaynakça girdisi **başlık benzerliği + DOI + ilk yazar soyadı + yıl + cilt/sayfa** puanlamasıyla bulunur; yalnız ilk yazar+yıl eşleşirse düşük güven uyarısı verilir.
- **Teşvik**: devlet üniversitesinde üretilmemiş eserlere gelen atıflar, çeviriler, öz-atıflar, tezler otomatik "Hayır" + gerekçe.
- **Geri çekilmiş (retracted)** atıf yapan eser uyarısı; Google Scholar kaynaklı kayıtlar "doğrulama gerekli".
- **İndeks kanıt zinciri + güven düzeyi** (hangi listeden/kayıttan, hangi yılın listesiyle belirlendiği).
- **Kanıt bütünlüğü**: kaynak PDF'in SHA-256 özeti ve erişim tarihi kapakta; otomatik üretilen bilgi kartları açıkça "resmi görüntü değil" diye etiketlenir.
- **Elle düzeltme katmanı**: Excel'de veya arayüzde yaptığınız düzeltmeler sonraki otomatik taramalarda **ezilmez**; otomatik değere geri dönmek mümkündür.
- **Kontrol Listesi** sayfası: gözle bakılması gereken her şey tek yerde.
- **Özet** sayfası: kategori × öz-atıf durumu, doktora sonrası geçerli atıflar, teşvik yılı, tavanlı tahmini puanlar (formüllü).

## 4. Veri kaynakları — API anahtarı gerekmez

| Kaynak | Nasıl? | Sizin yapmanız gereken |
|---|---|---|
| OpenAlex, OpenCitations, Semantic Scholar, Crossref, Unpaywall | Tamamen otomatik | Hiçbir şey |
| **Web of Science** | Rehberli tarayıcı: `AI=(ORCID)` araması → Citation Report → Citing articles → Export (Tab delimited, Full Record + Cited References) | Kurum erişimi + 4 tıklama; dosya otomatik işlenir. `WE` alanı atıf yılındaki indeksi verir |
| **Scopus** | Rehberli tarayıcı: `ORCID(...)` → All → View cited by → Export CSV (References işaretli) | Kurum erişimi + 4 tıklama |
| **Google Scholar** | Rehberli tarayıcı: profilinizden *Alıntılanma* sayfalarını açarsınız, program ekrandakileri kaydeder | Sayfaları gezmek (Google doğrulama sorarsa işaretlemek) |
| ResearchGate / DergiPark / TR Dizin / kitaplar | `sablonlar/manuel_atif_sablonu.csv` | Gerekirse elle ekleme |
| Scopus dergi listesi | Elsevier'in herkese açık aylık listesi otomatik indirilir | Hiçbir şey |
| WoS dergi listeleri (MJL) | Rehberli tarayıcıda "WoS dergi listeleri" | Ücretsiz Clarivate hesabıyla yılda bir indirme |

**Neden Scopus/WoS/Scholar tam otomatik değil?** Bu servislerin web arayüzlerini robotla taramak kullanım koşullarına
aykırıdır, CAPTCHA/IP engeliyle sonuçlanır ve kurum aboneliğini riske atar. Anahtarsız yasal yol, sorguları sizin
oturumunuzda sizin başlatmanızdır; program geri kalan her şeyi (eşleştirme, tekilleştirme, sınıflandırma, kanıt, Excel) yapar.
Kurumunuz Scopus/WoS API anahtarı verirse *Profil → Gelişmiş ayarlar*'a girerek bu adımı da tamamen otomatikleştirebilirsiniz.

### İndeks nasıl belirleniyor? (SCI dergisinin "Uluslararası Diğer" görünmemesi için)
Bir atıfın kategorisi şu kanıtlardan biriyle belirlenir; hiçbiri yoksa **"Belirlenemedi"** yazılır ve satır
"WoS Doğrulaması: Doğrulanmadı" olarak işaretlenir — program artık tahminle "Uluslararası Diğer" demez.
1. WoS dışa aktarımındaki `Web of Science Index` alanı (atıf yapan makalenin o yılki indeksi — en güçlü kanıt)
2. Aynı derginin aynı yıldaki gözlemi: WoS'tan gelen başka bir kayıt veya **AVESIS**'teki yayınlarınızın dergi indeksleri
3. WoS Master Journal List yıllık listeleri, Scopus kaynak listesi, **SCImago** (Scopus + SJR quartile), TR Dizin listesi
4. "Uluslararası Diğer" yalnızca derginin WoS'ta **ve** Scopus'ta olmadığı biliniyorsa verilir (ör. WoS "citing articles"
   dışa aktarımında bulunmayan, yeterince eski kayıt + Scopus listesinde olmayan dergi)

**AVESIS**: Profilde AVESIS adresinizi girin (ör. `https://avesis.cbu.edu.tr/ad.soyad`). Program yayın sayfalarınızdan
"Derginin Tarandığı İndeksler", quartile (gösteriliyorsa), WoS numarası, DOI ve ISSN'i alır; Eserlerim'e yazar ve aynı
dergilerdeki atıfları sınıflamak için kullanır. AVESIS atıf yapan yayınları listelemediği için atıfların kendisi yine
WoS/Scopus/Scholar'dan gelir. **Quartile**: atıf yapan dergiler için SCImago (SJR) yıllık listesi otomatik indirilir;
kendi eserleriniz için AVESIS'teki değer gösterilir.

## 5. İndeks listeleri (atıf yılındaki indeks)

Arşivinizdeki `indeks_listeleri/` klasörüne koyun (ayrıntı: `indeks_listeleri/OKUBENI.md`):
- `wos/2024_SCIE.csv`, `wos/2024_ESCI.csv` … — Master Journal List indirmeleri (her yıl için; dosya adında **yıl** ve **koleksiyon**)
- `wos/wos_delisted.csv` — Clarivate'in aylık çıkarılan dergiler listesi
- `scopus/` — Scopus Source List xlsx + Discontinued Titles
- `trdizin/` — TR Dizin dergi listesi (ISSN + yıllar)
- `manuel_indeks.csv` — kendi/komisyon kararlarınız (en yüksek öncelik)

Liste yoksa program kayıt düzeyi verilerle (WoS `WE`, Scopus kaydı) çalışır ve düşük güvenli satırları Kontrol Listesine yazar.

## 6. Kanıt paketi

Her atıf klasöründe:
```
01_Makale_Kunyesi.png        ilk sayfa: dergi, başlık, yazarlar, DOI, ISSN, cilt sarı vurgulu + kırmızı çerçeve
02_Indeks_Kaniti.png         WoS kayıt sayfası "Web of Science Index" / MJL / Scopus / TR Dizin ekran görüntüsü
02b_Indeks_Dogrulama_Karti.png  atıf yılına göre indeks kanıt zinciri (her zaman)
03_Metin_Ici_Atif.png        atıf cümlesi sarı, atıf anahtarı ([18], ¹⁸, Yılmaz et al., 2023) kırmızı çerçeve — tüm geçişler
04_Kaynakca_Goruntusu.png    kaynakçadaki künyeniz
Birlestirilmis_Kanit.pdf     kapak (özet tablo + SHA-256) + tüm görseller, optimize JPEG
kaynak.pdf                   atıf yapan eserin tam metni
```
**PDF bulunamazsa** (abonelikli dergi): makaleyi kurum erişiminizle indirip klasöre `kaynak.pdf` adıyla koyun (veya arayüzden yükleyin),
`atifkanit kanit --id ATIF-…` çalıştırın. Kurumsal oturum gereken sayfalar için bir kez `atifkanit tarayici-giris` ile giriş yapın.
Resmi indeks ekran görüntüsünü kendiniz alırsanız `02_Indeks_Kaniti.png` adıyla koyun — program korur ve PDF'e ekler.

## 7. Klasör yapısı

```
Docentlik_Atif_Arsivi/
├── Atif_Ana_Takip_Tablosu.xlsx      (Atıflar | Özet | Eserlerim | Kontrol Listesi | Açıklamalar)
├── indeks_listeleri/ ...
└── Yayin_Y001_Ilk_Yazar_Kisa_Baslik/
    ├── Metadata.json                (tam künye + tüm ortak yazarlar + ORCID'ler)
    └── Atif_ATIF-2025-001_Yilmaz_2025/ ...
```

## 8. Komutlar

```
atifkanit init | profil | eserler [--ekle DOI.. | --haric Y003 | --devlet-degil Y004]
atifkanit tara | zenginlestir | siniflandir
atifkanit ice-aktar DOSYA --tur wos|scopus|pop|manuel [--eser Y003] [--hedef eser]
atifkanit kanit [--id ATIF-2025-001 ..] [--yeniden] [--tarayicisiz]
atifkanit excel | excel-oku [DOSYA] | duzelt ATIF-ID alan=değer
atifkanit calistir | rehberli [--hedef wos scopus scholar mjl] | indeks-guncelle
atifkanit rapor | arayuz | tarayici-giris | sablonlar | demo
--profil AD   (çok kullanıcı: her kullanıcı ~/.atifkanit/profiller/AD.yaml)
```

## 9. Sorun giderme
- **`ModuleNotFoundError: No module named 'yaml'`** (veya başka bir modül): kütüphaneler kurulmamış. Başlatıcıyı
  (`Baslat_Windows.bat`) tekrar çalıştırın — her açılışta eksikleri denetler ve kurar. Olmazsa `.venv` klasörünü silip
  tekrar çalıştırın. Kurulum hatası olursa ayrıntı `kurulum_log.txt` dosyasındadır.
- **Kurulum ağ hatası veriyor**: kurum ağı/proxy pip'i engelliyor olabilir; farklı bir ağda (ör. ev / telefon) deneyin.
- **Python 3.15 gibi çok yeni sürümler**: bazı kütüphanelerin henüz hazır paketi olmayabilir; Python 3.12 kurun
  (başlatıcı varsa 3.13/3.12/3.11'i otomatik tercih eder).

## 10. Bilinen sınırlamalar
- Taranmış (görüntü) PDF'lerde metin katmanı yoktur; OCR'lı sürümü `kaynak.pdf` olarak koyun.
- MJL / Scopus / WoS sayfaları bot koruması veya giriş gerektirebilir; ekran görüntüsü alınamazsa doğrulama kartı üretilir ve "Kanıt Durumu" sütununda belirtilir.
- Çok sütunlu, alışılmadık kaynakça biçimlerinde girdi sınırları kayabilir; düşük güvenli eşleşmeler Kontrol Listesine düşer.
- Tarihsel indeks listeleri kullanıcı tarafından sağlanmalıdır (MJL indirmeleri Clarivate hesabı gerektirir).

## 11. Mevzuat dayanakları (özet)
- ÜAK Doçentlik Başvuru Şartları (temel alan tabloları, uak.gov.tr): adayın yazar olarak yer almadığı yayınlardaki atıflar, metin içindeki atıf sayısına bakılmaksızın atıf yapılan her eser için bir kez.
- Akademik Teşvik Ödeneği Yönetmeliği md. 7(8) ve Tablo-4; üniversite SSS'leri: öz-atıf, tez, çeviri hariç; erken görünüm künye yılında; aynı eserde birden fazla atıf tek; devlet yükseköğretim kurumu şartı.
