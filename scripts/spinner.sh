#!/usr/bin/env bash
# scripts/spinner.sh
#
# Menampilkan animasi spinner selama perintah berjalan.
# Pemakaian: spinner.sh "Deskripsi" perintah arg1 arg2 ...
#
# Otomatis non-aktif saat stdout bukan terminal (untuk hasil yang bersih
# di log CI). Set FORCE_SPINNER=1 untuk memaksa spinner tetap aktif.

set -u

desc="$1"
shift

# Non-aktif bila bukan TTY (kecuali dipaksa)
if [ ! -t 1 ] && [ -z "${FORCE_SPINNER:-}" ]; then
    printf "  %s\n" "$desc"
    "$@"
    exit $?
fi

# Karakter animasi (braille patterns)
chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
C_CYAN=$'\033[0;36m'
C_GREEN=$'\033[0;32m'
C_RED=$'\033[0;31m'
C_NC=$'\033[0m'

# Jalankan spinner di subshell
(
    i=0
    while true; do
        idx=$((i % ${#chars}))
        char="${chars:idx:1}"
        printf "\r  ${C_CYAN}${char}${C_NC} %s" "$desc"
        i=$((i + 1))
        sleep 0.1
    done
) &
sp_pid=$!

# Jalankan perintah yang sebenarnya
"$@"
exit_code=$?

# Hentikan spinner
kill "$sp_pid" 2>/dev/null
wait "$sp_pid" 2>/dev/null

# Tampilkan hasil
if [ "$exit_code" -eq 0 ]; then
    printf "\r  ${C_GREEN}OK${C_NC}      %s\n" "$desc"
else
    printf "\r  ${C_RED}FAIL${C_NC}    %s\n" "$desc"
fi

exit "$exit_code"
