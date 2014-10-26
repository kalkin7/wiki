@echo off
setlocal

chcp 65001
git pull origin gh-pages
git add . -A
git commit -m "Link Page Update"
git push origin gh-pages