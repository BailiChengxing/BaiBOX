rem made by Bailey Chase
@echo off
title BaiBOX-Fastbootģʽ
mode con: cols=50 lines=25
color 3f
set device=0
for /f "delims=" %%i in ('.\fastboot_mode\fastboot devices') do set device=1
if %device%==0 (
    echo δ��⵽�豸
	echo ����ʧ��
	pause
	exit
) else (
    echo �Ѽ�⵽�豸
	echo ���ӳɹ�
	timeout /t 1
	goto redo
)
:redo
    cls
	set num=11
    echo BaiBOX-Fastbootģʽ
    echo ������������ִ�в�����
	echo 0.��������
    echo 1.�豸��Ϣ
    echo 2.��Դѡ��
    echo 3.д��ģʽ
    echo 4.���ģʽ
	echo 5.�ָ���������
	echo 6.�����ȸ���֤
    echo ����������������������������������������������������������������������������������������������������
    set /p num=����������:
	if %num%==0 (goto cmd_mode)
	if %num%==1 (goto device_info)
	if %num%==2 (goto reboot)
	if %num%==3 (goto install)
	if %num%==4 (goto wipe)
	if %num%==5 (.\fastboot_mode\fastboot -w reboot)
	if %num%==6 (.\fastboot_mode\fastboot erase frp)
	if %num%==11 (exit)
    goto check

:cmd_mode
echo ���Ѿ���������ģʽ:
echo ����exit�˳�
cd fastboot_mode
cmd
cd ..
cls
goto check

:device_info
.\fastboot_mode\fastboot getvar all
pause

:install
cls
echo д��ģʽ��
echo 0.����
echo 1.д��recovery����
echo 2.д��system����
echo 3.д��boot����
echo ����������������������������������������������������������������������������������������������������
set /p nu=������������ִ�в�����
if %nu%==0 (echo �Ѿ�ȡ��ִ��д��ģʽ)
if %nu%==1 (
    set mo=recovery
    goto done
)
if %nu%==2 (
    set mo=system
    goto done
)
if %nu%==3 (
	set mo=boot
    goto done
)
goto check

:done
echo �뽫.img�ϵ����ﲢ���»س�:
set /p filename=
echo ��ȷ��Ҫ��%filename%д�뵽%mo%������[yes/no]
set ck=
set /p ck=
if %ck%==yes (.\fastboot_mode\fastboot flash %mo% %filename%) else (echo �Ѿ�ȡ��ִ��)
pause
goto check

:wipe
cls
echo ���ģʽ��
echo 0.����
echo 1.���recovery����
echo 2.���system����
echo 3.���boot����
echo 4.���userdata����
echo 5.���cache����
echo ����������������������������������������������������������������������������������������������������
set /p nu=������������ִ�в�����
if %nu%==0 (echo �Ѿ�ȡ��ִ�����ģʽ)
if %nu%==1 (
    set mo=recovery
    goto done2
)
if %nu%==2 (
    set mo=system
    goto done2
)
if %nu%==3 (
    set mo=boot
    goto done2
)
if %nu%==4 (
    set mo=userdata
    goto done2
)
if %nu%==5 (
    set mo=cache
    goto done2
)
goto check

:done2
echo ��Ҫ���%mo%������[yes/no]
set ck=
set /p ck=
if %ck%==yes (.\fastboot_mode\fastboot erase %mo%) else (echo �Ѿ�ȡ��ִ��)
pause
goto check

:reboot
cls
echo ��Դѡ�
echo 0.����
echo 1.�ػ�
echo 2.������ϵͳ
echo 3.������fastboot
echo 4.������recovery
echo 5.������edlģʽ
echo ����������������������������������������������������������������������������������������������������
set /p nu=������������ִ�в�����
if %nu%==0 (echo �Ѿ�ȡ��ִ�е�Դѡ��)
if %nu%==1 (.\fastboot_mode\fastboot oem poweroff)
if %nu%==2 (.\fastboot_mode\fastboot reboot)
if %nu%==3 (.\fastboot_mode\fastboot reboot-bootloader)
if %nu%==4 (.\fastboot_mode\fastboot oem reboot-recovery)
if %nu%==5 (.\fastboot_mode\fastboot oem edl)
goto check

:check
echo ִ�����
.\fastboot_mode\fastboot devices -l | find "fastboot" >nul
if errorlevel 1 (
    echo �豸�Ѿ��Ͽ�
	pause
) else (
    timeout /t 1
	goto redo
)