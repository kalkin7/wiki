@echo off
setlocal

chcp 65001
git pull origin gh-pages
git add . -A
git commit -m "Blog Update"
git push origin gh-pages