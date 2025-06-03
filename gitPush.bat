@echo off
echo 正在检查Git状态...
git status
echo.
echo 确保使用HTTPS URL...
git remote set-url origin https://github.com/DongPo562/naodongWord.git
echo.
echo 开始推送...
git push origin main
echo.
echo 验证推送结果...
git status
echo.
echo 推送完成！
pause
