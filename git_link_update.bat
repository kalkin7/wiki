@echo off
setlocal

git pull origin gh-pages
git add . -A
git commit -m "Link Page Update"
git push origin gh-pages