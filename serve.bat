@echo off
rem The Calm Corner — local offline server. Double-click, then open http://localhost:8123
cd /d "%~dp0"
echo Serving The Calm Corner at http://localhost:8123  (close this window to stop)
start "" http://localhost:8123
npx --yes http-server . -p 8123 -c-1
