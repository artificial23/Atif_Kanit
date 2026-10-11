#!/bin/bash
# AtıfKanıt başlatıcı (macOS / Linux)
cd "$(dirname "$0")" || exit 1
LOG="$(pwd)/kurulum_log.txt"
KONTROL="import yaml, requests, openpyxl, pymupdf, rapidfuzz, streamlit"

# 1) Uygun Python (3.13 / 3.12 / 3.11 / 3.14 / 3.10)
PY=""
for v in 3.13 3.12 3.11 3.14 3.10; do
  if command -v "python$v" >/dev/null 2>&1; then PY="python$v"; break; fi
done
if [ -z "$PY" ] && command -v python3 >/dev/null 2>&1 && python3 -c "import sys; sys.exit(0 if sys.version_info>=(3,10) else 1)"; then PY=python3; fi
if [ -z "$PY" ]; then
  echo "[HATA] Python 3.10+ bulunamadı. https://www.python.org/downloads/ adresinden Python 3.12 kurun."
  read -r -p "Kapatmak için Enter..." _; exit 1
fi
echo "Python: $PY ($($PY --version 2>&1))"

# 2) Sanal ortam (bozuksa yeniden oluştur)
if [ -d .venv ] && [ ! -x .venv/bin/python ]; then rm -rf .venv; fi
if [ ! -x .venv/bin/python ]; then
  echo "[1/3] Sanal ortam oluşturuluyor..."
  "$PY" -m venv .venv || { echo "[HATA] Sanal ortam oluşturulamadı"; read -r _; exit 1; }
fi
VPY="$(pwd)/.venv/bin/python"

# 3) Kütüphaneler: her çalıştırmada kontrol, eksikse kur
if ! "$VPY" -c "$KONTROL" >/dev/null 2>&1; then
  echo "[2/3] Kütüphaneler yükleniyor (ilk seferde 2-5 dk)... Günlük: $LOG"
  "$VPY" -m pip install --upgrade pip > "$LOG" 2>&1
  if ! "$VPY" -m pip install -r requirements.txt >> "$LOG" 2>&1 || ! "$VPY" -m pip install --no-deps -e . >> "$LOG" 2>&1 \
     || ! "$VPY" -c "$KONTROL" >> "$LOG" 2>&1; then
    echo "[HATA] Kütüphaneler kurulamadı. Son satırlar:"; tail -n 25 "$LOG"
    echo "Çözüm: Python 3.12 kurun, .venv klasörünü silin, tekrar çalıştırın. Sorun sürerse kurulum_log.txt'yi gönderin."
    read -r -p "Kapatmak için Enter..." _; exit 1
  fi
fi

# 4) Chromium (isteğe bağlı)
if [ ! -f .venv/chromium_tamam.txt ]; then
  echo "[3/3] Chromium indiriliyor (ekran görüntüleri için)..."
  if "$VPY" -m playwright install chromium >> "$LOG" 2>&1; then echo ok > .venv/chromium_tamam.txt
  else echo "[UYARI] Chromium kurulamadı; program çalışır, yalnız web ekran görüntüsü alınamaz."; fi
fi

echo "Arayüz tarayıcınızda açılıyor. Kapatmak için bu pencereyi kapatın."
"$VPY" -m atifkanit arayuz
