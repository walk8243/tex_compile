@echo off
chcp 932 > nul

REM texファイルの指定
IF "%1" == "/?" (
  GOTO usage
) ELSE IF not "%1" == "" (
  IF not exist %1.tex (
    echo 「%1.tex」は存在しません。存在するtexファイルを指定してください。
    exit /B 1
  )
  set filename=%1
) ELSE IF exist thesis.tex (
  set filename=thesis
) ELSE IF exist thesis_sample.tex (
  set filename=thesis_sample
) ELSE (
  echo texファイルを指定してください。
  GOTO usage
  exit /B 1
)
echo %filename%

REM 各ファイル名
set texFile=%filename%.tex
set dviFile=%filename%.dvi
set pdfFile=%filename%.pdf
REM echo %pdfFile%

REM PDFファイルが開かれていないかの確認
set CMD=tasklist /FI "USERNAME eq %userdomain%\%username%" /FI "WINDOWTITLE eq %pdfFile%" /NH
for /f "usebackq tokens=1,2,3*" %%a in (`%CMD%`) do (
  IF "%%a" == "情報:" (
    REM PDFファイルは起動していない
  ) else (
    REM PDFファイルが起動している
    REM echo %%b
    taskkill /PID %%b > nul
    IF not %ERRORLEVEL% == 0 (
      echo ERROR：PDFを閉じれませんでした。
      exit /B 1
    )
  )
)

REM texファイルのコンパイル
platex -kanji=utf8 %texFile%
REM PDFファイルの生成
dvipdfmx %dviFile%
REM PDFファイルの表示
start %pdfFile%


:usage
echo ^
%0 [texファイル名]

echo ^
説明：

echo ^
パラメータ一覧：
