# 输入处理总工作流

更新日期：2026-04-30

---

## 核心判断原则

**收到任何输入，先识别意图，再决定走哪条路。**

意图判断两个维度：
1. **处理深度**：仅处理输入本身，还是需要对内容做进一步分析？
2. **输出去向**：本地处理回复，还是调用外部工具？

---

## 整体工作流总图

```
所有输入
├── 文本文件（docx/pdf/pptx/xlsx/网页/URL）
├── 图片
└── 音频/视频（待补充）

              ↓ 第一步：识别意图

┌─────────────────────────────────────────────────┐
│                   意图判断                        │
│                                                  │
│  仅处理输入本身？        需要对内容进一步处理？     │
│  （上传/存储/转发）       （分析/总结/提炼/回答）   │
└──────────┬──────────────────────┬────────────────┘
           ↓                      ↓
    直接操作原文件            预处理转换
    调用外部工具              （转成可读格式）
    结束                          ↓
                            我来处理内容
                                  ↓
                             输出交付
                    ├── 聊天直接回复
                    ├── 存入 Get笔记
                    └── 生成新文档写入本地
```

---

## 文本文件工作流

```
输入来源
├── 本地文件（docx/pdf/pptx/xlsx）
├── 附件
└── URL（网页/微信文章）

        ↓ 判断意图

外部工具（上传/转发）        本地处理（分析/总结/提炼）
        ↓                              ↓
  直接操作原文件                  预处理转 Markdown
                            ├── docx → pandoc（最优）
                            ├── pdf文字版 → pymupdf
                            ├── pdf扫描版 → PDF to Markdown skill
                            ├── 网页/微信 → 浏览器转md
                            └── pptx/xlsx → python提取
                                    ↓
                               我来处理内容
                                    ↓
                               输出交付
```

---

## 图片工作流

```
图片输入
    ↓ 判断场景

场景A：图片含文字（需提取）     场景B：图片含设计/画面（需理解）
    ↓                                   ↓
OCR提取文字                      阶跃星辰视觉API分析
├── 图片 → PaddleOCR（首选）      └── 输出：风格描述/设计规律
├── PDF → PDF to Markdown skill           /代码实现方案
└── 效果不佳 → 升级视觉API
    ↓
提取出文字
    ↓ 再判断意图

仅需要提取结果？          还需要进一步处理文字内容？
（直接回复/存储）          （分析/总结/生成文档）
    ↓                              ↓
  结束                      → 接入文本处理工作流
```

**关键：** 图片工作流的出口可以接入文本工作流，但不是必须——取决于意图。

---

## OCR 工具分层

| 场景 | 首选工具 | 兜底 |
|------|---------|------|
| 图片OCR | PaddleOCR（本地免费，中文最强）| 阶跃星辰视觉API |
| PDF转换 | PDF to Markdown skill（本地免费）| 阶跃星辰视觉API |
| 音频/视频 | 多模态处理器（本地免费）| 阶跃星辰视觉API |

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
| pdf扫描版 → md | ⭐⭐⭐⭐ | 低 | PDF to Markdown skill |
| 图片OCR | ⭐⭐⭐⭐ | 低 | PaddleOCR，本地免费 |
| pptx → 文本 | ⭐⭐⭐ | 低 | 布局/图片丢失 |
| xlsx → 表格 | ⭐⭐⭐ | 低 | 公式丢失 |
| 视觉API兜底 | ⭐⭐⭐⭐⭐ | 中 | 消耗token，效果最好 |

---

## 音频工作流

```
音频输入
    ↓ 判断来源

【方式二（默认）】                    【方式一（备用）】
小袁在Get笔记处理好                   小袁发音频路径给我
→ 告诉我笔记ID/链接                  → 我调API上传Get笔记
  或"去读最新一条"                   → Get笔记处理完
    ↓                                → 我读回结果反馈
我调API读取笔记内容
（转写原文+摘要，Get笔记已处理好）
    ↓ 判断意图

整理会议纪要          提炼学习笔记          让我了解小袁
    ↓                     ↓                    ↓
输出会议纪要          提炼要点存Get笔记    我直接学习消化
回复/存Get笔记                           更新MEMORY.md/日记
                                        （不做二次加工，
                                         除非小袁特别要求）
```

**外部音频文件（非Get笔记来源）：**
```
外部学习录音/视频音轨
    ↓
faster-whisper 本地转写（免费）
    ↓
接文本处理工作流
```

---

## 待补充

- [ ] 视频工作流
- [ ] 批量文件处理流程
