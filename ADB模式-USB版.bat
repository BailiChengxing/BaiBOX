rem made by Bailey Chase
@echo off
title BaiBOX-ADBģʽ-USB��
mode con: cols=50 lines=25
color 3f
if exist Data (echo Data>nul) else (md Data)
.\bin\adb disconnect >nul
.\bin\adb devices -l | findstr model>Data\info.txt
for /f "usebackq tokens=3,4,5 delims=-, " %%i in (Data\info.txt) do (set x=%%i && set y=%%j && set z=%%k)
del Data\info.txt
for /f "delims=" %%i in ('.\bin\adb shell getprop ro.product.model') do set name=%%i
for /f "delims=" %%i in ('.\bin\adb -d shell getprop ro.build.version.release') do set version=%%i
for /f "delims=" %%i in ('.\bin\adb -d shell settings get secure android_id') do set device_id=%%i
for /f "delims=" %%i in ('.\bin\adb -d shell cat /sys/class/net/wlan0/address') do set mac_id=%%i
for /f "delims=" %%i in ('.\bin\adb -d shell wm size') do set screen=%%i
for /f "delims=" %%i in ('.\bin\adb shell "ip addr | grep inet | grep "/24" | awk '{print $2}' | cut -d "/" -f1"') do set ip=%%i
.\bin\adb -d devices -l | find "device product:" >nul
if errorlevel 1 (
    echo ����ʧ��
	pause
	exit
) else (
	echo ���ӳɹ�
    echo %y:model:=�豸���ƣ�%
	echo %x:product:=��Ʒ���ƣ�%
    echo %z:device:=�豸���ţ�%
    echo ��׿�汾��%version%
	echo �ֱ��ʣ�%screen:~15%
	echo �ֻ�ID��%device_id%
	echo MAC_ID��%mac_id%
	echo IP��ַ��%ip%
	timeout /t 1
	goto redo
)
:redo
    cls
	set num=11
    echo BaiBOX-ADBģʽ-USB��(%name%)
    echo ������������ִ�в�����
	echo 0.��������
    echo 1.����
    echo 2.��Դѡ��
    echo 3.��װӦ��
    echo 4.ж��Ӧ��
    echo 5.ж��ϵͳӦ��
    echo 6.��������adb����
    echo 7.Զ�̿����ֻ�
    echo 8.�����ļ����ֻ�sdcard
    echo 9.�����ļ�������desktop
	echo 10.����Ӧ�ð���
    echo ����������������������������������������������������������������������������������������������������
    set /p num=����������:
	if %num%==0 (goto cmd_mode)
    if %num%==1 (.\bin\adb -d shell input keyevent 26)
    if %num%==2 (goto reboot)
    if %num%==3 (goto install)
    if %num%==4 (goto uninstall)
    if %num%==5 (goto super_uninstall)
    if %num%==6 (.\bin\adb -d tcpip 5555)
    if %num%==7 (goto link)
    if %num%==8 (goto send)
    if %num%==9 (goto recive)
	if %num%==10 (goto pack)
	if %num%==11 (exit)
    goto check

:pack
set /p ages=������ؼ��ʣ�
.\bin\adb -d shell cmd package list packages|findstr %ages%
pause
goto check


:reboot
cls
echo ��Դѡ�
echo 0.����
echo 1.�ػ�
echo 2.����
echo 3.������fastboot
echo 4.������recovery
echo 5.������edl
echo ����������������������������������������������������������������������������������������������������
set /p nu=������������ִ�в�����
if %nu%==0 (echo �Ѿ�ȡ��ִ�е�Դѡ��)
if %nu%==1 (.\bin\adb -d shell reboot -p>nul)
if %nu%==2 (.\bin\adb -d shell reboot>nul)
if %nu%==3 (.\bin\adb -d reboot bootloader>nul)
if %nu%==4 (.\bin\adb -d reboot recovery>nul)
if %nu%==5 (.\bin\adb -d reboot edl>nul)
goto check


:send
echo �뽫�ļ��ϵ����ﲢ���»س�:
set /p filename=
.\bin\adb -d push %filename% /sdcard
echo ���������
pause
goto check

:recive
set desk=%userprofile%\desktop
echo �ֻ���Ŀ¼Ϊ/sdcard/���ļ��ᴫ�䵽����
echo �뽫����Ŀ¼���ļ��������»س�:
set /p fname=
.\bin\adb -d pull %fname% %desk%
echo ���������
pause
goto check

:install
set /p app=�뽫�ļ��ϵ����ﲢ���»س���
echo ��װ��
.\bin\adb -d install %app%>nul
echo ��װ����
pause
goto check

:uninstall
set /p uapp=������Ҫж������İ�����
echo ж����
.\bin\adb -d uninstall %uapp%>nul
echo ж�ؽ���
pause
goto check

:super_uninstall
set /p uapp=������Ҫж������İ�����
echo ж����
.\bin\adb -d shell pm uninstall -k --user 0 %uapp%>nul
echo ж�ؽ���
pause
goto check

:cmd_mode
echo ���Ѿ���������ģʽ:
echo ����exit�˳�
cd bin
cmd
cd ..
cls
goto check

:link
set luanch_name=Data\luanch" ""%name%".bat
if exist %luanch_name% (start /min %luanch_name%) else (goto write)
echo ��ȴ�Ӧ�ó�������
goto check

:write
echo .\bin\scrcpy -d>>%luanch_name%
echo .\bin\adb -d disconnect>>%luanch_name%
start /min %luanch_name%
echo ��ȴ�Ӧ�ó�������
goto check

:check
echo ִ�����
.\bin\adb -d devices -l | find "device product:" >nul
if errorlevel 1 (
    echo �豸�Ѿ��Ͽ�
	pause
) else (
    timeout /t 1
	goto redo
)




