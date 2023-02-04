rem made by Bailey Chase
@echo off
title BaiBOX-Recoveryģʽ
mode con: cols=50 lines=25
color 3f
if exist Data (echo Data>nul) else (md Data)
set device=0
.\bin\adb devices -l | find "recovery" >nul
for /f "delims=" %%i in ('.\bin\adb -d shell getprop ro.product.model') do set name=%%i
if errorlevel 1 (
    echo δ��⵽�豸������ʧ��
	pause
	exit
) else (
    echo ���ӳɹ�
	echo �ֻ����ƣ�%name%
    timeout /t 1
	goto redo
)
:redo
    cls
	set num=11
    echo BaiBOX-Recoveryģʽ(%name%)
    echo ������������ִ�в�����
	echo 0.��������
    echo 1.�豸��Ϣ
    echo 2.��Դѡ��
    echo 3.sideloadģʽ
    echo ����������������������������������������������������������������������������������������������������
    set /p num=����������:
	if %num%==0 (goto cmd_mode)
	if %num%==1 (goto device_info)
	if %num%==2 (goto reboot)
	if %num%==3 (goto sideload)
	if %num%==11 (exit)
    goto check

:reboot
cls
echo ��Դѡ�
echo 0.����
echo 1.�ػ�
echo 2.������ϵͳ
echo 3.������fastboot
echo 4.������recovery
echo 5.������download
echo ����������������������������������������������������������������������������������������������������
set /p nu=������������ִ�в�����
if %nu%==0 (echo �Ѿ�ȡ��ִ�е�Դѡ��)
if %nu%==1 (.\bin\adb shell twrp reboot poweroff>nul)
if %nu%==2 (.\bin\adb shell twrp reboot>nul)
if %nu%==3 (.\bin\adb shell twrp reboot bootloader>nul)
if %nu%==4 (.\bin\adb shell twrp reboot recovery>nul)
if %nu%==5 (.\bin\adb shell twrp reboot download>nul)
goto check

:device_info
.\bin\adb devices -l | findstr model>Data\info.txt
for /f "usebackq tokens=3,4,5 delims=-, " %%i in (Data\info.txt) do (set x=%%i && set y=%%j && set z=%%k)
del Data\info.txt
echo %x:product=��Ʒ����%
echo %y:model=�豸����%
echo %z:device=�豸����%
pause
goto check

:sideload
echo �뽫��ˢ���ļ��ϵ����ﲢ���»س�:
set /p filename=
echo ��ȷ��Ҫ�ѿ�ˢ��%filename%ˢ����[yes/no]
set ck=
set /p ck=
if %ck%==yes (
    .\bin\adb shell twrp sideload
	ping 127.1 -n 5 > nul
	.\bin\adb sideload %filename%
) else (
    echo �Ѿ�ȡ��ִ��
)
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

:check
ping 127.1 -n 2 > nul
echo ִ�����
.\bin\adb devices -l | find "recovery" >nul
if errorlevel 1 (
    echo �豸�Ѿ��Ͽ�
	pause
) else (
    timeout /t 1
	goto redo
)