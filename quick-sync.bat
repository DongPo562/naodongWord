@echo off
chcp 65001 >nul
echo 快速同步到GitHub...
echo.

:: 添加所有更改
git add .

:: 使用时间戳作为默认提交信息
for /f "tokens=1-3 delims=/" %%a in ('date /t') do set mydate=%%a-%%b-%%c
for /f "tokens=1-2 delims=:" %%a in ('time /t') do set mytime=%%a:%%b
set commit_msg=update: 快速更新 %mydate% %mytime%

:: 提交
echo 提交信息: %commit_msg%
git commit -m "%commit_msg%"

:: 推送
echo 推送到GitHub...
git push origin main

if %errorlevel% equ 0 (
    echo.
    echo ✓ 同步成功！
) else (
    echo.
    echo ✗ 同步失败，请检查网络连接或权限
)

echo.
pause