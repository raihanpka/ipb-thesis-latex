# Template Tugas Akhir Sarjana (S1) IPB University

[![LaTeX](https://img.shields.io/badge/LaTeX-pdfLaTeX-blue.svg)](https://www.latex-project.org/)
[![TeX Live](https://img.shields.io/badge/TeX%20Live-2024%2B-green.svg)](https://tug.org/texlive/)
[![MiKTeX](https://img.shields.io/badge/MiKTeX-supported-brightgreen.svg)](https://miktex.org/)
[![Overleaf](https://img.shields.io/badge/Overleaf-ready-brightgreen.svg)](https://www.overleaf.com/read/zcgrrzkfgkcw)
[![GitHub Stars](https://img.shields.io/github/stars/raihanpka/ipb-template-latex)](https://github.com/raihanpka/ipb-template-latex/stargazers)

Template LaTeX untuk penulisan skripsi dan tugas akhir program sarjana (S1) di
Institut Pertanian Bogor (IPB University). Template ini diadaptasi secara
penuh dari Template Word resmi PPKI (Pedoman Penulisan Karya Ilmiah) Edisi
ke-4. Pengaturan margin, font, penomoran, caption, dan format sitasi sudah
disesuaikan dengan dokumen `Template Tugas Akhir` resmi sesuai dengan Pedoman Penulisan Karya Ilmiah Edisi ke-4.

## Memulai

Cara termudah untuk menggunakan template ini:

1. **Fork** repositori ini di GitHub ke akun Anda.
2. **Clone** fork Anda ke komputer lokal.
3. **Isi** data Anda di `src/config/information.tex` (nama, NIM, judul,
   pembimbing, departemen, dan sebagainya).
4. **Tulis** skripsi Anda di `src/chapters/chapter-1.tex` sampai
   `chapter-5.tex` untuk bagian inti, dan folder lain untuk bagian
   awal serta bagian akhir.
5. **Build** PDF dengan `make` (lihat [Penggunaan](#penggunaan)), atau
   gunakan Overleaf dengan tautan di atas.

## Kebutuhan

Template ini membutuhkan distribusi LaTeX lengkap beserta paket-paket
pendukung biber, biblatex, dan chktex. Distribusi yang didukung:

- **macOS**: BasicTeX atau MacTeX
- **Windows**: MiKTeX atau TeX Live
- **Linux**: TeX Live (paket texlive-full atau texlive-latex-extra)
- **Web**: Overleaf (tidak perlu instalasi lokal)

Detail instalasi per platform tersedia di [GUIDE.md](GUIDE.md).

## Penggunaan

Template ini dilengkapi skrip kompilasi. Untuk build PDF:

Linux atau macOS:

```
make              Build PDF
make build        Build PDF (sama dengan default)
make clean        Hapus artefak atau file temporary hasil kompilasi LaTeX
make distclean    Hapus direktori build/ dan dist/
make validate     Validasi sumber LaTeX dengan chktex
make watch        Build ulang otomatis saat ada perubahan
make help         Tampilkan pesan bantuan
```

Windows:

```
make.bat
make.bat build
make.bat clean
make.bat distclean
make.bat validate
```

Tanpa Makefile:

```
latexmk -pdf src/main.tex
```

Nama PDF dihasilkan otomatis dari data di `src/config/information.tex`
dengan format `Skripsi_<ProgramStudiSingkat>_<NamaPenulis>_<Bulan Tahun>.pdf`.
Contoh: `Skripsi_Ilmu_Komputer_Raihan_Putra_Kirana_Jun_2026.pdf`.

Hasil kompilasi berada di `dist/`. File sementara latexmk di `build/`
(keduanya diabaikan oleh git).

## Struktur Proyek

```
ipb-template-latex/
|
+-- Makefile                    Target: build, clean, validate, dst.
+-- make.bat                    Wrapper Windows
+-- .chktexrc                   Konfigurasi chktex
+-- docs/                       Template Word resmi PPKI (referensi)
|   +-- Template Tugas Akhir.dotx
|   +-- Templat tugas akhir S1.docx
|
+-- scripts/                    Skrip pembantu
|   +-- spinner.sh              Animasi spinner
|   +-- extract-info.py         Ekstrak metadata untuk auto-naming
|
+-- src/
    +-- main.tex                Entry point LaTeX
    +-- config/                 Konfigurasi
    |   +-- ipb-thesis.sty      Style utama (margins, font, headings, captions)
    |   +-- information.tex     Data penulis, skripsi, institusi
    |   +-- hyphenation-id.tex  Aturan pemenggalan kata
    |
    +-- abstract/               Abstrak (id) dan Abstract (en)
    |   +-- abstract-id.tex
    |   +-- abstract-en.tex
    |
    +-- preliminaries/          Bagian Awal
    |   +-- cover.tex
    |   +-- pernyataan.tex
    |   +-- lembar-persetujuan.tex
    |   +-- prakata.tex
    |   +-- daftar-isi.tex
    |
    +-- chapters/               Bagian Inti (bab 1 s.d. bab 5)
    |   +-- chapter-1.tex
    |   +-- chapter-2.tex
    |   +-- chapter-3.tex
    |   +-- chapter-4.tex
    |   +-- chapter-5.tex
    |
    +-- backmatter/             Bagian Akhir
    |   +-- daftar-pustaka.tex
    |   +-- lampiran.tex
    |   +-- riwayat-hidup.tex
    |
    +-- refs/                   Database referensi BibTeX/biber
    |   +-- daftar-pustaka.bib
    |
    +-- resources/              Gambar, logo, dan sumber daya lain
        +-- ipb-logo.png
        +-- contoh-gambar1.jpg
        +-- contoh-gambar2.jpg
```

## Menulis Skripsi

- Setiap berkas `.tex` memiliki komentar header yang menjelaskan
  fungsinya.
- Atur judul, nama, NIM, pembimbing, departemen, dan data lain di
  `src/config/information.tex` (satu sumber kebenaran untuk semua
  halaman).
- Tulis isi bab di `src/chapters/chapter-N.tex`. Untuk menambah bab
  baru, buat berkas baru lalu tambahkan `\input{chapters/chapter-N}`
  di `src/main.tex`.
- Bab I sampai V sudah dilengkapi teks panduan PPKI IPB; ganti dengan
  isi sebenarnya saat menulis.
- Tambahkan referensi di `src/refs/daftar-pustaka.bib` dan sitasi
  dengan `\citep{key}` atau `\citet{key}`.

## Spesifikasi Format

Seluruh pengaturan berikut sudah diterapkan di `src/config/ipb-thesis.sty`
sesuai PPKI IPB Edisi ke-4 dan Template Word resmi.

| Elemen | Spesifikasi |
|---|---|
| Kertas | A4 (210 x 297 mm) |
| Margin atas, kanan, bawah | 3 cm |
| Margin dalam (binding) | 4 cm (3 cm + 1 cm gutter) |
| Mirror margins | Aktif (twoside) |
| Font teks | Times New Roman 12pt |
| Spasi teks | Tunggal (single spacing) |
| Indentasi awal paragraf | 1 cm |
| Jarak antar paragraf | 0 pt |
| Judul bab | 14pt, tebal, rata tengah, huruf kapital penuh |
| Judul subbab | 12pt, tebal, rata kiri |
| Judul sub-subbab | 12pt, tidak tebal, rata kiri |
| Penomoran bab | Angka Romawi kapital (I, II, III, IV, V) |
| Penomoran subbab | Angka Arab desimal (1.1, 1.2, 2.1, 2.2) |
| Penomoran sub-subbab | Angka Arab desimal (1.1.1) |
| Nomor halaman preliminary | Romawi kecil, posisi tengah atas |
| Nomor halaman isi | Arab, posisi sudut luar atas |
| Sitasi dan daftar pustaka | biblatex + biber, format PPKI |
| Bahasa utama | Indonesia, dengan dukungan Inggris |

## Kontribusi

Kontribusi berupa laporan masalah, saran perbaikan, maupun pull request
sangat disambut. Silakan baca [CONTRIBUTING.md](CONTRIBUTING.md) untuk
panduan singkat sebelum berkontribusi.

## Lisensi

Template ini dilisensikan di bawah [Lisensi MIT](LICENSE). Template Word
asli PPKI Edisi ke-4 merupakan milik **IPB University** dan diterbitkan
melalui dokumen PPKI. Template LaTeX ini merupakan hasil konversi dan
adaptasi mandiri yang tidak bersifat resmi dan tidak terafiliasi
dengan IPB University.

Lihat [GUIDE.md](GUIDE.md) untuk detail instalasi per platform,
troubleshooting, kustomisasi lanjutan, dan detail perubahan di
[CHANGELOG.md](CHANGELOG.md).

## Kredit dan Atribusi

Template Word asli merupakan milik **IPB University** dan diterbitkan
melalui IPB Press yang dapat diakses melalui Simak IPB.
Template LaTeX ini merupakan hasil konversi dan adaptasi mandiri yang
tidak bersifat resmi dan tidak terafiliasi dengan IPB University.

**Kontributor:**
- *Raihan Putra Kirana* - Github: [@raihanpka](https://github.com/raihanpka)
- *Mochamad Chairulridjal Nurvikri* - Github: [@chairulridjal](https://github.com/chairulridjal)

**Atribusi tambahan:**
- Berkas CSL di `src/refs/ipb.csl` dan `src/refs/ipb-en.csl` (untuk pengguna Pandoc/citeproc) diadaptasi dari [auriza/csl-ipb](https://github.com/auriza/csl-ipb) karangan *Pak Auriza Rahmad Akbar* ([@auriza](https://github.com/auriza)). CSL ini menjadi acuan untuk pemformatan daftar pustaka dan sitasi sesuai PPKI IPB Edisi ke-4 dalam template ini.
- Struktur proyek terinspirasi dari *Petra Novandi* dengan Github: [petrabarus/if-itb-latex](https://github.com/petrabarus/if-itb-latex).

Jika template ini bermanfaat untuk penelitian atau penulisan skripsi
Anda, silakan berikan bintang (star) pada repositori ini sebagai bentuk
apresiasi. Kontribusi berupa laporan masalah (issue), saran perbaikan,
maupun pull request sangat disambut.
