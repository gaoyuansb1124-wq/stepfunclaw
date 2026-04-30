# MEMORY.md - 长期记忆

最后更新：2026-04-30

---

## 关于小袁

- 产品经理，有技术底子
- 喜欢把事情想清楚，注重工作流和方法论
- 对工具选择有要求：先找最优工具，不接受凑合方案
- 沟通风格直接，发现问题会直说

---

## 已建立的工作规范

### 工具选择方法论
遇到需要某种能力时，不能凭习惯选工具，走完整流程：
1. 理解问题，定义解决步骤
2. 先去水产市场搜索（工具池第一优先级）
3. 评估候选工具：效能/成本/风险
4. 综合评估确定后再执行
详见：knowledge/workflow/tool-selection.md

### 音频工作流
- 默认方式二：小袁在Get笔记处理好，告诉我笔记ID，我调API读取学习/整理
- 方式一备用：小袁发音频路径给我，我上传Get笔记处理再读回
- 三个场景：会议纪要 / 学习笔记存Get笔记 / 喂给我学习小袁业务
- 场景三：Get笔记已处理好，我直接读学习，不二次加工，更新MEMORY.md
- 外部音频：faster-whisper本地转写
详见：knowledge/workflow/document-processing.md


核心原则：**先识别意图，再决定走哪条路**
- 本地处理（分析/总结）→ 先转Markdown
- 外部工具（上传/存储）→ 直接操作原文件
- 图片：场景A(OCR)→可接文本流；场景B(视觉理解)→直接输出
详见：knowledge/workflow/document-processing.md

---

## 已安装的能力

### Skills
- getnote — Get笔记，记录和搜索笔记
- PaddleOCR — 图片OCR，中文最强，本地免费
- PDF to Markdown — PDF转Markdown，支持扫描版
- 多模态处理器 — 图片/视频/音频处理，本地免费
- faster-whisper — 语音转文字

### 工具
- Python：`D:\99软件安装\python\python.exe`
- pandoc：`C:\Users\高原\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.9.0.2\pandoc.exe`
- python-docx / PyPDF2 / python-pptx / openpyxl / PIL / pymupdf / markdownify 已安装

### 浏览器
- 后台浏览器（openclaw profile）已配置
- 微信公众平台已登录（2026-04-30）
- 使用规则：先 start 再 open，传 targetId

### Get笔记
- API Key / Client ID 已配置
- 关键字段：note_type（不是type），link_url（不是url）
- 详细API文档：skills/getnote/references/api-details.md

---

## 知识库结构

```
knowledge/
  pitfalls/        ← 踩坑记录
    browser.md     PIT-001~005 浏览器相关
    api-calling.md PIT-101~105 API调用相关
    tools.md       PIT-201~204 工具使用，PIT-301 工具选择
  workflow/        ← 工作流规范
    document-processing.md  输入处理总工作流
    tool-selection.md       工具选择方法论
    ocr-toolchain.md        OCR工具分层
```

---

## 重要教训

1. **API调用前必须读官方文档**，不能猜字段名
2. **出错后停下来找根因**，不要乱试
3. **安装skill时references是推测的要告知用户**
4. **浏览器使用**：先start再open，传targetId
5. **工具选择**：先去水产市场，不用默认工具
6. **git commit message**：含中文冒号在cmd里会报错，用ps1脚本

---

## 今日完成（2026-04-30）

- 安装并配置 Get笔记 skill
- 建立踩坑知识库（pitfalls/）
- 建立工作流知识库（workflow/）
- 安装 pandoc，补齐文档处理能力
- 安装 PaddleOCR / PDF to Markdown / 多模态处理器
- 建立浏览器使用规范，微信登录
- 定义文本/图片输入处理完整工作流
