#!/bin/bash

if [ -n "$1" -a -r "${1}.tex" ]; then
  filename="${1}"
elif [ -n "$1" ]; then
  echo "指定されたtexファイルは存在しません。"
  exit 1
elif [ -r "tex.tex" ]; then
  filename="tex"
elif [ -r "tex_sample.tex" ]; then
  filename="tex_sample"
else
  echo "texファイルを指定して下さい。"
  exit 1
fi

texfile="${filename}.tex"
dvifile="${filename}.dvi"
pdffile="${filename}.pdf"
echo "Compile $texfile"
sed -i -e 's/、/，/g' -e 's/。/．/g' $texfile

platex -kanji=utf8 $texfile
if [ $? -ne 0 ]; then
  echo "異常終了"
  exit 1
fi

dvipdfmx $dvifile

result=$(ps | grep " evince$")
# echo ${result}
array=( $(echo ${result}) )
if [ ${#array[@]} -gt 0 ]; then
  kill -KILL ${array[0]}
fi
evince ${pdffile} 2>/dev/null &
