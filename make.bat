@echo off
REM =============================================================================
REM make.bat -- Windows wrapper untuk Makefile
REM
REM Pemakaian:
REM   make.bat              Bangun PDF
REM   make.bat build        Bangun PDF
REM   make.bat clean        Hapus artefak
REM   make.bat distclean    Hapus build/ dan dist/
REM   make.bat validate     Validasi dengan chktex
REM   make.bat help         Tampilkan bantuan
REM
REM Nama PDF: Skripsi_<Departemen>_<Nama>_<Bulan Tahun>.pdf
REM Contoh:  Skripsi_Ilmu_Komputer_Nama_Lengkap_Jun_2026.pdf
REM =============================================================================

REM Aktifkan ANSI escape (Windows 10+)
for /F "tokens=*" %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

set "TARGET=%1"
if "%TARGET%"=="" set "TARGET=build"

REM === Ambil metadata dari src\config\information.tex ===
set "DEPT_SHORT="
set "NAMA="
for /f "usebackq tokens=*" %%a in ("src\config\information.tex") do (
    echo "%%a" | findstr /R "\\newcommand" >nul && (
        echo "%%a" | findstr /R "\\ProgramStudiSingkat" >nul && (
            for /f "tokens=2 delims={}" %%b in ("%%a") do set "DEPT_SHORT=%%b"
        )
        echo "%%a" | findstr /R "\\NamaPenulis" >nul && (
            for /f "tokens=2 delims={}" %%b in ("%%a") do set "NAMA=%%b"
        )
    )
)
if "%DEPT_SHORT%"=="" set "DEPT_SHORT=Ilmu Komputer"

REM === Tanggal otomatis ===
for /f "tokens=*" %%d in ('powershell -NoProfile -Command "Get-Date -Format 'MMM yyyy'"') do set "DATE=%%d"

REM === Sanitasi nama file (spasi ke underscore) ===
set "DEPT_FILE=%DEPT_SHORT: =_%"
set "NAMA_FILE=%NAMA: =_%"
set "DATE_FILE=%DATE: =_%"

set "OUT_NAME=Skripsi_%DEPT_FILE%_%NAMA_FILE%_%DATE_FILE%"
set "OUT_PATH=dist\%OUT_NAME%.pdf"

REM === PATH agar latexmk dan biber ditemukan ===
REM MacTeX: tambahkan /Library/TeX/texbin
REM MiKTeX: tambahkan C:\Program Files\MiKTeX\miktex\bin\x64
REM TeX Live: tambah manual sesuai instalasi
set "PATH=%PATH%;C:\texlive\2026\bin\windows;C:\Program Files\MiKTeX\miktex\bin\x64;C:\Users\%USERNAME%\AppData\Local\Programs\MiKTeX\miktex\bin\x64"
set "TEXINPUTS=.;src\;src\config\;build\;"
set "BSTINPUTS=.;src\;src\config\;"
set "BIBINPUTS=.;src\;"

REM === Dispatcher ===
if /I "%TARGET%"=="build" goto :build
if /I "%TARGET%"=="all" goto :build
if /I "%TARGET%"=="clean" goto :clean
if /I "%TARGET%"=="distclean" goto :distclean
if /I "%TARGET%"=="validate" goto :validate
if /I "%TARGET%"=="watch" goto :watch
if /I "%TARGET%"=="help" goto :help
if /I "%TARGET%"=="-h" goto :help
if /I "%TARGET%"=="--help" goto :help
goto :help

REM -----------------------------------------------------------------------------
:build
if not exist build mkdir build
if not exist dist mkdir dist

echo   %ESC%[1;33m::%ESC%[0m Building %ESC%[0;36m%OUT_NAME%.pdf%ESC%[0m
echo   %ESC%[0;33mDepartemen%ESC%[0m: %DEPT_SHORT%
echo   %ESC%[0;33mPenulis%ESC%[0m:    %NAMA%

REM latexmk mendeteksi biber dan menjalankan LuaLaTeX sesuai kebutuhan
latexmk -lualatex -file-line-error -halt-on-error -interaction=nonstopmode -output-directory=build -aux-directory=build -jobname=tmp src\main.tex
if errorlevel 1 (
    echo   %ESC%[0;31mFAIL%ESC%[0m  latexmk gagal. Lihat build\tmp.log untuk detail.
    exit /b 1
)
if exist build\tmp.pdf (
    move /Y build\tmp.pdf "%OUT_PATH%" >nul
    copy /Y "%OUT_PATH%" "main.pdf" >nul
    echo   %ESC%[0;32mOK%ESC%[0m    %ESC%[0;36m%OUT_PATH%%ESC%[0m
    echo   %ESC%[0;32mOK%ESC%[0m    %ESC%[0;36mmain.pdf%ESC%[0m
) else (
    echo   %ESC%[0;31mFAIL%ESC%[0m  PDF tidak dihasilkan.
    exit /b 1
)
goto :eof

REM -----------------------------------------------------------------------------
:clean
echo   %ESC%[1;33m::%ESC%[0m Cleaning LaTeX artifacts...
if exist build rmdir /S /Q build
del /Q *.aux *.log *.toc *.lof *.lot *.fls *.out *.bbl *.blg *.bcf *.run.xml *.fdb_latexmk 2>nul
echo   %ESC%[0;32mOK%ESC%[0m    Cleaned
goto :eof

REM -----------------------------------------------------------------------------
:distclean
call :clean
if exist dist rmdir /S /Q dist
echo   %ESC%[0;32mOK%ESC%[0m    Done
goto :eof

REM -----------------------------------------------------------------------------
:validate
where chktex >nul 2>nul
if errorlevel 1 (
    echo   %ESC%[0;31mFAIL%ESC%[0m  chktex tidak ditemukan. Install dengan MiKTeX Package Manager.
    exit /b 1
)
echo   %ESC%[1;33m::%ESC%[0m Validating LaTeX source with chktex...
chktex -q -l .chktexrc -I src\main.tex
if errorlevel 1 (
    echo   %ESC%[0;31mFAIL%ESC%[0m  Validasi menemukan masalah.
    exit /b 1
)
echo   %ESC%[0;32mOK%ESC%[0m    Validation complete
goto :eof

REM -----------------------------------------------------------------------------
:watch
echo   %ESC%[1;33m::%ESC%[0m Watching for changes... (Ctrl+C to stop)
echo   %ESC%[1;33m::%ESC%[0m Output: %ESC%[0;36m%OUT_NAME%.pdf%ESC%[0m
:watch_loop
call :build 2>nul
timeout /t 2 /nobreak >nul
goto :watch_loop

REM -----------------------------------------------------------------------------
:help
echo.
echo   IPB Thesis LaTeX Template
echo   ============================
echo.
echo   make.bat         Bangun PDF
echo   make.bat build   Bangun PDF
echo   make.bat clean   Hapus artefak
echo   make.bat distclean Hapus build/ dan dist/
echo   make.bat validate Validasi dengan chktex
echo   make.bat watch   Bangun ulang otomatis
echo   make.bat help    Tampilkan pesan ini
echo.
echo   Output: %OUT_NAME%.pdf
echo   Departemen: %DEPT_SHORT%
echo   Penulis:    %NAMA%
echo.
goto :eof
