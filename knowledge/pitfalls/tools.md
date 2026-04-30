# 踩坑：工具使用（PowerShell / Python / 命令行）

---

## PIT-201 | PowerShell 单行命令引号嵌套失败

**现象：** 用 `powershell -Command "..."` 执行包含单引号/双引号的命令时报错

**根本原因：** PowerShell 单行 -Command 模式下引号嵌套处理复杂，容易出错

**正确做法：** 写成 .ps1 脚本文件再执行
```powershell
write("temp/script.ps1", 脚本内容)
powershell -ExecutionPolicy Bypass -File "temp/script.ps1"
```

---

## PIT-202 | cmd 中 && 操作符在 PowerShell 里报错

**现象：** PowerShell 中直接用 `&&` 报"不是有效语句分隔符"

**正确做法：**
```powershell
# 用 cmd /c 包裹
cmd /c "command1 && command2"
# 或写脚本文件
```

---

## PIT-203 | Python 不在默认 PATH，找不到模块

**现象：** pip install 成功，但执行脚本报 ModuleNotFoundError

**根本原因：** 系统有多个 Python，pip 和执行用的不是同一个

**正确做法：** 用完整路径
```
D:\99软件安装\python\python.exe script.py
D:\99软件安装\python\python.exe -m pip install xxx
```
**本机 Python 路径：** `D:\99软件安装\python\python.exe`

---

## PIT-204 | pandoc 中文路径在 cmd 里报错

**现象：** pandoc 处理中文路径文件时报 invalid argument

**正确做法：** 用 PowerShell 脚本调用
```powershell
$pandoc = "C:\Users\高原\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.9.0.2\pandoc.exe"
& $pandoc "输入文件.docx" -o "输出文件.md"
```

---

## PIT-301 | 习惯性用默认工具，没有先找最优工具

**现象：** 遇到需要某种能力时，直接用脑子里第一个想到的方案（如 tesseract、自己写脚本），没有系统性地寻找最优工具

**案例：**
- 需要 OCR 能力 → 直接建议装 tesseract
- 没有先去水产市场搜索，结果发现有 PaddleOCR（中文更强）、多模态处理器（覆盖更广）等更优方案

**根本原因：** 跳过了"选工具"步骤，凭习惯和第一反应做决定

**正确做法：**
```
1. 理解问题，定义解决步骤
2. 去工具池找工具
   优先级：水产市场 → 已安装skills → 系统工具 → 自己实现
3. 评估候选工具
   ├── 效能：质量、覆盖场景、社区使用量
   ├── 成本：API费用/token/安装复杂度
   └── 风险：稳定性/维护状态/隐私
4. 综合评估后确定，再执行
```

**记住：** 水产市场是工具池，需要某种能力时第一步先去搜索，不要凭习惯选工具。
