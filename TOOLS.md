# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## 文档处理工具

### Python
- 路径：`D:\99软件安装\python\python.exe`
- 已装库：python-docx, PyPDF2, python-pptx, openpyxl, PIL, markdownify, pymupdf

### Pandoc（文档格式转换）
- 路径：`C:\Users\高原\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.9.0.2\pandoc.exe`
- 版本：3.9.0.2
- ⚠️ 中文路径用 PowerShell 脚本调用，不要用 cmd 直接调用
- 常用转换：docx→md, md→docx, html→md

### 使用模板（PowerShell）
```powershell
$pandoc = "C:\Users\高原\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.9.0.2\pandoc.exe"
& $pandoc "输入文件" -o "输出文件"
```

---

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.
