# 项目同步到GitHub自动化脚本 (PowerShell版本)
# 使用方法: .\sync-to-github.ps1 [提交信息]

param(
    [string]$CommitMessage = ""
)

# 设置控制台编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    项目同步到GitHub自动化脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

try {
    # 检查是否在Git仓库中
    Write-Host "[1/6] 检查Git仓库状态..." -ForegroundColor Yellow
    $gitStatus = git status 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "当前目录不是Git仓库或Git未安装"
    }
    Write-Host $gitStatus
    Write-Host ""

    # 添加所有更改
    Write-Host "[2/6] 添加所有更改到暂存区..." -ForegroundColor Yellow
    git add .
    if ($LASTEXITCODE -ne 0) {
        throw "添加文件到暂存区失败"
    }
    Write-Host "所有更改已添加到暂存区" -ForegroundColor Green
    Write-Host ""

    # 检查是否有需要提交的更改
    Write-Host "[3/6] 检查待提交的更改..." -ForegroundColor Yellow
    git diff --cached --quiet
    $hasChanges = $LASTEXITCODE -ne 0

    if (-not $hasChanges) {
        Write-Host "没有需要提交的更改" -ForegroundColor Green
        # 检查是否有未推送的提交
        $status = git status --porcelain=v1 2>&1
        $ahead = git status | Select-String "ahead"
        if ($ahead) {
            Write-Host "发现未推送的提交，开始推送..." -ForegroundColor Yellow
        } else {
            Write-Host "所有更改已同步到GitHub" -ForegroundColor Green
            return
        }
    } else {
        # 获取提交信息
        if ([string]::IsNullOrEmpty($CommitMessage)) {
            $CommitMessage = Read-Host "请输入提交信息 (按Enter使用默认信息)"
            if ([string]::IsNullOrEmpty($CommitMessage)) {
                $CommitMessage = "feat: 更新项目文件 - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
            }
        }

        Write-Host "[4/6] 提交更改: $CommitMessage" -ForegroundColor Yellow
        git commit -m $CommitMessage
        if ($LASTEXITCODE -ne 0) {
            throw "提交失败"
        }
        Write-Host "提交成功" -ForegroundColor Green
        Write-Host ""
    }

    # 确保远程仓库配置
    Write-Host "[5/6] 确保远程仓库配置正确..." -ForegroundColor Yellow
    git remote set-url origin https://github.com/DongPo562/naodongWord.git
    Write-Host "远程仓库配置完成" -ForegroundColor Green
    Write-Host ""

    # 推送到GitHub
    Write-Host "[6/6] 推送到GitHub..." -ForegroundColor Yellow
    git push origin main
    if ($LASTEXITCODE -ne 0) {
        Write-Host "推送失败，尝试先拉取远程更改..." -ForegroundColor Yellow
        git pull origin main --no-edit
        if ($LASTEXITCODE -ne 0) {
            throw "拉取失败，可能存在冲突需要手动解决"
        }
        Write-Host "重新推送..." -ForegroundColor Yellow
        git push origin main
        if ($LASTEXITCODE -ne 0) {
            throw "推送仍然失败"
        }
    }
    Write-Host "推送成功" -ForegroundColor Green
    Write-Host ""

    # 显示结果
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "           同步完成！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "当前状态:" -ForegroundColor Cyan
    git status
    Write-Host ""
    Write-Host "最近的提交:" -ForegroundColor Cyan
    git log --oneline -3
    Write-Host ""
    Write-Host "GitHub仓库: https://github.com/DongPo562/naodongWord" -ForegroundColor Blue

} catch {
    Write-Host "错误: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "请检查错误信息并手动解决问题" -ForegroundColor Red
    exit 1
}

Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")