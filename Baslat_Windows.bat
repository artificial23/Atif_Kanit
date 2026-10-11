@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
cd /d "%~dp0"
set PYTHONIOENCODING=utf-8
set PYTHONUTF8=1
set "LOG=%~dp0kurulum_log.txt"
set "VPY=%~dp0.venv\Scripts\python.exe"
set "KONTROL=import yaml, requests, openpyxl, pymupdf, rapidfuzz, streamlit"

echo ============================================================
echo   AtifKanit - Docentlik / Akademik Tesvik Atif Kanit Paketi
echo ============================================================

rem ---------- 1) Uygun Python'u bul (3.13 / 3.12 / 3.11 / 3.14 / 3.10)
set "PY="
for %%V in (3.13 3.12 3.11 3.14 3.10) do (
  if not defined PY (
    py -%%V -c "import sys" >nul 2>nul && set "PY=py -%%V"
  )
)
if not defined PY (
  python -c "import sys; sys.exit(0 if sys.version_info>=(3,10) else 1)" >nul 2>nul && set "PY=python"
)
if not defined PY (
  echo [HATA] Uygun Python bulunamadi ^(3.10 veya ustu gerekli^).
  echo        https://www.python.org/downloads/ adresinden Python 3.12 kurun.
  echo        Kurulumda "Add python.exe to PATH" kutusunu isaretleyin.
  pause
  exit /b 1
)
echo Kullanilan Python komutu: !PY!
!PY! --version

rem ---------- 2) Sanal ortam (bozuksa yeniden olustur)
if exist ".venv" if not exist "%VPY%" (
  echo Bozuk sanal ortam bulundu, yeniden olusturuluyor...
  rmdir /s /q ".venv"
)
if not exist "%VPY%" (
  echo [1/3] Sanal ortam olusturuluyor...
  !PY! -m venv .venv
  if errorlevel 1 (
    echo [HATA] Sanal ortam olusturulamadi.
    pause
    exit /b 1
  )
)

rem ---------- 3) Kutuphaneler: her calistirmada kontrol et, eksikse kur
"%VPY%" -c "%KONTROL%" >nul 2>nul
if errorlevel 1 (
  echo [2/3] Kutuphaneler yukleniyor - ilk seferde 2-5 dakika surebilir...
  echo Kurulum gunlugu: "!LOG!"
  "%VPY%" -m pip install --upgrade pip > "%LOG%" 2>&1
  "%VPY%" -m pip install -r requirements.txt >> "%LOG%" 2>&1
  if errorlevel 1 goto kurulum_hatasi
  "%VPY%" -m pip install --no-deps -e . >> "%LOG%" 2>&1
  "%VPY%" -c "%KONTROL%" >> "%LOG%" 2>&1
  if errorlevel 1 goto kurulum_hatasi
  echo      Kutuphaneler hazir.
)

rem ---------- 4) Chromium (web ekran goruntuleri icin; basarisiz olursa program yine calisir)
if not exist ".venv\chromium_tamam.txt" (
  echo [3/3] Chromium indiriliyor - ekran goruntuleri icin...
  "%VPY%" -m playwright install chromium >> "%LOG%" 2>&1
  if errorlevel 1 (
    echo [UYARI] Chromium kurulamadi. Program calisir, yalnizca web ekran goruntusu alinamaz.
  ) else (
    echo ok> ".venv\chromium_tamam.txt"
  )
)

echo.
echo Arayuz tarayicinizda aciliyor. Programi kapatmak icin bu pencereyi kapatin.
"%VPY%" -m atifkanit arayuz
pause
exit /b 0

:kurulum_hatasi
echo.
echo [HATA] Kutuphaneler kurulamadi. Son 25 satir:
echo ------------------------------------------------------------
powershell -NoProfile -Command "Get-Content -Tail 25 -LiteralPath '%LOG%'"
echo ------------------------------------------------------------
echo Olasi nedenler: internet / kurum proxy engeli veya desteklenmeyen Python surumu.
echo Cozum: 1^) Python 3.12 kurun  2^) .venv klasorunu silin  3^) bu dosyayi tekrar calistirin.
echo Sorun surerse kurulum_log.txt dosyasini gonderin.
pause
exit /b 1
