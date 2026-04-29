# 记忆治理经验

> 三层记忆系统的运作规则和经验总结
> 存放位置：skills/learning-knowledge-base/memory-governance.md
> 状态：🔄 待整理
> 最后更新：2026-04-01

---

## 三层记忆架构

| 层级 | 位置 | 内容 | 压缩规则 |
|------|------|------|---------|
| L1 工作记忆 | 当前对话 | 当前会话上下文 | 会话结束消失 |
| L2 会话记忆 | `memory/daily/*.md` | 每日原始日记 | 每天 00:00 压缩进 events.db |
| L3 长期记忆 | `MEMORY.md` | 精华提炼，永久保存 | 永不压缩 |

---

## 压缩规则

- `memory/daily/` 下的文件：每天 00:00 被压缩，提取精华追加到 MEMORY.md 后删除
- `memory/` 下但不在 `daily/` 下的文件：暂时安全，但长期可能清理
- **永久位置**：`skills/learning-knowledge-base/` 和 `MEMORY.md`

---

## 知识库与记忆的关系

```
学到新东西
    │
    ├─ 临时经验 → memory/daily/YYYY-MM-DD.md → 被压缩
    │
    └─ 永久知识 → skills/learning-knowledge-base/ → 永不压缩
                    │
                    └─ 精华版同步更新 → MEMORY.md
```

---

## 待整理内容

- [ ] 三层记忆系统的具体压缩流程
- [ ] 何时触发 L2→L3 转换
- [ ] 记忆治理评分标准细则
