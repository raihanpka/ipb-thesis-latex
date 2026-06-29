# Kontribusi

Terima kasih sudah tertarik untuk berkontribusi pada Template Tugas
Akhir Sarjana (S1) IPB University dalam format LaTeX. Kontribusi
berupa laporan masalah (issue), saran perbaikan, maupun pull request
sangat kami harapkan.

## Cara Berkontribusi

### Melaporkan Masalah (Issue)

Jika Anda menemukan bug, ketidaksesuaian format dengan PPKI IPB, atau
memiliki saran perbaikan:

1. Pastikan masalah tersebut belum pernah dilaporkan dengan mencari di
   halaman [Issues](https://github.com/raihanpka/ipb-template-latex/issues).
2. Gunakan template issue yang tersedia.
3. Sertakan:
   - Versi TeX Live atau MiKTeX yang digunakan.
   - Compiler (`pdflatex`, `xelatex`, `lualatex`).
   - Perintah atau langkah reproduksi.
   - Tangkapan layar atau pesan kesalahan jika ada.

### Mengirim Pull Request

1. **Fork** repositori ini.
2. **Buat branch** baru dari `main` atau `master`:
   ```
   git checkout -b feature/perbaikan-margin-bab
   ```
3. **Lakukan perubahan** secara terfokus. Satu pull request sebaiknya
   membahas satu perubahan saja.
4. **Pastikan** semua hal berikut terpenuhi:
   - Kompilasi sukses dengan `make build` tanpa peringatan.
   - `make validate` tidak menghasilkan kesalahan fatal.
   - Perubahan sesuai dengan PPKI IPB Edisi ke-4 (lihat
     `docs/Template Tugas Akhir.dotx`).
   - Berkas baru di tempat yang tepat dan mengikuti pola penamaan
     `kebab-case`.
   - Komentar header di bagian atas setiap `.tex` baru.
5. **Tulis pesan commit** yang jelas dan ringkas. Contoh:
   ```
   perbaiki margin halaman bab menjadi 4 cm sisi dalam
   ```
6. **Push** ke fork Anda dan buka pull request ke branch `main` atau
   `master` pada repositori utama.

## Panduan Gaya Kode

- **Penamaan file**: `kebab-case` (contoh: `chapter-1.tex`,
  `lembar-persetujuan.tex`).
- **Indentasi**: 2 spasi.
- **Panjang baris**: usahakan tidak lebih dari 80 karakter.
- **Komentar**: gunakan komentar header untuk menjelaskan fungsi
  setiap berkas.
- **Paket LaTeX**: tambahkan di `src/config/ipb-thesis.sty`; jangan
  memuat paket langsung di file bab.

## Struktur Direktori

Sebelum menambah atau memindahkan berkas, pahami dulu struktur
direktori:

```
src/
  config/        Style, data, dan aturan
  abstract/      Abstrak (id) dan Abstract (en)
  preliminaries/ Bagian Awal
  chapters/      Bagian Inti (bab 1 s.d. bab 5)
  backmatter/    Bagian Akhir
  refs/          Database BibTeX
  resources/     Gambar dan logo
```

## Validasi Lokal

Sebelum mengirim pull request, jalankan:

```
make validate   # chktex
make build      # kompilasi
```

Pastikan keduanya sukses. Jika hanya melakukan perubahan dokumentasi
(Markdown), `make validate` cukup.

## Lisensi

Dengan berkontribusi, Anda menyetujui bahwa kontribusi Anda akan
dilisensikan di bawah Lisensi MIT yang sama dengan proyek ini.
