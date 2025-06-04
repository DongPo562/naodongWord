@echo off
chcp 65001 >nul
echo ========================================
echo    项目同步到GitHub自动化脚本
echo ========================================
echo.

echo [1/5] 检查Git状态...
git status
if %errorlevel% neq 0 (
    echo 错误: Git状态检查失败
    pause
    exit /b 1
)
echo.

echo [2/5] 添加所有更改到暂存区...
git add .
if %errorlevel% neq 0 (
    echo 错误: 添加文件到暂存区失败
    pause
    exit /b 1
)
echo.

echo [3/5] 检查是否有需要提交的更改...
git diff --cached --quiet
if %errorlevel% equ 0 (
    echo 没有需要提交的更改
    echo 检查是否有未推送的提交...
    git status | findstr "ahead" >nul
    if %errorlevel% equ 0 (
        echo 发现未推送的提交，开始推送...
        goto :push
    ) else (
        echo 所有更改已同步
        pause
        exit /b 0
    )
)

set /p commit_msg="请输入提交信息 (按Enter使用默认信息): "
if "%commit_msg%"=="" set commit_msg=feat: 更新项目文件

echo 提交更改: %commit_msg%
git commit -m "%commit_msg%"
if %errorlevel% neq 0 (
    echo 错误: 提交失败
    pause
    exit /b 1
)
echo.

:push
echo [4/5] 确保远程仓库配置正确...
git remote set-url origin https://github.com/DongPo562/naodongWord.git
echo.

echo [5/5] 推送到GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo 错误: 推送失败，可能需要先拉取远程更改
    echo 尝试拉取并合并...
    git pull origin main --no-edit
    if %errorlevel% neq 0 (
        echo 错误: 拉取失败，请手动解决冲突
        pause
        exit /b 1
    )
    echo 重新推送...
    git push origin main
    if %errorlevel% neq 0 (
        echo 错误: 推送仍然失败
        pause
        exit /b 1
    )
)
echo.

echo ========================================
echo           同步完成！
echo ========================================
echo 验证推送结果...
git status
echo.
echo 最近的提交:
git log --oneline -3
echo.
echo 按任意键退出...
pause >nul