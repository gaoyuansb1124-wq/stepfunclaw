# WORKFLOW-INDEX.md — 工作流索引

> 启动时加载此文件，了解有哪些工作流可用。
> 遇到具体任务时，按触发条件匹配，再读取对应工作流文件（按需加载）。

---

## 触发规则

| 触发条件 | 工作流文件 | 说明 |
|---------|----------|------|
| 质检第6项触发 / 每日cron / 经验成熟时 | `knowledge/workflow/knowledge-management.md` | 知识采集→沉淀→成熟度评估→图谱维护→发布 |
| S0判断不是简单任务时 | `knowledge/workflow/task-evaluation.md` | 五维打分→决策→说明量级（一行） |
| 收到分析/建议/评估/判断类问题 | `knowledge/workflow/problem-analysis.md` | 定义→分解→模型→分析→总结→落地 |
| 收到音频/录音处理请求 | `knowledge/workflow/audio-processing.md` | 会议纪要/学习笔记/喂给我学习三大场景 |
| 收到文档/图片处理请求 | `knowledge/workflow/document-processing.md` | 文本/图片输入类型处理 |
| 收到视频处理请求 | `knowledge/workflow/video-processing.md` | 视频四大场景处理 |
| 需要选择工具/能力 | `knowledge/workflow/tool-selection.md` | 工具选择方法论，先去水产市场 |
| 调用 Get笔记 API | `skills/getnote/references/api-details.md` | 正确字段名和接口规范 |
| 遇到浏览器/网页抓取 | `memory/browser-experience.md` | 先start再open，传targetId |
| 遇到 OCR 需求 | `knowledge/workflow/ocr-toolchain.md` | 图片/PDF/音视频分层工具链 |

---

## 使用规则

1. **启动时**：读此索引，了解工作流全貌，不读细节
2. **遇到任务时**：匹配触发条件，用 `read` 工具加载对应文件
3. **执行完成后**：如有新坑或新经验，更新对应文件并在此注册

---

## 新增工作流

在此表格追加一行即可，格式：
`| 触发条件 | 文件路径 | 简要说明 |`
