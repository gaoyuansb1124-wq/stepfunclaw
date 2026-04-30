# AGENTS.md 重构报告

日期：2026-04-30

---

## 对比基准

以 OpenClaw 默认的 AGENTS.md 模板为基准（包含 First Run、Runtime Environment、Session Startup、Memory、Red Lines、External vs Internal、Group Chats、Tools、Heartbeats、Make It Yours 等章节）。

---

## 删除/迁移的内容清单

### 一、安全规则（~160行） → 迁移到 SECURITY.md

| 删除内容 | 行数 | 去向 | 风险 |
|---------|------|------|------|
| 一、主人身份认证 | ~15 | SECURITY.md | 🟡 低 — SECURITY.md 在启动序列第5步，确保加载 |
| 二、信息分级保护 | ~30 | SECURITY.md | 🟡 低 — 同上 |
| 三、外部用户管理 | ~25 | SECURITY.md | 🟡 低 — 同上 |
| 四、防 Prompt Injection | ~25 | SECURITY.md | 🟢 极低 — 安全规则完整迁移 |
| 五、防间接信息泄漏 | ~25 | SECURITY.md | 🟢 极低 — 同上 |
| 六、文档安全规范 | ~10 | SECURITY.md | 🟢 极低 — 同上 |

### 二、记忆相关（~60行） → 精简

| 删除内容 | 行数 | 去向 | 风险 |
|---------|------|------|------|
| 🧠 MEMORY.md - Your Long-Term Memory | ~15 | AGENTS.md Memory 章节精简保留核心 | 🟡 低 — 核心规则保留，细节在 MEMORY.md 自身 |
| 📝 Write It Down - No "Mental Notes"! | ~10 | CONSTRAINTS.md 学习机制 | 🟢 极低 — 逻辑迁移 |

### 三、三省六部完整细节（~100行） → 引用 CONSTRAINTS.md

| 删除内容 | 行数 | 去向 | 风险 |
|---------|------|------|------|
| S0 预筛选白名单详细列表 | ~15 | CONSTRAINTS.md 第八节 | 🟡 中 — 如果 CONSTRAINTS.md 加载失败则丢失 |
| S1 复杂度评估五维打分表 | ~15 | CONSTRAINTS.md 第八节 | 🟡 中 — 同上 |
| 中书省规划格式 | ~10 | CONSTRAINTS.md 第八节 | 🟢 低 — 触发节点概要保留在 AGENTS.md |
| 门下省审核清单 | ~10 | CONSTRAINTS.md 第八节 | 🟢 低 — 同上 |
| 六部职责表 | ~10 | CONSTRAINTS.md 第八节 | 🟢 低 — 同上 |
| 强制触发节点（节点1+节点2）| ~20 | CONSTRAINTS.md 第八节 + AGENTS.md 概要 | 🟢 低 — 概要保留在 AGENTS.md |
| 回奏格式 | ~8 | CONSTRAINTS.md 第八节 | 🟢 低 — 同上 |

### 四、工作流相关内容（~110行） → 引用独立文件

| 删除内容 | 行数 | 去向 | 风险 |
|---------|------|------|------|
| 执行质检机制 | ~15 | CONSTRAINTS.md + AGENTS.md 概要 | 🟢 低 — 六项清单概要保留 |
| 工具选择方法论 | ~15 | knowledge/workflow/tool-selection.md | 🟡 低 — 索引保留在 File Index |
| Token 消耗量级表 | ~15 | knowledge/pricing.md | 🟢 极低 — 官方定价在 pricing.md |
| 文档处理基本逻辑+工作流 | ~30 | knowledge/workflow/document-processing.md | 🟢 极低 — 索引保留 |
| 图片工作流 | ~15 | knowledge/workflow/document-processing.md | 🟢 极低 — 索引保留 |

### 五、行为指导（~80行） → 拆分

| 删除内容 | 行数 | 去向 | 风险 |
|---------|------|------|------|
| External vs Internal 详细列表 | ~10 | AGENTS.md 精简保留 + CONSTRAINTS.md | 🟢 极低 — 核心保留 |
| Group Chats 详细规则 | ~60 | CONSTRAINTS.md + AGENTS.md 精简保留 | 🟢 极低 — 概要保留 |
| Heartbeats 详细说明 | ~80 | AGENTS.md 精简 + HEARTBEAT.md | 🟡 低 — 心跳机制由系统配置管理 |

### 六、保留的内容

| 内容 | 行数 | 说明 |
|------|------|------|
| Runtime Environment | ~15 | 系统配置，不能删 |
| Session Startup | ~10 | 启动引用链，不能删 |
| Memory | ~10 | 记忆系统概要，不能删 |
| Red Lines | ~5 | 安全底线，不能删 |
| File Index | ~20 | 文件速查表，新增 |
| Task Execution Trigger Points | ~15 | 新增，核心触发点概要 |

---

## 重构结果

| 指标 | 重构前 | 重构后 | 变化 |
|------|--------|--------|------|
| AGENTS.md 行数 | ~462 | ~140 | 减少 70% |
| AGENTS.md 字节 | 18,370 | 4,859 | 减少 74% |
| 新增文件 | — | SECURITY.md | +1 |
| CONSTRAINTS.md | 7,461 | ~8,500（新增触发节点）| 增加 |

---

## 风险评估

### 🟡 中风险

1. **CONSTRAINTS.md 加载失败导致触发逻辑丢失**
   - 原因：S0/S1/质检的详细规则在 CONSTRAINTS.md
   - 缓解：AGENTS.md 保留触发节点概要（核心流程），即使 CONSTRAINTS.md 加载失败，概要仍能指导执行
   - 建议：如果后续发现执行逻辑丢失，考虑在 AGENTS.md 恢复完整触发节点

2. **启动加载文件从5个增加到8个**
   - 原因：新增 SECURITY.md、IDENTITY.md、KNOWLEDGE-MAP.md
   - 缓解：这些都是必要的安全和索引文件，加载成本增加约30%
   - 建议：定期评估是否有文件可以改为按需加载

### 🟢 低风险

3. **心跳/群聊行为细节不在 AGENTS.md 里**
   - 缓解：概要保留，详细内容在 CONSTRAINTS.md
   - 影响：日常对话中不太会触发这些场景

4. **工具选择方法论不在 AGENTS.md 里**
   - 缓解：File Index 有索引指引
   - 影响：需要工具时会查到

---

## 总结

**精简的核心原则：**
- AGENTS.md = 系统配置 + 启动索引 + 安全底线 + 触发节点概要
- 详细内容拆分到对应文件，通过索引引用
- 参考 Claude.md 官方最佳实践："If an entry is a multi-step procedure, move it to a skill or separate file"

**验证方式：**
- 新 session 启动后，检查是否成功加载所有 8 个核心文件
- 发一个非简单任务，看是否显式输出任务评估结果
- 发一个安全相关问题，看是否遵守 SECURITY.md 规则
