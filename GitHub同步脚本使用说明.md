# GitHub同步脚本使用说明

本项目提供了多个自动化脚本，帮助您快速将代码更改同步到GitHub仓库。

## 📁 脚本文件说明

### 1. `gitPush.bat` (原有脚本)
- **功能**: 基础的Git推送脚本
- **特点**: 简单直接，适合基本推送需求
- **使用**: `.\.\gitPush.bat`

### 2. `sync-to-github.bat` (增强版批处理脚本)
- **功能**: 完整的同步流程，包含错误处理
- **特点**: 
  - 自动添加所有更改到暂存区
  - 支持自定义提交信息
  - 智能检测是否有需要提交的更改
  - 包含错误处理和重试机制
  - 显示详细的执行步骤
- **使用**: `.\.\sync-to-github.bat`

### 3. `sync-to-github.ps1` (PowerShell版本)
- **功能**: 功能最完整的同步脚本
- **特点**:
  - 彩色输出，界面友好
  - 支持命令行参数传递提交信息
  - 更好的错误处理和异常捕获
  - 跨平台兼容性更好
  - 自动生成带时间戳的默认提交信息
- **使用**: 
  - 基本使用: `.\.\sync-to-github.ps1`
  - 带提交信息: `.\.\sync-to-github.ps1 "你的提交信息"`

### 4. `quick-sync.bat` (快速同步脚本)
- **功能**: 最简化的快速同步
- **特点**:
  - 一键执行，无需输入
  - 自动生成时间戳提交信息
  - 适合频繁的小更改
- **使用**: `.\.\quick-sync.bat`

## 🚀 推荐使用方式

### 日常开发推荐流程:

1. **开发完成后的正式提交**:
   ```bash
   # 使用PowerShell脚本，可以自定义提交信息
   .\sync-to-github.ps1 "feat: 添加新功能"
   ```

2. **快速保存进度**:
   ```bash
   # 使用快速同步脚本
   .\quick-sync.bat
   ```

3. **需要详细控制的情况**:
   ```bash
   # 使用增强版批处理脚本
   .\sync-to-github.bat
   ```

## 📋 提交信息规范建议

为了保持项目历史的清晰，建议使用以下提交信息格式：

- `feat: 新功能描述` - 添加新功能
- `fix: 修复问题描述` - 修复bug
- `docs: 文档更新描述` - 更新文档
- `style: 样式调整描述` - 代码格式、样式调整
- `refactor: 重构描述` - 代码重构
- `test: 测试相关` - 添加或修改测试
- `chore: 其他杂项` - 构建过程或辅助工具的变动

## ⚠️ 注意事项

1. **首次使用前确保**:
   - 已安装Git
   - 已配置GitHub访问权限
   - 确认远程仓库地址正确

2. **PowerShell执行策略**:
   如果无法执行PowerShell脚本，请以管理员身份运行PowerShell并执行：
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. **网络问题**:
   - 如果推送失败，检查网络连接
   - 确保GitHub访问正常
   - 可能需要配置代理或VPN

4. **权限问题**:
   - 确保有仓库的推送权限
   - 检查SSH密钥或Personal Access Token配置

## 🔧 故障排除

### 常见问题及解决方案:

1. **推送被拒绝**:
   ```bash
   # 先拉取远程更改
   git pull origin main
   # 然后重新推送
   git push origin main
   ```

2. **合并冲突**:
   - 手动解决冲突文件
   - 使用 `git add .` 标记已解决
   - 使用 `git commit` 完成合并

3. **权限认证问题**:
   - 检查GitHub Personal Access Token
   - 确认用户名和邮箱配置正确

## 📞 技术支持

如果遇到问题，请检查：
1. Git配置是否正确
2. 网络连接是否正常
3. GitHub仓库权限是否足够
4. 脚本执行权限是否正确

---

**仓库地址**: https://github.com/DongPo562/naodongWord

**最后更新**: $(Get-Date -Format 'yyyy-MM-dd')