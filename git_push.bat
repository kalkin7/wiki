@echo off
setlocal

chcp 65001
git pull origin gh-pages
git add . -A
set str=
set /p str=Enter Commit Message:
git commit -m "%str%"
git push origin gh-pages