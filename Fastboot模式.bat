rem made by Bailey Chase
@echo off
title BaiBOX-Fastboot模式
mode con: cols=50 lines=25
color 3f
if exist Data (echo Data>nul) else (md Data)
set device=0
for /f "delims=" %%i in ('.\bin\fastboot devices') do set device=1
if %device%==0 (
    echo 未检测到设备
	echo 连接失败
	pause
	exit
) else (
    echo 已检测到设备
	echo 连接成功
	timeout /t 1
	goto redo
)
:redo
    cls
	set num=11
    echo BaiBOX-Fastboot模式
    echo 输入以下数字执行操作：
	echo 0.输入命令
    echo 1.设备信息
    echo 2.电源选项
    echo 3.写入模式
    echo 4.清除模式
	echo 5.恢复出厂设置
	echo 6.跳过谷歌验证
    echo ——————————————————————————————————————————————————
    set /p num=请输入数字:
	if %num%==0 (goto cmd_mode)
	if %num%==1 (goto device_info)
	if %num%==2 (goto reboot)
	if %num%==3 (goto install)
	if %num%==4 (goto wipe)
	if %num%==5 (.\bin\fastboot -w reboot)
	if %num%==6 (.\bin\fastboot erase frp)
	if %num%==11 (exit)
    goto check

:cmd_mode
echo 你已经进入输入模式:
echo 输入exit退出
cd bin
cmd
cd ..
cls
goto check

:device_info
.\bin\fastboot getvar all
pause
goto check

:install
cls
echo 写入模式：
echo 0.返回
echo 1.写入recovery分区
echo 2.写入system分区
echo 3.写入boot分区
echo ——————————————————————————————————————————————————
set /p nu=输入以下数字执行操作：
if %nu%==0 (echo 已经取消执行写入模式)
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
echo 请将.img拖到这里并按下回车:
set /p filename=
echo 你确定要把%filename%写入到%mo%分区吗？[yes/no]
set ck=
set /p ck=
if %ck%==yes (.\bin\fastboot flash %mo% %filename%) else (echo 已经取消执行)
pause
goto check

:wipe
cls
echo 清除模式：
echo 0.返回
echo 1.清除recovery分区
echo 2.清除system分区
echo 3.清除boot分区
echo 4.清除userdata分区
echo 5.清除cache分区
echo ——————————————————————————————————————————————————
set /p nu=输入以下数字执行操作：
if %nu%==0 (echo 已经取消执行清除模式)
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
echo 你要清除%mo%分区吗？[yes/no]
set ck=
set /p ck=
if %ck%==yes (.\bin\fastboot erase %mo%) else (echo 已经取消执行)
pause
goto check

:reboot
cls
echo 电源选项：
echo 0.返回
echo 1.关机
echo 2.重启到系统
echo 3.重启到fastboot
echo 4.重启到recovery
echo 5.重启到edl模式
echo ——————————————————————————————————————————————————
set /p nu=输入以下数字执行操作：
if %nu%==0 (echo 已经取消执行电源选项)
if %nu%==1 (.\bin\fastboot oem poweroff)
if %nu%==2 (.\bin\fastboot reboot)
if %nu%==3 (.\bin\fastboot reboot-bootloader)
if %nu%==4 (.\bin\fastboot oem reboot-recovery)
if %nu%==5 (.\bin\fastboot oem edl)
goto check

:check
ping 127.1 -n 2 > nul
echo 执行完毕
.\bin\fastboot devices -l | find "fastboot" >nul
if errorlevel 1 (
    echo 设备已经断开
	pause
) else (
    timeout /t 1
	goto redo
)