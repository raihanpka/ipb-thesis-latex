# Template Tugas Akhir Sarjana (S1) IPB University

[![LaTeX](https://img.shields.io/badge/LaTeX-LuaLaTeX-blue.svg)](https://www.latex-project.org/)
[![TeX Live](https://img.shields.io/badge/TeX%20Live-2024%2B-green.svg)](https://tug.org/texlive/)
[![MiKTeX](https://img.shields.io/badge/MiKTeX-supported-brightgreen.svg)](https://miktex.org/)
[![Overleaf](https://img.shields.io/badge/Overleaf-ready-brightgreen.svg)](https://www.overleaf.com/read/zcgrrzkfgkcw)
[![GitHub Stars](https://img.shields.io/github/stars/raihanpka/ipb-thesis-latex)](https://github.com/raihanpka/ipb-thesis-latex/stargazers)

Template LaTeX untuk penulisan skripsi dan tugas akhir program sarjana (S1) di
Institut Pertanian Bogor (IPB University), khususnya rumpun Sains, Teknik, dan
Kesehatan. Template ini mengikuti **Pedoman Penyajian Tugas Akhir (PPTA) IPB
2026** dan templat resmi `Skripsi Sain-Tek-Kes [20260812].dotx`. Pengaturan
margin, font, penomoran, caption, bagian awal, dan format sitasi telah
disesuaikan dengan acuan terbaru tersebut.

Template LaTeX ini merupakan adaptasi mandiri dan bukan produk resmi IPB
University. Jika terdapat perbedaan, pedoman dan templat resmi yang berlaku
menjadi acuan utama.

## Memulai

Cara termudah untuk menggunakan template ini:

1. **Fork** repositori ini di GitHub ke akun Anda.
2. **Clone** fork Anda ke komputer lokal.
3. **Isi** data Anda di `src/config/information.tex` (nama, NIM, judul,
   pembimbing, departemen, dan sebagainya).
4. **Ganti** teks panduan pada `src/preliminaries/`, `src/abstract/`,
   `src/chapters/`, dan `src/backmatter/` dengan isi skripsi Anda.
5. **Build** PDF dengan `make` (lihat [Penggunaan](#penggunaan)), atau
   gunakan Overleaf dengan tautan di atas.

## Kebutuhan

Template ini membutuhkan distribusi LaTeX lengkap dengan LuaLaTeX, `latexmk`,
`biber`, dan paket-paket yang tercantum dalam `src/config/ipb-thesis.sty`.
`chktex` diperlukan untuk validasi. Distribusi yang didukung:

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
latexmk -lualatex -output-directory=build src/main.tex
```

Nama PDF dihasilkan otomatis dari data di `src/config/information.tex`
dengan format `Skripsi_<ProgramStudiSingkat>_<NamaPenulis>_<Bulan Tahun>.pdf`.
Contoh: `Skripsi_Ilmu_Komputer_Raihan_Putra_Kirana_Jun_2026.pdf`.

Hasil kompilasi bernama otomatis berada di `dist/`. Salinan hasil terbaru juga
ditulis ke `main.pdf` agar tetap kompatibel dengan struktur repositori asli.
File sementara latexmk berada di `build/`; `build/` dan `dist/` diabaikan oleh
Git.

## Struktur Proyek

```
ipb-thesis-latex/
|
+-- Makefile                    Target: build, clean, validate, dst.
+-- make.bat                    Wrapper Windows
+-- .chktexrc                   Konfigurasi chktex
+-- main.pdf                    Salinan hasil build terbaru
+-- ipb.bst                     Kompatibilitas BibTeX lama
+-- ipb.csl                     Kompatibilitas citeproc lama
+-- chapters/                   Kompatibilitas struktur repositori asli
|   +-- cover_dalam.tex
|   +-- hak_cipta.tex
|   +-- tim_penguji.tex
|
+-- docs/                       Arsip dokumen referensi struktur upstream
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
    |   +-- indonesian.lbx      Lokalisasi BibLaTeX Bahasa Indonesia
    |
    +-- abstract/               Abstrak (id) dan Abstract (en)
    |   +-- abstract.tex        Penggabung kedua bahasa pada satu halaman
    |   +-- abstract-id.tex
    |   +-- abstract-en.tex
    |
    +-- preliminaries/          Bagian Awal
    |   +-- cover.tex
    |   +-- pernyataan.tex
    |   +-- sorotan.tex
    |   +-- abstrak-grafis.tex
    |   +-- tim-penguji.tex
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
    |   +-- ipb.csl
    |   +-- ipb-en.csl
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
- Nilai bawaan berupa placeholder seperti `Nama Penulis`, `NIM`, `20XX`, dan
  `Nama Pembimbing 1`; ganti seluruh placeholder sebelum naskah diserahkan.
- Tulis isi bab di `src/chapters/chapter-N.tex`. Untuk menambah bab
  baru, buat berkas baru lalu tambahkan `\input{chapters/chapter-N}`
  di `src/main.tex`.
- Sorotan, abstrak grafis, abstrak dwibahasa, Bab I sampai V, tabel, gambar,
  daftar pustaka, lampiran, dan Riwayat Hidup telah dilengkapi teks panduan
  dari DOTX resmi; ganti dengan isi sebenarnya saat menulis.
- Tambahkan referensi di `src/refs/daftar-pustaka.bib` dan sitasi
  dengan `\citep{key}` atau `\citet{key}`.
- Salinan lokal pedoman, kumpulan DOTX, dan PDF pembanding dapat digunakan
  untuk audit format. Path referensi terbaru tersebut dicantumkan dalam
  `.gitignore` agar tidak ikut masuk ke repositori.

## Spesifikasi Format

Seluruh pengaturan berikut sudah diterapkan di `src/config/ipb-thesis.sty`
sesuai PPTA IPB 2026 dan templat `Skripsi Sain-Tek-Kes [20260812].dotx`.

| Elemen | Spesifikasi |
|---|---|
| Kertas | A4 (210 x 297 mm) |
| Margin | sisi dalam 4 cm; sisi luar, atas, dan bawah 3 cm |
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
| Nomor halaman bagian awal | Hitungan Romawi dimulai dari Sorotan; tidak dicetak |
| Nomor halaman isi/akhir | Arab di sudut luar atas; disembunyikan pada pembuka bagian |
| Pembukaan bagian | Bab dan bagian besar dimulai pada halaman ganjil |
| Daftar ilustrasi | Daftar tabel/gambar/lampiran muncul jika jumlahnya lebih dari satu |
| Sitasi dan daftar pustaka | BibLaTeX + biber, Harvard nama–tahun/CSE edisi ke-9 |
| Bahasa utama | Indonesia, dengan dukungan Inggris |
| Compiler utama | LuaLaTeX |

## Kontribusi

Kontribusi berupa laporan masalah, saran perbaikan, maupun pull request
sangat disambut. Silakan baca [CONTRIBUTING.md](CONTRIBUTING.md) untuk
panduan singkat sebelum berkontribusi.

## Lisensi

Template ini dilisensikan di bawah [Lisensi MIT](LICENSE). Pedoman dan templat
Word resmi merupakan milik **IPB University**. Template LaTeX ini merupakan
hasil konversi dan adaptasi mandiri yang tidak bersifat resmi dan tidak
terafiliasi dengan IPB University.

Lihat [GUIDE.md](GUIDE.md) untuk detail instalasi per platform,
troubleshooting, kustomisasi lanjutan, dan detail perubahan di
[CHANGELOG.md](CHANGELOG.md).

## Kredit dan Atribusi

Pedoman dan templat Word asli merupakan milik **IPB University**.
Template LaTeX ini merupakan hasil konversi dan adaptasi mandiri yang
tidak bersifat resmi dan tidak terafiliasi dengan IPB University.

**Kontributor:**
- *Raihan Putra Kirana* - Github: [@raihanpka](https://github.com/raihanpka)
- *Mochamad Chairulridjal Nurvikri* - Github: [@chairulridjal](https://github.com/chairulridjal)
- *Ghiffari Bravia Hisham* - Github: [@ghiffaribraviah](https://github.com/ghiffaribraviah)

**Atribusi tambahan:**
- Berkas CSL di `src/refs/ipb.csl` dan `src/refs/ipb-en.csl` (untuk pengguna Pandoc/citeproc) diadaptasi dari [auriza/csl-ipb](https://github.com/auriza/csl-ipb) karangan *Pak Auriza Rahmad Akbar* ([@auriza](https://github.com/auriza)). Berkas tersebut telah diselaraskan dengan aturan jumlah penulis PPTA 2026.
- Struktur proyek terinspirasi dari *Petra Novandi* dengan Github: [petrabarus/if-itb-latex](https://github.com/petrabarus/if-itb-latex).

Jika template ini bermanfaat untuk penelitian atau penulisan skripsi
Anda, silakan berikan bintang (star) pada repositori ini sebagai bentuk
apresiasi. Kontribusi berupa laporan masalah (issue), saran perbaikan,
maupun pull request sangat disambut.
