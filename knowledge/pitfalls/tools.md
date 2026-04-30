# 踩坑：工具使用（PowerShell / Python / 命令行）

---

## PIT-201 | PowerShell 单行命令引号嵌套失败

**现象：** 用 `powershell -Command "..."` 执行包含单引号/双引号的命令时报错

**根本原因：** PowerShell 单行 -Command 模式下引号嵌套处理复杂，容易出错

**正确做法：** 写成 .ps1 脚本文件再执行
```powershell
# 写入脚本
write("temp/script.ps1", 脚本内容)
# 执行
powershell -ExecutionPolicy Bypass -File "temp/script.ps1"
```

---

## PIT-202 | cmd 中 && 操作符报错

**现象：** PowerShell 中执行 `cmd /c "xxx && yyy"` 报"不是有效语句分隔符"

**根本原因：** PowerShell 本身不支持 `&&`，需要用 `cmd /c` 包裹，或改用 `;`

**正确做法：**
```powershell
# 方式一：cmd 包裹
cmd /c "command1 && command2"

# 方式二：PowerShell 分号
command1; command2

# 方式三：写脚本文件
```

---

## PIT-203 | Python 不在默认 PATH，找不到模块

**现象：** `python -m pip install xxx` 成功，但 `python script.py` 报 ModuleNotFoundError

**根本原因：** 系统有多个 Python，pip 装到了一个，执行用的是另一个

**正确做法：** 用完整路径指定 Python
```
D:\99软件安装\python\python.exe script.py
D:\99软件安装\python\python.exe -m pip install xxx
```

**本机 Python 路径：** `D:\99软件安装\python\python.exe`

---

## PIT-204 | pandoc 未安装，文档转换失败

**现象：** 执行 `pandoc` 报"不是内部或外部命令"

**根本原因：** 系统未安装 pandoc

**临时解法：** 用 python-docx 脚本读取 .docx 内容
```python
from docx import Document
doc = Document('file.docx')
for p in doc.paragraphs:
    print(p.text)
```

**待办：** 安装 pandoc（https://pandoc.org/installing.html）一劳永逸
