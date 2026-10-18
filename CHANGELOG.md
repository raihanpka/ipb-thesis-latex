# Changelog

Semua perubahan penting pada proyek ini akan didokumentasikan di berkas
ini. Format penomoran versi mengikuti [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Ditambah
- Berkas CSL di `src/refs/ipb.csl` dan `src/refs/ipb-en.csl` untuk
  pengguna Pandoc/citeproc, diadaptasi dari
  [auriza/csl-ipb](https://github.com/auriza/csl-ipb).
- String bahasa Indonesia tambahan di `ipb-thesis.sty` untuk sitasi
  dan daftar pustaka: `diakses`, `diedit oleh`, `diterjemahkan oleh`,
  `tersedia pada`, `Volume ke-`, `Ed ke-`, `hlm`.
- **Dukungan Tectonic**: template kini dapat dikompilasi dengan
  [Tectonic](https://tectonic-typesetting.github.io/) secara langsung.
  `make build` (dan `make.bat build`) otomatis mendeteksi dan menggunakan
  Tectonic bila tersedia.
- Target `make tectonic` dan `make pdflatex` (serta padanannya di
  `make.bat`) untuk memilih compiler secara eksplisit.
- Variabel `ENGINE` untuk override compiler dari CLI:
  `make build ENGINE=tectonic` atau `make build ENGINE=pdflatex`.
- Target `make doctor` kini menampilkan status Tectonic dan compiler
  yang aktif selain tool TeX Live/MiKTeX tradisional.
- Panduan instalasi Tectonic di `GUIDE.md` (Bagian 1.1).
- Badge Tectonic di `README.md`.

### Diubah
- Konfigurasi `ipb-thesis.sty` untuk menangani sumber daring dengan
  format `[diakses YYYY MMM DD]. URL.` sesuai PPKI Edisi ke-4.
- README: menambah atribusi untuk Auriza Rahmad Akbar
  ([@auriza](https://github.com/auriza)) sebagai penulis CSL.
- `\titleformat{\chapter}`: perbaikan parameter `sep` dari
  `{\hspace{1.5em}}` menjadi `{1.5em}` agar kompatibel dengan
  XeTeX (digunakan oleh Tectonic) dan pdfLaTeX.
- `make install`: sekarang menawarkan instalasi Tectonic sebagai
  opsi ringan di macOS dan Windows.
- `make doctor`: memeriksa ketersediaan Tectonic, bukan hanya pdflatex.

## [2.0.0] - 2026-06-29

### Ditambah
- Restrukturisasi direktori: seluruh kode LaTeX, referensi, dan gambar
  dipindahkan ke dalam `src/`.
- Subdirektori baru sesuai kategorisasi PPKI IPB:
  - `src/abstract/` khusus abstrak (id) dan abstract (en).
  - `src/preliminaries/` untuk Bagian Awal.
  - `src/chapters/` untuk Bagian Inti (Bab I sampai V).
  - `src/backmatter/` untuk Bagian Akhir.
- Paket `ipb-thesis.sty` di `src/config/` memuat seluruh pengaturan
  format (margin, font, headings, captions, bibliography, hyperlinks).
- `src/config/information.tex` sebagai satu sumber kebenaran untuk
  data penulis, pembimbing, dan institusi.
- `src/config/hyphenation-id.tex` untuk aturan pemenggalan kata
  Bahasa Indonesia.
- Berkas `Makefile` dan `make.bat` untuk kompilasi lintas platform.
- Alur kerja GitHub Actions `.github/workflows/build.yml` untuk
  validasi dan build PDF otomatis.
- Berkas `.chktexrc` untuk konfigurasi validator `chktex`.
- `CONTRIBUTING.md`, `LICENSE` (MIT), dan `CHANGELOG.md`.

### Diubah
- Penomoran bab menggunakan Romawi kapital (I, II, III) sesuai
  `numId=21` di `Template Tugas Akhir.dotx`.
- Penomoran subbab menggunakan desimal `1.1`, `1.2` (numId=21 level 1).
- Sub-subbab tidak ditebalkan (sesuai `Judul Sub-subbab` di `.dotx`).
- Caption tabel di atas dan caption gambar di bawah; format tanpa titik
  dua dan tanpa cetak tebal pada label.
- Counter lampiran terpisah dari counter chapter.
- Daftar isi, daftar tabel, daftar gambar, dan daftar lampiran dengan
  judul 14pt tebal rata tengah.
- Margin halaman bab menjadi 3 cm atas/kanan/bawah dengan sisi dalam
  4 cm (3 cm + 1 cm gutter atau langsung 4 cm pada halaman bab).
- Margin preliminary dan backmatter menggunakan 3 cm + 1 cm gutter
  untuk mengimbangi penjilidan.
- Page style: preliminary menggunakan nomor halaman Romawi kecil
  tengah atas; halaman isi menggunakan nomor Arab sudut luar atas.
- Penomoran gambar dan tabel global (tidak reset per bab).

### Diperbaiki
- Format halaman judul (cover) yang sebelumnya tidak sesuai dengan
  dokumen `.dotx`.
- Pengaturan sub-subbab yang sebelumnya keliru ditebalkan.
- Urutan halaman preliminary yang sebelumnya tidak menyisipkan
  abstrak dan abstract di antara lembar persetujuan dan prakata.

### Catatan
- Pengaturan format di `ipb-thesis.sty` diverifikasi terhadap dokumen
  `Template Tugas Akhir.dotx` dan `Templat tugas akhir S1.docx` di
  direktori `docs/`.

## [1.0.0] - 2026-03-19

### Ditambah
- Rilis awal template LaTeX untuk tugas akhir sarjana IPB University.
- Direktori `chapters/` dengan satu berkas per bab.
- Berkas `main.tex` sebagai entry point dengan semua pengaturan format.
- Berkas `README.md` dokumentasi lengkap.
