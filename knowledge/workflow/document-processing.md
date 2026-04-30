# 文档处理工作流

更新日期：2026-04-30

---

## 核心原则

收到文档，先判断任务类型，再决定处理方式：

- **本地处理**（分析/总结/提炼/回答问题）→ 先转 Markdown，再处理
- **外部工具**（上传/转发/存储/API调用）→ 直接操作原文件，不预处理

---

## 文本文件完整工作流

```
输入来源
├── 本地文件路径（小袁发路径）
├── 附件（docx/pdf/pptx/xlsx等）
└── URL（网页/微信文章）

        ↓ 判断任务类型

本地处理（分析/总结/提炼）        外部工具（上传/转发）
        ↓                                ↓
   预处理转 Markdown              直接操作原文件
   ├── docx → pandoc
   ├── pdf文字版 → pymupdf
   ├── 网页/微信 → 浏览器转md
   └── pptx/xlsx → python提取
        ↓
   我来处理内容
        ↓
   输出交付
   ├── 聊天直接回复
   ├── 存入 Get笔记
   └── 生成新文档写入本地
```

---

## 各格式转换方法

### docx → markdown（最优）
```powershell
$pandoc = "C:\Users\高原\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.9.0.2\pandoc.exe"
& $pandoc "input.docx" -o "output.md"
```
⚠️ 必须用 PowerShell 脚本调用，中文路径在 cmd 里会报错

### pdf（文字版）→ 文本
```python
import fitz  # pymupdf
doc = fitz.open("file.pdf")
text = "\n".join(page.get_text() for page in doc)
```

### 网页/微信文章 → markdown
```
1. browser(action=start, profile=openclaw)
2. browser(action=open, url=...) → 获取 targetId
3. browser(action=snapshot, targetId=...) → 读取结构化内容
```
微信公众平台登录状态：✅ 已登录（2026-04-30）

### pptx → 文本提取
```python
from pptx import Presentation
prs = Presentation("file.pptx")
for slide in prs.slides:
    for shape in slide.shapes:
        if shape.has_text_frame:
            print(shape.text_frame.text)
```

### xlsx → 数据提取
```python
import openpyxl
wb = openpyxl.load_workbook("file.xlsx")
ws = wb.active
for row in ws.iter_rows(values_only=True):
    print(row)
```

---

## 转换质量评估

| 格式 | 质量 | 成本 | 备注 |
|------|------|------|------|
| docx → md | ⭐⭐⭐⭐⭐ | 极低 | 首选 |
| html/网页 → md | ⭐⭐⭐⭐ | 低 | 需浏览器 |
| pdf文字版 → md | ⭐⭐⭐ | 低 | 复杂排版会乱 |
| pptx → 文本 | ⭐⭐⭐ | 低 | 布局/图片丢失 |
| xlsx → 表格 | ⭐⭐⭐ | 低 | 公式丢失 |
| pdf扫描版 | ⭐⭐ | 高 | 需OCR，有token成本，先告知用户 |
| 图片文字 | ⭐⭐ | 高 | 需视觉API，有token成本，先告知用户 |

---

## 待补充的工作流（未来）

- [ ] 语音/视频 → 文字（faster-whisper 技能已安装）
- [ ] 图片文字提取（OCR）
- [ ] 批量文件处理流程
