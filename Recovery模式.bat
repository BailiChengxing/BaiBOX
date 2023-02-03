rem made by Bailey Chase
@echo off
title BaiBOX-Recovery模式
mode con: cols=50 lines=25
color 3f
set device=0
.\adb_mode\adb devices -l | find "recovery" >nul
for /f "delims=" %%i in ('.\adb_mode\adb -d shell getprop ro.product.model') do set name=%%i
if errorlevel 1 (
    echo 未检测到设备，连接失败
	pause
	exit
) else (
    echo 连接成功
	echo 手机名称：%name%
    timeout /t 1
	goto redo
)
:redo
    cls
	set num=11
    echo BaiBOX-Recovery模式(%name%)
    echo 输入以下数字执行操作：
	echo 0.输入命令
    echo 1.设备信息
    echo 2.电源选项
    echo 3.sideload模式
    echo ——————————————————————————————————————————————————
    set /p num=请输入数字:
	if %num%==0 (goto cmd_mode)
	if %num%==1 (goto device_info)
	if %num%==2 (goto reboot)
	if %num%==3 (goto sideload)
	if %num%==11 (exit)
    goto check

:reboot
cls
echo 电源选项：
echo 0.返回
echo 1.关机
echo 2.重启到系统
echo 3.重启到fastboot
echo 4.重启到recovery
echo 5.重启到download
echo ——————————————————————————————————————————————————
set /p nu=输入以下数字执行操作：
if %nu%==0 (echo 已经取消执行电源选项)
if %nu%==1 (.\adb_mode\adb shell twrp reboot poweroff>nul)
if %nu%==2 (.\adb_mode\adb shell twrp reboot>nul)
if %nu%==3 (.\adb_mode\adb shell twrp reboot bootloader>nul)
if %nu%==4 (.\adb_mode\adb shell twrp reboot recovery>nul)
if %nu%==5 (.\adb_mode\adb shell twrp reboot download>nul)
goto check

:device_info
.\adb_mode\adb devices -l | findstr model>info.txt
for /f "usebackq tokens=3,4,5 delims=-, " %%i in (info.txt) do (set x=%%i && set y=%%j && set z=%%k)
echo %x:product=产品名称%
echo %y:model=设备名称%
echo %z:device=设备代号%
del info.txt
pause
goto check

:sideload
echo 请将卡刷包文件拖到这里并按下回车:
set /p filename=
echo 你确定要把卡刷包%filename%刷入吗[yes/no]
set ck=
set /p ck=
if %ck%==yes (
    .\adb_mode\adb shell twrp sideload
	ping 127.1 -n 5 > nul
	.\adb_mode\adb sideload %filename%
) else (
    echo 已经取消执行
)
pause
goto check

:cmd_mode
echo 你已经进入输入模式:
echo 输入exit退出
cd adb_mode
cmd
cd ..
cls
goto check

:check
echo 执行完毕
.\adb_mode\adb devices -l | find "recovery" >nul
if errorlevel 1 (
    echo 设备已经断开
	pause
) else (
    timeout /t 1
	goto redo
)