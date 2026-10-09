# GUIDE.md

Panduan lengkap instalasi, penggunaan, troubleshooting, dan kustomisasi
untuk template LaTeX Tugas Akhir Sarjana (S1) IPB University. Dokumen
ini adalah pelengkap dari [README.md](README.md) yang hanya memuat
informasi singkat. Versi ini mengikuti PPTA IPB 2026 dan templat resmi
`Skripsi Sain-Tek-Kes [20260812].dotx`.

## Daftar Isi

- [1. Instalasi LaTeX](#1-instalasi-latex)
  - [1.1 macOS: BasicTeX via Homebrew (hemat storage)](#11-macos-basictex-via-homebrew-hemat-storage)
  - [1.2 macOS: MacTeX via Homebrew (lengkap, ~5 GB)](#12-macos-mactex-via-homebrew-lengkap-5-gb)
  - [1.3 Windows: MiKTeX](#13-windows-miktex)
  - [1.4 Windows: TeX Live](#14-windows-tex-live)
  - [1.5 Linux: TeX Live](#15-linux-tex-live)
  - [1.6 Verifikasi Instalasi](#16-verifikasi-instalasi)
- [2. Penggunaan Template](#2-penggunaan-template)
  - [2.1 Isi Data Mahasiswa](#21-isi-data-mahasiswa)
  - [2.2 Tulis Isi Skripsi](#22-tulis-isi-skripsi)
  - [2.3 Bangun PDF](#23-bangun-pdf)
  - [2.4 Tambah Referensi](#24-tambah-referensi)
  - [2.5 Tambah Bab Baru](#25-tambah-bab-baru)
  - [2.6 Pakai Overleaf](#26-pakai-overleaf)
- [3. Panduan Sitasi dan Daftar Pustaka](#3-panduan-sitasi-dan-daftar-pustaka)
  - [3.1 Format PPTA](#31-format-ppta)
  - [3.2 Perintah Sitasi](#32-perintah-sitasi)
  - [3.3 Entri BibTeX/biber](#33-entri-biber)
- [4. Kustomisasi Lanjutan](#4-kustomisasi-lanjutan)
  - [4.1 Memisahkan Bab Hasil dan Pembahasan](#41-memisahkan-bab-hasil-dan-pembahasan)
  - [4.2 Compiler dan font](#42-compiler-dan-font)
  - [4.3 Menambah Persamaan Matematika](#43-menambah-persamaan-matematika)
  - [4.4 Menambah Penyorotan Sintaks Kode](#44-menambah-penyorotan-sintaks-kode)
  - [4.5 Tabel dari CSV](#45-tabel-dari-csv)
- [5. Troubleshooting](#5-troubleshooting)
- [6. Catatan PPTA yang Tidak Otomatis](#6-catatan-ppta-yang-tidak-otomatis)

---

## 1. Instalasi LaTeX

Template ini membutuhkan distribusi LaTeX yang **lengkap** karena
memerlukan paket `biblatex`, `biber`, `chktex`, dan paket tambahan
lainnya. Pilih distribusi sesuai kebutuhan storage dan platform.

### 1.1 macOS: BasicTeX via Homebrew (hemat storage)

BasicTeX adalah installer minimal (~130 MB). Cocok untuk Anda yang
ingin hemat storage dan tidak keberatan menginstall paket tambahan
secara manual via `tlmgr`. **Ini adalah pilihan yang dipakai oleh
pengembang template ini.**

```
brew install --cask basictex
```

Setelah BasicTeX terinstall, install paket tambahan yang dibutuhkan
template. Jalankan dari root repositori:

```
make install
```

Target `install` di Makefile mendeteksi OS dan distribusi TeX secara
otomatis, lalu menjalankan `tlmgr install` untuk paket yang
dibutuhkan: `biblatex`, `biber`, `chktex`, `titlesec`, `tocloft`,
`fancyhdr`, `caption`, `booktabs`, `enumitem`, `hanging`,
`multirow`, `longtable`, `csquotes`, `microtype`, dan beberapa
paket tambahan.

Atau manual jika lebih suka:

```
sudo tlmgr update --self
sudo tlmgr install \
    biblatex biber chktex titlesec tocloft \
    fancyhdr caption booktabs enumitem hanging \
    multirow longtable csquotes
```

Total setelah install paket tambahan: ~500 MB, jauh lebih kecil
dibanding MacTeX yang ~6 GB.

### 1.2 macOS: MacTeX via Homebrew (lengkap, ~5 GB)

Cara paling bersih dan termutakhir untuk macOS. Homebrew mengelola
symlink secara otomatis. Semua paket sudah termasuk sejak awal,
tidak perlu `tlmgr` lagi.

```
brew install --cask mactex-no-gui
```

Versi `mactex-no-gui` adalah installer CLI-only. Pilih ini kalau
Anda tidak butuh TeXShop, LaTeXiT, dan BibDesk. Kalau butuh
aplikasi GUI, gunakan:

```
brew install --cask mactex
```

Setelah instalasi, tambahkan path TeX ke `~/.zshrc` atau
`~/.bash_profile`:

```
export PATH="/Library/TeX/texbin:$PATH"
```

Lalu muat ulang shell:

```
source ~/.zshrc
```

Verifikasi:

```
which lualatex latexmk biber chktex
lualatex --version | head -1
biber --version
```

### 1.3 Windows: MiKTeX

1. Unduh MiKTeX dari <https://miktex.org/download>.
2. Jalankan installer; pilih **Install for current user only** atau
   **Install for all users** sesuai kebutuhan.
3. Aktifkan auto-install paket yang hilang: MiKTeX Console > Settings
   > "Install missing packages on-the-fly: Yes".
4. Tambahkan path ke PATH (biasanya `C:\Program Files\MiKTeX\miktex\bin\x64`).

Verifikasi di Command Prompt:

```
where lualatex
where biber
lualatex --version
biber --version
```

### 1.4 Windows: TeX Live

1. Unduh installer dari <https://tug.org/texlive/windows.html>.
2. Pilih instalasi **full scheme** (sekitar 8 GB) atau **medium scheme**
   (~2 GB) jika ruang terbatas.
3. PATH otomatis ditambahkan saat instalasi.

### 1.5 Linux: TeX Live

Ubuntu atau Debian:

```
sudo apt update
sudo apt install texlive-full biber chktex latexmk
```

Fedora:

```
sudo dnf install texlive-scheme-full biber chktex latexmk
```

Arch Linux:

```
sudo pacman -S texlive-most biber chktex
```

Catatan: `texlive-full` sangat besar (8 GB+). Untuk instalasi lebih
kecil, gunakan `texlive-latex-extra`, `texlive-latex-recommended`,
`texlive-fonts-recommended`, dan paket individual lainnya.

### 1.6 Verifikasi Instalasi

Pastikan semua tool penting tersedia:

```
which lualatex latexmk biber chktex
```

Versi minimal yang disarankan:

- LuaLaTeX dari TeX Live 2024/MiKTeX yang setara atau lebih baru
- latexmk 4.70 atau lebih baru
- biber 2.16 atau lebih baru
- chktex 1.7 atau lebih baru (opsional, untuk `make validate`)

---

## 2. Penggunaan Template

### 2.1 Isi Data Mahasiswa

Buka `src/config/information.tex` dan ganti semua placeholder:

```latex
\newcommand{\NamaPenulis}{Nama Penulis}
\newcommand{\NamaPenulisInggris}{Student Name}
\newcommand{\NIM}{NIM}
\newcommand{\JudulSkripsi}{Judul Karya Ilmiah}
\newcommand{\NamaPembimbingSatu}{Nama Pembimbing 1}
\newcommand{\NamaPembimbingDua}{Nama Pembimbing 2}
\newcommand{\ProgramStudi}{Nama Program Studi}
\newcommand{\ProgramStudiSingkat}{Nama Program Studi}
```

`ProgramStudiSingkat` digunakan oleh Makefile untuk membentuk nama
PDF. Ganti semua nilai placeholder dengan data sebenarnya sebelum naskah
diserahkan. Pilih `ProgramStudiSingkat` tanpa awalan "Program Studi".

Untuk deklarasi AI, biarkan `\MenggunakanAI` bernilai `placeholder` selama
template masih berupa contoh. Sebelum penyerahan, ubah nilainya menjadi
`true` atau `false`; jika bernilai `true`, isi juga `\NamaAlatAI` dan
`\TujuanPenggunaanAI`.

### 2.2 Tulis Isi Skripsi

Edit file per bab di `src/chapters/chapter-N.tex`. Bagian awal berada di
`src/preliminaries/` dan abstrak berada di `src/abstract/`. Seluruhnya sudah
dilengkapi teks panduan PPTA 2026; ganti dengan isi sebenarnya.

Isi sorotan di `src/preliminaries/sorotan.tex`. Untuk abstrak grafis, isi
judulnya dan atur path gambar melalui `\BerkasAbstrakGrafis` di
`src/config/information.tex`.

Untuk menulis subbab baru dalam sebuah bab:

```latex
\chapter{PENDAHULUAN}

\section{Latar Belakang}
Isi latar belakang...

\section{Rumusan Masalah}
Isi rumusan masalah...
```

Penomoran subbab otomatis mengikuti bab: `1.1`, `1.2`, `2.1`, dst.
Sub-subbab menggunakan `1.1.1`, `1.1.2`, dst.

### 2.3 Bangun PDF

Pilih salah satu:

```
make              # Linux atau macOS
make.bat          # Windows
```

Output berada di `dist/Skripsi_<ProgramStudiSingkat>_<Nama>_<Bulan Tahun>.pdf`
dan disalin ke `main.pdf` untuk kompatibilitas struktur upstream.

Untuk terus memantau perubahan:

```
make watch
```

Setiap 2 detik template akan di-rebuild. Tekan Ctrl+C untuk berhenti.

### 2.4 Tambah Referensi

Tambahkan entri ke `src/refs/daftar-pustaka.bib`:

```bibtex
@article{Smith2024,
  author  = {Smith, J.A. and Doe, R.B.},
  year    = {2024},
  title   = {Judul artikel dalam sentence case},
  journal = {Nama Jurnal},
  volume  = {10},
  number  = {2},
  pages   = {100--115},
  doi     = {10.1234/jurnal.2024.001}
}
```

Sitasi di teks:

```latex
\citep{Smith2024}        % -> (Smith dan Doe 2024)
\citet{Smith2024}        % -> Smith dan Doe (2024)
\citep[hal. 105]{Smith2024}  % -> (Smith dan Doe 2024, hal. 105)
```

Setelah menambah entri, jalankan ulang `make build`.

### 2.5 Tambah Bab Baru

Buat file baru di `src/chapters/`, misalnya `chapter-6.tex`:

```latex
\chapter{BAB BARU}

\section{Pendahuluan Bab}
Isi pendahuluan bab baru...
```

Lalu tambahkan di `src/main.tex` pada bagian `\mainmatter`:

```latex
\input{chapters/chapter-6}    % BAB VI  BAB BARU
```

### 2.6 Pakai Overleaf

1. Buka <https://www.overleaf.com>.
2. Buat proyek baru > "Upload Project" > pilih folder hasil clone
   dari GitHub.
3. Pilih `LuaLaTeX` sebagai compiler. BibLaTeX dan biber sudah tersedia di
   Overleaf.

Atau gunakan tautan langsung: <https://www.overleaf.com/read/zcgrrzkfgkcw>.

---

## 3. Panduan Sitasi dan Daftar Pustaka

### 3.1 Format PPTA

Sesuai PPTA IPB 2026 dan CSE edisi ke-9:

- **Dalam teks**: (Penulis Tahun), dua nama dihubungkan "dan", dan tiga
  penulis atau lebih menggunakan nama pertama diikuti *et al.*.
- **Daftar pustaka**:
  - Urut alfabet berdasarkan nama belakang penulis pertama.
  - Hanging indent 1 cm.
  - Pemisah field menggunakan **titik** (bukan koma).
  - Tahun **tanpa kurung**.
  - Maksimum lima penulis ditulis lengkap; lebih dari lima menampilkan lima
    nama pertama diikuti *et al.*.
  - Judul jurnal dan volume dalam cetak miring.
  - DOI dicantumkan bila ada.

Contoh daftar pustaka yang dihasilkan:

```
Bente, A. D. dan R. Rico-Hesse. 2006. Model of dengue virus infection.
    Drug Discovery Today: Disease Models 3(1): 97-103.
    doi:10.1016/j.ddmod.2006.03.014.

Kochel, T. J., D. M. Watts, A. S. Gozalo, D. F. Ewing, K. R. Porter
    dan K. L. Russell. 2005. Cross-serotype neutralization of dengue
    virus in Aotus nancymaae monkeys. Journal of Infectious Diseases
    191(6): 1000-1004. doi:10.1086/427511.
```

### 3.2 Perintah Sitasi

Template ini menggunakan biblatex dengan emulasi natbib. Perintah
natbib standar tetap bekerja:

| Perintah | Hasil |
|---|---|
| `\citep{Smith2024}` | (Smith dan Doe 2024) |
| `\citet{Smith2024}` | Smith dan Doe (2024) |
| `\citep[5]{Smith2024}` | (Smith dan Doe 2024:5) |
| `\citep{Smith2024,Jones2020}` | (Smith dan Doe 2024; Jones 2020) |
| `\citeauthor{Smith2024}` | Smith dan Doe |
| `\citeyear{Smith2024}` | 2024 |
| `\citealp{Smith2024}` | Smith dan Doe, 2024 |

### 3.3 Entri BibTeX/biber

Tipe entri yang umum dipakai:

- `@article` - artikel jurnal
- `@book` - buku
- `@inproceedings` - prosiding seminar
- `@thesis` atau `@mastersthesis` atau `@phdthesis` - skripsi/tesis/disertasi
- `@online` - sumber daring
- `@misc` - lain-lain

Field wajib:

- `author` atau `editor` (kecuali untuk `@online`)
- `title`
- `year`

Field yang relevan untuk lokalisasi PPTA:

- `langid = {english}` untuk sumber berbahasa Inggris (memengaruhi
  ejaan di daftar pustaka).

---

## 4. Kustomisasi Lanjutan

### 4.1 Memisahkan Bab Hasil dan Pembahasan

Jika pembimbing meminta bab Hasil dan Pembahasan dipisah, edit
`src/main.tex` di bagian `\mainmatter`:

```latex
% Ganti satu baris ini:
\input{chapters/chapter-4}

% Menjadi dua baris:
\input{chapters/chapter-4-hasil}
\input{chapters/chapter-4-pembahasan}
```

Buat file `chapter-4-hasil.tex`:

```latex
\chapter{HASIL}
% ... isi bab Hasil
```

### 4.2 Compiler dan font

Template sudah dikonfigurasi untuk LuaLaTeX dan Times New Roman. Jika font
tersebut tidak tersedia, TeX Gyre Termes digunakan sebagai fallback. Gunakan
`make build` dan jangan mengganti compiler ke pdfLaTeX.

### 4.3 Menambah Persamaan Matematika

Paket `amsmath` dan `amssymb` sudah dimuat. Contoh:

```latex
\begin{equation}
  y = ax^2 + bx + c
  \label{eq:persamaan-kuadratik}
\end{equation}
```

Rujuk di teks:

```latex
\ldots sesuai Persamaan~\ref{eq:persamaan-kuadratik}.
```

### 4.4 Menambah Penyorotan Sintaks Kode

Untuk menggunakan `listings`, tambahkan paket tersebut di
`src/config/ipb-thesis.sty`. Contoh:

```latex
\begin{lstlisting}[language=Python, caption={Kode program Python}, label={lst:contoh}]
def hello():
    print("Hello, world!")
\end{lstlisting}
```

Atau gunakan `minted` (memerlukan Pygments). Tambahkan di
`src/config/ipb-thesis.sty`:

```latex
\RequirePackage{minted}
```

### 4.5 Tabel dari CSV

Tambahkan di `src/config/ipb-thesis.sty`:

```latex
\RequirePackage{csvsimple}
```

Gunakan di bab:

```latex
\begin{table}[H]
  \centering
  \caption{Kebutuhan fungsional sistem}
  \label{tab:kebutuhan}
  \csvautotabular{resources/data.csv}
\end{table}
```

Simpan `data.csv` di `src/resources/`.

---

## 5. Troubleshooting

### Error: "File `biblatex.sty' not found"

biblatex belum terinstall. Install:

```
sudo tlmgr install biblatex     # TeX Live
# atau buka MiKTeX Console dan install paket biblatex
```

### Error: "biber not found"

biber adalah program terpisah dari biblatex. Install:

```
sudo tlmgr install biber
# macOS Homebrew: brew install biber
```

### Error: "Citation `xxx' undefined"

Biblatex butuh biber untuk memproses `.bib`. Compile dengan
`latexmk` yang otomatis menjalankan biber:

```
make build
```

Atau manual:

```
lualatex -jobname=tmp -output-directory=build src/main.tex
biber build/tmp
lualatex -jobname=tmp -output-directory=build src/main.tex
lualatex -jobname=tmp -output-directory=build src/main.tex
```

### Error: "Package keyval Error: openany undefined"

`openany` adalah opsi `documentclass`, bukan `geometry`. Buka
`src/config/ipb-thesis.sty` dan hapus `openany` dari opsi
`\RequirePackage{geometry}`.

### Daftar pustaka tidak muncul

Pastikan `src/main.tex` memiliki:

```latex
\addbibresource{src/refs/daftar-pustaka.bib}
```

Dan `src/backmatter/daftar-pustaka.tex` memiliki:

```latex
\printbibliography[heading=none]
```

### Halaman kosong di antara bab

Halaman kosong merupakan konsekuensi `openright`: bab dan bagian besar dimulai
pada halaman ganjil sesuai templat resmi. Jangan menghapusnya dari dokumen
final tanpa persetujuan pengelola program studi.

### Font Times New Roman tidak ditemukan

Jika menggunakan XeLaTeX/LuaLaTeX, install font Times New Roman di
sistem operasi:

- macOS: sudah termasuk.
- Windows: sudah termasuk.
- Linux: install `ttf-mscorefonts-installer` (Debian/Ubuntu) atau
  `liberation-fonts` (alternatif open source).

### Tabel terpotong antar halaman

Paket `longtable` sudah dimuat. Ganti `tabular` dengan `longtable`
untuk tabel panjang:

```latex
\begin{longtable}{lcc}
  \toprule
  ...
\end{longtable}
```

### Spasi atau indentasi tidak sesuai

PPTA menentukan:

- Spasi tunggal (`\singlespacing`).
- Indentasi paragraf pertama 1 cm (`\parindent = 1cm`).
- Tanpa spasi antar paragraf (`\parskip = 0pt`).

Jika berubah, periksa apakah ada paket lain yang memodifikasi.
Paket `setspace`, `indentfirst`, dan `parskip` sudah dikonfigurasi
di `src/config/ipb-thesis.sty`.

### Kompilasi sangat lambat

Bisa karena biber memproses banyak entri. Optimalkan `.bib` dengan
menghapus entri yang tidak dipakai, atau gunakan `latexmk` dengan
caching.

---

## 6. Catatan PPTA yang Tidak Otomatis

Beberapa hal tidak dapat diotomatisasi di LaTeX dan perlu perhatian
manual saat menulis:

- **Ejaan dan tata bahasa Indonesia** - tidak ada checker otomatis.
  Gunakan alat seperti LanguageTool.
- **Daftar singkatan dan daftar notasi** - harus dibuat manual
  jika diperlukan. Tambahkan di Bagian Awal sesuai kebutuhan.
- **Halaman persetujuan fisik** - di LaTeX, halaman ini hanya
  template. Setelah dicetak, tambahkan tanda tangan asli.
- **Lembar pengesahan** - memuat pembimbing, ketua program studi, dan pejabat
  kedua bila disyaratkan. Atur datanya di `src/config/information.tex`.
- **Nomor halaman Romawi** - hitungan dimulai dari Sorotan, tetapi nomornya
  tidak dicetak pada bagian awal.
- **Kertas HVS vs kertas buklet** - margin sudah dikonfigurasi
  untuk penjilidan. Saat mencetak, gunakan mode **long edge**
  untuk duplex.

---

Untuk pertanyaan lain, buka
[issue](https://github.com/raihanpka/ipb-thesis-latex/issues) di
repositori.
