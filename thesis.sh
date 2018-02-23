#!/bin/bash

# OSの情報の取得
if [ "$(uname)" == "Darwin" ]; then
  OS='Mac'
elif [ "$(uname)" == "Linux" ]; then
  OS='Linux'
elif [ "$(uname)" == "MINGW32_NT" ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

# コンパイルするtexファイルの指定
if [ -n "${1}" -a -r "${1}.tex" ]; then
  filename="${1}"
elif [ -n "${1}" ]; then
  echo "「${1}.tex」は存在しません。存在するtexファイルを指定してください。"
  exit 1
elif [ -r "thesis.tex" ]; then
  filename="thesis"
elif [ -r "thesis_sample.tex" ]; then
  filename="thesis_sample"
else
  echo "texファイルを指定して下さい。"
  exit 1
fi

# それぞれの拡張子のファイル名を変数に格納
texfile="${filename}.tex"
dvifile="${filename}.dvi"
pdffile="${filename}.pdf"
echo "Compile $texfile"
sed -i -e 's/、/，/g' -e 's/。/．/g' $texfile

# PDF表示ソフトを閉じる
cmd=$(ps x | grep ${pdffile})
array=( $(echo ${cmd}) )
if [ ${#array[@]} -gt 0 ]; then
  # echo ${array[0]}
  kill -9 ${array[0]}
fi

# texファイルのコンパイル
platex -kanji=utf8 $texfile
if [ $? -ne 0 ]; then
  echo "異常終了"
  exit 1
fi

# PDFファイルの生成
dvipdfmx $dvifile

# PDFファイルの表示
if [ "$OS" == "Mac" ]; then
  open ${pdffile} & 2>/dev/null
elif [ "$OS" == "Linux" ]; then
  xdg-open ${pdffile} & 2>/dev/null
elif [ "$OS" == "MINGW32_NT" ]; then
  cygstart ${pdffile} & 2>/dev/null
else
  echo "手動でPDFファイルを開いてください。"
fi
