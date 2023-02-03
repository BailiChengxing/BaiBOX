rem made by Bailey Chase
rem 此处修改你的ip和port
set ip_adress=192.168.3.57:5555
@echo off
title BaiBOX-ADB模式-WLAN版
mode con: cols=50 lines=25
color 3f
.\adb_mode\adb disconnect >nul
.\adb_mode\adb connect %ip_adress%>nul
.\adb_mode\adb devices -l | findstr model>info.txt
for /f "usebackq tokens=3,4,5 delims=-, " %%i in (info.txt) do (set x=%%i && set y=%%j && set z=%%k)
del info.txt
for /f "delims=" %%i in ('.\adb_mode\adb shell getprop ro.product.model') do set name=%%i
for /f "delims=" %%i in ('.\adb_mode\adb shell getprop ro.build.version.release') do set version=%%i
for /f "delims=" %%i in ('.\adb_mode\adb shell settings get secure android_id') do set device_id=%%i
for /f "delims=" %%i in ('.\adb_mode\adb shell cat /sys/class/net/wlan0/address') do set mac_id=%%i
for /f "delims=" %%i in ('.\adb_mode\adb shell wm size') do set screen=%%i
for /f "delims=" %%i in ('.\adb_mode\adb shell "ip addr | grep inet | grep "/24" | awk '{print $2}' | cut -d "/" -f1"') do set ip_adress=%%i
.\adb_mode\adb devices -l | find "device product:" >nul
if errorlevel 1 (
    echo 连接失败
	pause
	exit
) else (
    echo 连接成功
    echo %y:model:=设备名称：%
	echo %x:product:=产品名称：%
    echo %z:device:=设备代号：%
    echo 安卓版本：%version%
	echo 分辨率：%screen:~15%
	echo 手机ID：%device_id%
	echo MAC_ID：%mac_id%
	echo IP地址:%ip_adress%
	timeout /t 1
	goto redo
)
:redo
    cls
	set num=11
    echo BaiBOX-ADB模式-WLAN版(%name%)
    echo 输入以下数字执行操作：
	echo 0.输入命令
    echo 1.锁屏
    echo 2.电源选项
    echo 3.安装应用
    echo 4.卸载应用
    echo 5.卸载系统应用
    echo 6.adb断开连接
    echo 7.远程控制手机
    echo 8.传输文件到sdcard
    echo 9.输入命令
	echo 10.搜索应用包名
    echo ——————————————————————————————————————————————————
    set /p num=请输入数字:
	if %num%==0 (goto cmd_mode)
    if %num%==1 (.\adb_mode\adb shell input keyevent 26)
    if %num%==2 (goto reboot)
    if %num%==3 (goto install)
    if %num%==4 (goto uninstall)
    if %num%==5 (goto super_uninstall)
    if %num%==6 (.\adb_mode\adb disconnect)
    if %num%==7 (goto link)
    if %num%==8 (goto send)
    if %num%==9 (goto recive)
	if %num%==10 (goto pack)
	if %num%==11 (exit)
    goto check

:pack
set /p ages=请输入关键词：
.\adb_mode\adb shell cmd package list packages|findstr %ages%
pause
goto check


:reboot
cls
echo 电源选项：
echo 0.返回
echo 1.关机
echo 2.重启
echo 3.重启到fastboot
echo 4.重启到recovery
echo 5.重启到edl
echo ——————————————————————————————————————————————————
set /p nu=输入以下数字执行操作：
if %nu%==0 (echo 已经取消执行电源选项)
if %nu%==1 (.\adb_mode\adb shell reboot -p>nul)
if %nu%==2 (.\adb_mode\adb shell reboot>nul)
if %nu%==3 (.\adb_mode\adb reboot bootloader>nul)
if %nu%==4 (.\adb_mode\adb reboot recovery>nul)
if %nu%==5 (.\adb_mode\adb reboot edl>nul)
goto check


:send
echo 请将文件拖到这里并按下回车:
set /p filename=
.\adb_mode\adb push %filename% /sdcard
echo 传输结束！
pause
goto check

:recive
set desk=%userprofile%\desktop
echo 手机主目录为/sdcard/，文件会传输到桌面
echo 请将输入目录及文件名并按下回车:
set /p fname=
.\adb_mode\adb pull %fname% %desk%
echo 传输结束！
pause
goto check

:install
set /p app=请将文件拖到这里并按下回车：
echo 安装中
.\adb_mode\adb install %app%>nul
echo 安装结束
pause
goto check

:uninstall
set /p uapp=请输入要卸载软件的包名：
echo 卸载中
.\adb_mode\adb uninstall %uapp%>nul
echo 卸载结束
pause
goto check

:super_uninstall
set /p uapp=请输入要卸载软件的包名：
echo 卸载中
.\adb_mode\adb shell pm uninstall -k --user 0 %uapp%>nul
echo 卸载结束
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

:link
if exist Bailey_link.bat (start /min Bailey_link.bat) else (goto write)
echo 请等待应用程序启动
goto check

:write
echo .\adb_mode\adb connect 192.168.3.57:5555 > Bailey_link.bat
echo .\adb_mode\scrcpy >> Bailey_link.bat
echo .\adb_mode\adb disconnect >> Bailey_link.bat
start /min Bailey_link.bat
echo 请等待应用程序启动
goto check

:check
echo 执行完毕
.\adb_mode\adb devices -l | find "device product:" >nul
if errorlevel 1 (
    echo 设备已经断开
	pause
) else (
    timeout /t 1
	goto redo
)




