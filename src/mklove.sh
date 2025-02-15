date "+Compiled: %Y/%m/%d %H:%M:%S" > version.txt
rm ../love-ansi.love
zip -9 -r -x\.git/* ../love-ansi.love . -x '**/.*'