# 小二智能体养成手册

> 本手册记录如何把小二培养成高效、少踩坑的个人管家助理。
> 核心理念：**不靠死记硬背，靠分层索引按需加载，轻量启动+精准执行。**

---

## 目录

1. [核心设计理念](#一核心设计理念)
2. [工作流管理机制](#二工作流管理机制)
3. [能力建设体系](#三能力建设体系)
4. [工作方法论](#四工作方法论)
5. [踩坑与教训](#五踩坑与教训)
6. [知识库管理](#六知识库管理)

---

## 一、核心设计理念

### 智能体的两大核心问题

1. **执行效率**：做一件事时知道该怎么做（工作流）
2. **避免踩坑**：不重复犯同样的错误（踩坑知识库）

### 分层懒加载架构

```
启动时（轻量加载）
    读 SOUL.md / USER.md / MEMORY.md / WORKFLOW-INDEX.md
    ↓ 知道"我是谁、帮谁、有哪些工作流可用"
    ↓ 不加载细节，保持启动轻量

遇到具体任务（按需加载）
    匹配 WORKFLOW-INDEX.md 的触发条件
    ↓ 用 read 工具加载对应工作流文件
    ↓ 获得完整执行指导
    ↓ 执行任务

执行完成（沉淀经验）
    新坑 → 更新 knowledge/pitfalls/
    新流程 → 更新 knowledge/workflow/ + WORKFLOW-INDEX.md
    重要记忆 → 更新 MEMORY.md
```

**为什么这样设计：**
- 每次启动上下文有限，不能把所有文档都加载进来
- 工作流细节只在需要时读取，不浪费 token
- 索引极简（1页），细节丰富（按需），两者分离

---

## 二、工作流管理机制

### 工作流索引（WORKFLOW-INDEX.md）

所有工作流的入口，启动时必读，极简设计：

| 触发条件 | 工作流文件 |
|---------|----------|
| 文档/图片/音频处理 | knowledge/workflow/document-processing.md |
| 视频处理 | knowledge/workflow/video-processing.md |
| 选择工具/能力 | knowledge/workflow/tool-selection.md |
| Get笔记 API 调用 | skills/getnote/references/api-details.md |
| 浏览器/网页抓取 | memory/browser-experience.md |
| OCR 需求 | knowledge/workflow/ocr-toolchain.md |

### 核心工作流：输入处理

**统一判断逻辑：先识别意图，再决定走哪条路**

```
任何输入
    ↓
本地处理（分析/总结/提炼）？    外部工具（上传/转发/存储）？
    ↓                                ↓
预处理转Markdown                直接操作原文件
再处理内容                      调用对应API
```

**四大输入类型：**

| 类型 | 预处理工具 | 详细工作流 |
|------|-----------|----------|
| 文本文件（docx/pdf/网页）| pandoc/pymupdf/浏览器 | document-processing.md |
| 图片（含文字/设计）| PaddleOCR/视觉API | document-processing.md |
| 音频（录音/会议）| Get笔记API/faster-whisper | audio-processing.md |
| 视频（各场景）| Video系列工具 | video-processing.md |

### 新增工作流规范

1. 在 `knowledge/workflow/` 创建对应 md 文件
2. 在 `WORKFLOW-INDEX.md` 注册一行触发条件
3. 在 `MEMORY.md` 简要记录新工作流存在

---

## 三、能力建设体系

### 工具池优先级

```
水产市场（openclawmp search）← 第一优先
    ↓ 没有合适的
已安装 skills
    ↓ 没有合适的
系统工具/Python库
    ↓ 没有合适的
自己实现（最后手段）
```

### 已安装能力清单

**文档处理：**
- pandoc（docx→md，路径：AppData\Local\Microsoft\WinGet\Packages\...）
- python-docx / PyPDF2 / pymupdf / python-pptx / openpyxl

**OCR：**
- PaddleOCR — 图片OCR，中文最强
- PDF to Markdown — PDF转换，支持扫描版
- 多模态处理器 — 图片/视频/音频

**视频：**
- Video Download — 1800+网站下载+字幕
- Video Understand — AI深度理解视频
- Bilibili Subtitle Downloader — B站专项

**笔记：**
- Get笔记（getnote）— 记录/搜索笔记，API已配置

**浏览器：**
- 后台浏览器（openclaw profile）
- 微信公众平台已登录（2026-04-30）

---

## 四、工作方法论

### 工具选择方法论

> 不用默认工具，用最优工具。

```
1. 理解问题，定义解决步骤
2. 去工具池找工具（水产市场优先）
3. 评估候选：效能 / 成本 / 风险
4. 确定后再执行
```

### Token 量级感知

执行较重任务前主动说明：

| 等级 | Token 范围 | 费用参考 | 典型场景 |
|------|-----------|---------|---------|
| 🟢 低 | <1万 | <0.01元 | 普通对话、短文档 |
| 🟡 中 | 1~5万 | 0.01~0.05元 | 长文档、视频摘要 |
| 🔴 高 | 5~10万 | 0.05~0.1元 | 学习报告 |
| ⚫ 极高 | >10万 | >0.1元 | 批量处理 |

### 浏览器使用原则

1. 静态页面 → web_fetch
2. JS渲染/需登录 → 后台浏览器（先start再open，传targetId）
3. 需用户登录态 → 告知用户扫码，一次解决

---

## 五、踩坑与教训

详见 `knowledge/pitfalls/`，核心教训：

| 编号 | 教训 | 文件 |
|------|------|------|
| PIT-001 | 浏览器先start再open | browser.md |
| PIT-101 | API调用前必须读官方文档，不猜字段名 | api-calling.md |
| PIT-102 | 出错停下来找根因，不乱试 | api-calling.md |
| PIT-103 | 安装skill时references是推测的要告知 | api-calling.md |
| PIT-301 | 先去水产市场，不用默认工具 | tools.md |

---

## 六、知识库管理

### 目录结构

```
knowledge/
  pitfalls/          ← 踩坑记录（按类型分文件）
  workflow/          ← 工作流规范（按任务类型分文件）
  pricing.md         ← 阶跃星辰定价（官方数据）
  ocr-toolchain.md   ← OCR工具分层
WORKFLOW-INDEX.md    ← 工作流总索引（启动必读）
MEMORY.md           ← 长期记忆（主session必读）
AGENTS.md           ← 启动规范和核心规则
```

### 维护规则

- **遇到新坑** → 立即写入 pitfalls/
- **建立新流程** → 写入 workflow/ + 注册到 WORKFLOW-INDEX.md
- **重要决策/经验** → 更新 MEMORY.md
- **定期推送** → git push 同步到 GitHub

---

*手册持续迭代，随实践不断完善。*
*创建日期：2026-04-30*
