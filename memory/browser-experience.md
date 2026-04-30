# 浏览器与网页搜索使用经验

## 工具清单

| 工具 | 用途 | 限制 |
|------|------|------|
| `web_fetch` | 抓取静态网页内容 | 无法处理 JS 渲染的 SPA 页面 |
| `browser`（openclaw profile）| 后台浏览器，处理 JS 渲染页面、需登录页面 | 需先 start，再 open |
| `browser`（user profile）| 连接用户正在用的 Chrome | 需用户点击附加，不能完全自动化 |
| `browser`（chrome-relay）| Chrome 扩展中继 | 用户需点扩展图标，成本较高 |

---

## 决策策略

```
需要网页内容
    ↓
是否是静态页面（新闻/博客/普通文章）？
    ↓ 是 → 先用 web_fetch，快速低成本
    ↓ 否（SPA/JS渲染/需登录）→ 用后台浏览器（openclaw profile）
                                    ↓
                              该网站是否已登录？
                                    ↓ 是 → 直接 open
                                    ↓ 否 → 告知小袁扫码登录，一次解决
```

---

## 操作规范（必须遵守）

### ✅ 正确流程
1. **先 start，再 open** — 不能假设浏览器已在运行
2. **open 后等待加载** — 用 snapshot/screenshot 确认页面已渲染完成再操作
3. **用 targetId** — open 返回 targetId，后续操作（snapshot/screenshot/act）都传同一个 targetId
4. **JS 页面用 snapshot** — 比 screenshot 更高效，能直接读结构化内容

### ❌ 踩坑记录

| 坑 | 原因 | 解法 |
|----|------|------|
| browser 报"Could not connect to Chrome" | 没有先 start 浏览器 | 每次使用前先调用 `browser(action=start, profile=openclaw)` |
| web_fetch 拿不到内容 | 页面是 JS 渲染的 SPA | 改用后台浏览器 |
| 微信文章拿不到内容 | 需要微信登录态 | 用 openclaw profile 扫码登录微信，cookie 持久保存 |
| tab not found | targetId 过期（标签页被关了）| 重新 open 获取新 targetId |

---

## 已登录的网站（openclaw profile）

| 网站 | 登录状态 | 登录时间 |
|------|----------|----------|
| 微信公众平台（mp.weixin.qq.com）| ✅ 已登录 | 2026-04-30 |

> 如果登录失效，告知小袁重新扫码

---

## Chrome 扩展使用时机

只在以下情况使用，其他时候不主动提：
- 需要访问小袁已登录的特定网站，且后台浏览器登录成本太高
- 需要与小袁当前正在看的页面交互
- 小袁明确要求使用

---

## 网页搜索策略

- 优先用 `step-search` skill（StepFun Search）做信息搜索
- 搜索到结果后，如需读全文，再用 browser/web_fetch 打开具体链接
- 不要用浏览器直接打开搜索引擎手动搜——有专用工具更高效
