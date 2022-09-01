@echo off

rem �쐬���F2022/8/30
rem �쐬�ҁF�\��
rem �X�V���F2022/9/1
rem �X�V�ҁF�\��

echo.
echo ---�y%date% %time%�z�����Ӂ� ----------------------------------------------------------------
echo ---�y%date% %time%�z���̃o�b�`�́A�R�}���h�v�����v�g���Ǘ��Ҍ����ŋN���� --------------------
echo ---�y%date% %time%�zgit ����N���[���������|�W�g���Ɉړ����Ă��� ----------------------------
echo ---�y%date% %time%�z���̃o�b�`���h���b�O���h���b�v���Ď��s���Ă������� ----------------------
echo ---------------------------------------------------------------------------------------------
echo.
echo ---�y%date% %time%�z��docker �̃T�[�r�X���N���ς݂Ȃ�Ǘ��Ҍ����s�v��------------------------


:loop1
echo.
set /P a1="��������H(y=YES / n=NO)"
if /i {%a1%}=={n} (goto :exitlabel)
if /i not {%a1%}=={y} (goto :loop1)


echo.
echo ---�y%date% %time%�zdokcer �̃T�[�r�X���N�� -------------------------------------------------

echo.
sc query com.docker.service

echo.
sc start com.docker.service

echo.
sc query com.docker.service


echo.
echo ---�y%date% %time%�zvolume ���쐬 -----------------------------------------------------------

echo.
docker volume create am_app

echo.
echo ---image, container ��1���쐬(postgres�Aam_web)------------------------------------------

echo.
echo docker-compose build --no-cache --progress=plain
docker-compose build --no-cache --progress=plain

echo.
echo ---�y%date% %time%�z�c��S����image, container ���쐬�A�N�� ---------------------------------
echo docker-compose up -d
docker-compose up -d


rem :loop2
rem echo.
rem set /P a2="DB����H(y=YES / n=NO)"

rem if /i {%a2%}=={n} (goto :no)
rem if /i not {%a2%}=={y} (goto :loop2)

rem Yes �̏���

echo.
echo ---�y%date% %time%�zdb �쐬 �` seed �����܂� ------------------------------------------------

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
echo ---�y%date% %time%�zwebpacker:install -------------------------------------------------------
echo --- conflict �� n �����(2��) ---------------------------------------------------------------

rem set n^
rem n

echo.
rem echo %n%| docker exec -it am_web webpacker:install
rem echo %n%| docker exec -it am_web rails webpacker:install

echo docker exec -it am_web webpacker:install
echo docker exec -it am_web rails webpacker:install

echo ---�y%date% %time%�zwebpacker:compile -------------------------------------------------------

echo.
echo docker exec -it am_web rails webpacker:compile
docker exec -it am_web rails webpacker:compile


echo.
echo ---���܂������΃R���e�i���N�����Ă�͂� -----------------------------------------------------

echo.
echo ---�y%date% %time%�z�C���[�W��3���邱�� ---------------------------------------------------
echo --- am_web ----------------------------------------------------------------------------------
echo --- postgres --------------------------------------------------------------------------------
echo --- dpage/pgadmin4 --------------------------------------------------------------------------

echo.
echo docker images
docker images

echo.
echo ---�y%date% %time%�z�R���e�i��3�����āA���ׂẴX�e�[�^�X���uUP�v�ł��邱�� ---------------
echo --- am_web ----------------------------------------------------------------------------------
echo --- am_db -----------------------------------------------------------------------------------
rem �����ꂢ���C����(postgres �̊Ǘ��c�[�������Ǔ�����������)
echo ---�y%date% %time%�zpgadmin4 ----------------------------------------------------------------

echo.
echo docker container ls -a
docker container ls -a


echo.
echo ---�y%date% %time%�z�{�����[�������邱��(am_app) ---------------------------------------------

echo.
echo docker volume ls
docker volume ls



echo ---�y%date% %time%�z�u���E�U�Ń��O�C����ʂ��N�� --------------------------------------------
echo.
rem start http://localhost:3000/employees/sign_in

rem ---�y%date% %time%�zEdge �������l���� ---------------------------------------------------------
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --profile-directory=Default http://localhost:3000/attendances


rem �I������

:exitlabel

echo.
echo ---�y%date% %time%�z�������I�����܂� --------------------------------------------------------

echo.
pause

