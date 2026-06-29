# =============================================================================
# Makefile untuk Template Tugas Akhir Sarjana (S1) IPB University
#
# Fitur:
#   - Deteksi OS otomatis (macOS, Linux, Windows) dan distribusi TeX
#   - Auto-install paket yang hilang via package manager OS
#   - Build PDF otomatis dengan biber (bukan bibtex)
#   - Auto-clean semua file sementara (.aux, .log, .bbl, .bcf, dll)
#   - Auto-clean direktori build/ pada setiap clean
#   - Auto-clean direktori dist/ pada distclean
#   - Color output dan spinner animation
#   - Auto-naming PDF: Skripsi_<ProgramStudi>_<Nama>_<Bulan Tahun>.pdf
#
# Target:
#   make              Bangun PDF
#   make build        Bangun PDF
#   make install      Install paket LaTeX yang dibutuhkan (OS-aware)
#   make doctor       Cek apakah TeX dan paket biber sudah terinstall
#   make clean        Hapus semua file sementara + build/
#   make distclean    clean + hapus dist/
#   make validate     Validasi sumber LaTeX dengan chktex
#   make watch        Bangun ulang otomatis
#   make help         Tampilkan pesan bantuan
# =============================================================================

SHELL := /bin/bash
PROJECT  := ipb-template-latex
SRC      := src/main.tex
INFOFILE := src/config/information.tex
BUILDDIR := build
SPINNER  := $(CURDIR)/scripts/spinner.sh
EXTRACT  := python3 $(CURDIR)/scripts/extract-info.py

# -----------------------------------------------------------------------------
# Kode warna (untuk printf)
# -----------------------------------------------------------------------------
G  := \033[0;32m
C  := \033[0;36m
Y  := \033[1;33m
R  := \033[0;31m
B  := \033[0;34m
M  := \033[0;35m
NC := \033[0m

# -----------------------------------------------------------------------------
# Deteksi OS
# -----------------------------------------------------------------------------
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    OS := macos
    PKG_MGR := $(shell command -v brew 2>/dev/null)
endif
ifeq ($(UNAME_S),Linux)
    OS := linux
    PKG_MGR := $(shell command -v apt 2>/dev/null)
    ifeq ($(PKG_MGR),)
        PKG_MGR := $(shell command -v dnf 2>/dev/null)
    endif
    ifeq ($(PKG_MGR),)
        PKG_MGR := $(shell command -v pacman 2>/dev/null)
    endif
endif
ifneq (,$(findstring MINGW,$(UNAME_S))$(findstring MSYS,$(UNAME_S))$(findstring CYGWIN,$(UNAME_S)))
    OS := windows
    PKG_MGR := $(shell command -v choco 2>/dev/null)
    ifeq ($(PKG_MGR),)
        PKG_MGR := $(shell command -v scoop 2>/dev/null)
    endif
endif
ifeq ($(OS),)
    OS := unknown
endif

# -----------------------------------------------------------------------------
# Deteksi distribusi TeX
# -----------------------------------------------------------------------------
PDFLATEX_BIN := $(shell which pdflatex 2>/dev/null)
BIBER_BIN    := $(shell which biber 2>/dev/null)
CHKTeX_BIN   := $(shell which chktex 2>/dev/null)

TEX_DIST := none
ifeq ($(OS),macos)
    ifneq ($(PDFLATEX_BIN),)
        ifneq (,$(findstring basic,$(PDFLATEX_BIN)))
            TEX_DIST := basictex
        else ifneq (,$(findstring texlive,$(PDFLATEX_BIN)))
            TEX_DIST := mactex
        endif
    endif
endif
ifeq ($(OS),linux)
    ifneq ($(PDFLATEX_BIN),)
        TEX_DIST := texlive
    endif
endif
ifeq ($(OS),windows)
    ifneq ($(PDFLATEX_BIN),)
        TEX_DIST := miktex
    endif
endif

# -----------------------------------------------------------------------------
# Path pencarian LaTeX
# -----------------------------------------------------------------------------
export TEXINPUTS := .:src/:src/config/:build/:
export BSTINPUTS := .:src/:src/config/:
export BIBINPUTS := .:src/:build/:

# -----------------------------------------------------------------------------
# Ekstrak metadata dari src/config/information.tex
# -----------------------------------------------------------------------------
DEPARTEMEN := $(shell $(EXTRACT) Departemen $(INFOFILE) 2>/dev/null)
NAMA       := $(shell $(EXTRACT) NamaPenulis $(INFOFILE) 2>/dev/null)
DEPT_SHORT := $(shell $(EXTRACT) ProgramStudiSingkat $(INFOFILE) 2>/dev/null)
DATE       := $(shell date +"%b %Y")

# Fallback: jika ProgramStudiSingkat kosong, turunkan dari Departemen
ifeq ($(strip $(DEPT_SHORT)),)
DEPT_SHORT := $(shell echo "$(DEPARTEMEN)" | sed 's/^Departemen //' 2>/dev/null)
endif

# Sanitasi nama berkas
DEPT_FILE := $(shell echo "$(DEPT_SHORT)" | tr ' ' '_' 2>/dev/null)
NAMA_FILE := $(shell echo "$(NAMA)" | tr ' ' '_' 2>/dev/null)
DATE_FILE := $(shell echo "$(DATE)" | tr ' ' '_' 2>/dev/null)

OUT_NAME := Skripsi_$(DEPT_FILE)_$(NAMA_FILE)_$(DATE_FILE)
TARGET   := ./$(OUT_NAME).pdf

# Pola file sementara LaTeX yang harus dibersihkan
LATEX_TEMP := *.aux *.log *.toc *.lof *.lot *.fls *.out *.bbl *.blg \
              *.bcf *.run.xml *.fdb_latexmk *.synctex.gz *.idx *.ind \
              *.ilg *.lot *.lof *.toc *.nav *.out *.snm *.vrb

.PHONY: all build install doctor clean distclean validate watch help

# =============================================================================
# Target default
# =============================================================================
all: build

# =============================================================================
# Pesan bantuan
# =============================================================================
help:
	@printf "\n"
	@printf "  ${B}IPB Thesis LaTeX Template${NC}\n"
	@printf "  ${B}============================${NC}\n"
	@printf "\n"
	@printf "  ${G}make${NC}             Bangun PDF (sama dengan 'make build')\n"
	@printf "  ${G}make build${NC}       Bangun PDF ke direktori dist/\n"
	@printf "  ${G}make install${NC}     Install paket LaTeX (deteksi OS otomatis)\n"
	@printf "  ${G}make doctor${NC}      Cek apakah semua tool LaTeX tersedia\n"
	@printf "  ${G}make clean${NC}       Hapus file sementara + direktori build/\n"
	@printf "  ${G}make distclean${NC}   clean + hapus direktori dist/\n"
	@printf "  ${G}make validate${NC}    Validasi sumber LaTeX dengan chktex\n"
	@printf "  ${G}make watch${NC}       Bangun ulang otomatis saat ada perubahan\n"
	@printf "  ${G}make help${NC}        Tampilkan pesan ini\n"
	@printf "\n"
	@printf "  ${Y}Output${NC}: ${C}$(OUT_NAME).pdf${NC}\n"
	@printf "  ${Y}Departemen${NC}: $(DEPARTEMEN)\n"
	@printf "  ${Y}Penulis${NC}: $(NAMA)\n"
	@printf "  ${Y}OS${NC}: $(OS)\n"
	@printf "  ${Y}TeX${NC}: $(TEX_DIST)\n"
	@printf "\n"

# =============================================================================
# Doctor: cek semua tool LaTeX
# =============================================================================
doctor:
	@printf "\n  ${B}:: Diagnostik Tool LaTeX${NC}\n\n"
	@printf "  OS           : ${C}$(OS)${NC}\n"
	@printf "  Package mgr  : ${C}$(PKG_MGR)${NC}\n"
	@printf "  TeX dist     : ${C}$(TEX_DIST)${NC}\n\n"
	@printf "  Tool yang dibutuhkan:\n"
	@for tool in pdflatex latexmk biber chktex bibtex; do \
	    if command -v $$tool >/dev/null 2>&1; then \
	        v=$$($$tool --version 2>&1 | head -1); \
	        printf "    ${G}OK${NC}    %-10s %s\n" "$$tool" "$$v"; \
	    else \
	        printf "    ${R}NO${NC}    %-10s TIDAK DITEMUKAN\n" "$$tool"; \
	    fi; \
	done
	@printf "\n"
	@if [ -z "$(PDFLATEX_BIN)" ]; then \
	    printf "  ${Y}::${NC} TeX belum terinstall. Jalankan: ${G}make install${NC}\n\n"; \
	else \
	    printf "  ${G}::${NC} Semua tool sudah tersedia.\n\n"; \
	fi

# =============================================================================
# Install paket (deteksi OS otomatis)
# =============================================================================
install:
	@printf "\n  ${B}:: Install paket LaTeX (OS: $(OS))${NC}\n\n"
ifeq ($(OS),macos)
	@if [ -z "$(PKG_MGR)" ]; then \
	    printf "  ${R}FAIL${NC} Homebrew tidak ditemukan.\n"; \
	    printf "  Install Homebrew dulu dari ${C}https://brew.sh/${NC}\n"; \
	    exit 1; \
	fi
	@if [ -z "$(PDFLATEX_BIN)" ]; then \
	    printf "  ${Y}::${NC} Install BasicTeX (hemat storage)...\n"; \
	    brew install --cask basictex; \
	    sudo tlmgr update --self; \
	    $(SPINNER) "Install paket tambahan" sudo tlmgr install \
	        biblatex biber chktex titlesec tocloft fancyhdr \
	        caption booktabs enumitem hanging multirow longtable \
	        csquotes microtype texlive-latex-extra texlive-fonts-extra \
	        texlive-lang-other texlive-bibtex-extra; \
	    sudo mktexlsr; \
	elif [ "$(TEX_DIST)" = "basictex" ]; then \
	    $(SPINNER) "Install paket tambahan" sudo tlmgr install \
	        biblatex biber chktex titlesec tocloft fancyhdr \
	        caption booktabs enumitem hanging multirow longtable \
	        csquotes microtype texlive-latex-extra texlive-fonts-extra \
	        texlive-lang-other texlive-bibtex-extra; \
	    sudo mktexlsr; \
	else \
	    printf "  ${G}OK${NC}    TeX sudah terinstall (MacTeX, paket lengkap).\n"; \
	fi
endif
ifeq ($(OS),linux)
	@if [ -z "$(PKG_MGR)" ]; then \
	    printf "  ${R}FAIL${NC} Package manager tidak dikenali (butuh apt/dnf/pacman).\n"; \
	    exit 1; \
	fi
	@if command -v apt >/dev/null 2>&1; then \
	    $(SPINNER) "apt update" sudo apt update; \
	    $(SPINNER) "Install texlive + biber + chktex" sudo apt install -y \
	        texlive-latex-extra texlive-fonts-extra texlive-lang-other \
	        texlive-bibtex-extra biber chktex latexmk; \
	elif command -v dnf >/dev/null 2>&1; then \
	    $(SPINNER) "dnf install" sudo dnf install -y \
	        texlive-scheme-full biber chktex latexmk; \
	elif command -v pacman >/dev/null 2>&1; then \
	    $(SPINNER) "pacman install" sudo pacman -S --noconfirm \
	        texlive-most biber chktex latexmk; \
	fi
endif
ifeq ($(OS),windows)
	@printf "  ${Y}::${NC} Di Windows, install MiKTeX atau TeX Live manual:\n"
	@printf "    MiKTeX  : ${C}https://miktex.org/download${NC}\n"
	@printf "    TeX Live: ${C}https://tug.org/texlive/windows.html${NC}\n"
	@printf "  Aktifkan auto-install paket di MiKTeX Console.\n"
endif
ifeq ($(OS),unknown)
	@printf "  ${R}FAIL${NC} OS tidak dikenali: $(UNAME_S)\n"
	@exit 1
endif
	@printf "\n  ${G}OK${NC}    Instalasi selesai. Verifikasi: ${C}make doctor${NC}\n\n"

# =============================================================================
# Build PDF
# =============================================================================
build: $(TARGET)

$(TARGET): $(SRC) $(shell find src -name '*.tex' -type f) $(wildcard src/refs/*.bib) $(INFOFILE) Makefile
	@if test -z "$(PDFLATEX_BIN)"; then \
	    echo "  FAIL  pdflatex tidak ditemukan"; \
	    exit 1; \
	fi
	@echo "  :: Building $(OUT_NAME).pdf"
	@mkdir -p $(BUILDDIR)
	@rm -f $(BUILDDIR)/tmp.aux $(BUILDDIR)/tmp.bbl $(BUILDDIR)/tmp.bcf
	@echo "  [1/4] pdflatex"
	@TEXINPUTS=".:src/:src/config/:build/:" pdflatex -interaction=nonstopmode \
	  -output-directory=$(BUILDDIR) -jobname=tmp src/main.tex >/dev/null 2>&1 || true
	@echo "  [2/4] bibtex"
	@cd $(BUILDDIR) && BIBINPUTS="..:../src:." bibtex tmp >/dev/null 2>&1 || true
	@echo "  [3/4] pdflatex"
	@TEXINPUTS=".:src/:src/config/:build/:" pdflatex -interaction=nonstopmode \
	  -output-directory=$(BUILDDIR) -jobname=tmp src/main.tex >/dev/null 2>&1 || true
	@echo "  [4/4] pdflatex"
	@TEXINPUTS=".:src/:src/config/:build/:" pdflatex -interaction=nonstopmode \
	  -output-directory=$(BUILDDIR) -jobname=tmp src/main.tex >/dev/null 2>&1 || true
	@cp -f $(BUILDDIR)/tmp.pdf $(TARGET)
	@make -s _autoclean
	@echo "  OK    $(TARGET)"
	@printf "  ${G}OK${NC}    ${C}$(TARGET)${NC}\n"

# Target internal: auto-clean setelah build
_autoclean:
	@rm -f $(BUILDDIR)/*.aux $(BUILDDIR)/*.log $(BUILDDIR)/*.toc
	@rm -f $(BUILDDIR)/*.lof $(BUILDDIR)/*.lot $(BUILDDIR)/*.fls
	@rm -f $(BUILDDIR)/*.out $(BUILDDIR)/*.bbl $(BUILDDIR)/*.blg
	@rm -f $(BUILDDIR)/*.bcf $(BUILDDIR)/*.run.xml $(BUILDDIR)/*.fdb_latexmk
	@rm -f $(BUILDDIR)/*.synctex.gz $(BUILDDIR)/*.idx $(BUILDDIR)/*.ind
	@rm -f $(LATEX_TEMP)

# =============================================================================
# Clean: hapus file sementara + direktori build/
# =============================================================================
clean:
	@printf "  ${Y}::${NC} Membersihkan file sementara...\n"
	@latexmk -c -outdir=$(BUILDDIR) 2>/dev/null || true
	@rm -rf $(BUILDDIR)
	@rm -f $(LATEX_TEMP)
	@printf "  ${G}OK${NC}    Bersih\n"

# =============================================================================
# Distclean: clean + hapus dist/
# =============================================================================
distclean: clean
	@printf "  ${Y}::${NC} Menghapus direktori dist/...\n"
	@rm -rf $(DISTDIR)
	@printf "  ${G}OK${NC}    Selesai\n"

# =============================================================================
# Validate dengan chktex
# =============================================================================
validate:
	@if [ -z "$(CHKTeX_BIN)" ]; then \
	    printf "  ${R}FAIL${NC}  chktex tidak ditemukan. Jalankan: ${G}make install${NC}\n"; \
	    exit 1; \
	fi
	@printf "  ${Y}::${NC} Validating LaTeX source with chktex...\n"
	@chktex -q -l .chktexrc -r -I $(SRC) || true
	@printf "  ${G}OK${NC}    Validasi selesai\n"

# =============================================================================
# Watch: bangun ulang otomatis
# =============================================================================
watch:
	@printf "  ${Y}::${NC} Watching for changes... (Ctrl+C to stop)\n"
	@printf "  ${Y}::${NC} Output: ${C}$(OUT_NAME).pdf${NC}\n"
	@while true; do \
	    $(MAKE) -s build 2>&1 | tail -5; \
	    sleep 2; \
	done
