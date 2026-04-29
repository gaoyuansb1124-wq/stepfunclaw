# HEARTBEAT.md

## 每次心跳执行

### 1. 知识提炼检查
读取 `memory/heartbeat-state.json`，检查 `lastKnowledgeExtract` 字段。
如果今天还没有执行过知识提炼，立即执行一次：
- 读取今天的 `memory/YYYY-MM-DD.md`
- 扫描带 [LRN][ERR][FEAT][DEC] 标签的内容
- 判断哪些值得写进 knowledge/ 对应文件
- 写入后更新 heartbeat-state.json 的 lastKnowledgeExtract 为当前时间戳

如果今天已经执行过，跳过。

### 2. 其他检查
暂无，后续按需添加。
