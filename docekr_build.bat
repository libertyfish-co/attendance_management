@echo off

rem 作成日：2022/8/30
rem 作成者：能瀬
rem 更新日：2022/9/1
rem 更新者：能瀬

echo.
echo ---【%date% %time%】※注意※ ----------------------------------------------------------------
echo ---【%date% %time%】このバッチは、コマンドプロンプトを管理者権限で起動し --------------------
echo ---【%date% %time%】git からクローンしたリポジトリに移動してから ----------------------------
echo ---【%date% %time%】このバッチをドラッグ＆ドロップして実行してください ----------------------
echo ---------------------------------------------------------------------------------------------
echo.
echo ---【%date% %time%】※docker のサービスが起動済みなら管理者権限不要※------------------------


:loop1
echo.
set /P a1="↑やった？(y=YES / n=NO)"
if /i {%a1%}=={n} (goto :exitlabel)
if /i not {%a1%}=={y} (goto :loop1)


echo.
echo ---【%date% %time%】dokcer のサービスを起動 -------------------------------------------------

echo.
sc query com.docker.service

echo.
sc start com.docker.service

echo.
sc query com.docker.service


echo.
echo ---【%date% %time%】volume を作成 -----------------------------------------------------------

echo.
docker volume create am_app

echo.
echo ---image, container を1つずつ作成(postgres、am_web)------------------------------------------

echo.
echo docker-compose build --no-cache --progress=plain
docker-compose build --no-cache --progress=plain

echo.
echo ---【%date% %time%】残り全部のimage, container を作成、起動 ---------------------------------
echo docker-compose up -d
docker-compose up -d


rem :loop2
rem echo.
rem set /P a2="DBつくる？(y=YES / n=NO)"

rem if /i {%a2%}=={n} (goto :no)
rem if /i not {%a2%}=={y} (goto :loop2)

rem Yes の処理

echo.
echo ---【%date% %time%】db 作成 ～ seed 投入まで ------------------------------------------------

echo.
echo docker exec -it am_web rails db:create
docker exec -it am_web rails db:create

echo.
echo docker exec -it am_web rails db:migrate
docker exec -it am_web rails db:migrate

echo.
echo docker exec -it am_web rails db:seed
docker exec -it am_web rails db:seed


rem :no


echo.
echo ---【%date% %time%】webpacker:install -------------------------------------------------------
echo --- conflict は n を入力(2回) ---------------------------------------------------------------

rem set n^
rem n

echo.
rem echo %n%| docker exec -it am_web webpacker:install
rem echo %n%| docker exec -it am_web rails webpacker:install

echo docker exec -it am_web webpacker:install
echo docker exec -it am_web rails webpacker:install

echo ---【%date% %time%】webpacker:compile -------------------------------------------------------

echo.
echo docker exec -it am_web rails webpacker:compile
docker exec -it am_web rails webpacker:compile


echo.
echo ---うまくいけばコンテナが起動してるはず -----------------------------------------------------

echo.
echo ---【%date% %time%】イメージが3つあること ---------------------------------------------------
echo --- am_web ----------------------------------------------------------------------------------
echo --- postgres --------------------------------------------------------------------------------
echo --- dpage/pgadmin4 --------------------------------------------------------------------------

echo.
echo docker images
docker images

echo.
echo ---【%date% %time%】コンテナが3つあって、すべてのステータスが「UP」であること ---------------
echo --- am_web ----------------------------------------------------------------------------------
echo --- am_db -----------------------------------------------------------------------------------
rem ↓これいらん気持ち(postgres の管理ツールだけど動きが怪しい)
echo ---【%date% %time%】pgadmin4 ----------------------------------------------------------------

echo.
echo docker container ls -a
docker container ls -a


echo.
echo ---【%date% %time%】ボリュームがあること(am_app) ---------------------------------------------

echo.
echo docker volume ls
docker volume ls



echo ---【%date% %time%】ブラウザでログイン画面を起動 --------------------------------------------
echo.
rem start http://localhost:3000/employees/sign_in

rem ---【%date% %time%】Edge がいい人向け ---------------------------------------------------------
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --profile-directory=Default http://localhost:3000/attendances


rem 終了処理

:exitlabel

echo.
echo ---【%date% %time%】処理を終了します --------------------------------------------------------

echo.
pause

