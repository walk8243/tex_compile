# tex_compile
これは、UNIX環境においてtexファイルをコンパイルし、PDFファイルを生成し表示するためのものです。

PDF表示ソフトには、`evince`を使用しています。  
Ubuntu17.10では、デフォルトのPDF表示ソフトでした。

ここにあるシェルスクリプトでは、Latexをインストールする記述を入れていません。
インストール済み前提で制作しています。

## Start
```
chmod 744 tex.sh
ls -al tex.sh
```
以上のコードで、シェルスクリプトに実行権限を与え、権限の確認を行って下さい。

```
./tex.sh
```
以上のコードで実行出来ます。

## 引数について
引数は、コンパイルtexファイルのみの設定です。  
また、引数には拡張子部分を省いて下さい。  
例：`ファイル：thesis.tex`⇒`引数：thesis`

引数を指定していない場合は、`tex.tex`又は`tex_sample.tex`が存在している場合は、そのファイルを対象にコンパイルが行われます。  
それらのファイルも存在していない場合は、エラーを吐き、処理が止まります。
