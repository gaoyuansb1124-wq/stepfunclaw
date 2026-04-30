# 踩坑：浏览器与网页抓取

---

## PIT-001 | browser 工具报"Could not connect to Chrome"

**现象：** 调用 `browser(action=open)` 直接报连接失败

**根本原因：** 没有先启动后台浏览器，就直接调用 open

**正确做法：**
```
每次使用浏览器前，必须先调用：
browser(action=start, profile=openclaw)
确认返回 running=true 后，再调用 open
```

**预防：** 把 start 当做固定前置步骤，不要假设浏览器已在运行

---

## PIT-002 | web_fetch 拿不到网页内容

**现象：** `web_fetch` 返回空内容或报错"Readability returned no content"

**根本原因：** 目标页面是 JS 渲染的 SPA（如 biji.com、飞书文档等），web_fetch 只能抓静态 HTML，拿不到动态渲染内容

**正确做法：**
```
静态页面（新闻/博客/普通文章）→ web_fetch
JS渲染/SPA/需要登录的页面 → browser(profile=openclaw)
```

---

## PIT-003 | 微信公众号文章内容为空

**现象：** web_fetch 抓微信文章只拿到标题，正文为空

**根本原因：** 微信文章需要登录态才能完整加载，且页面是 JS 渲染

**正确做法：**
1. 使用后台浏览器（openclaw profile）
2. 首次需要小袁在后台浏览器扫码登录微信
3. 登录后 cookie 持久保存，后续直接可用

**当前状态：** ✅ 已在 openclaw profile 登录（2026-04-30）

---

## PIT-004 | browser 操作报"tab not found"

**现象：** 调用 snapshot/screenshot 时报 tab not found

**根本原因：** 之前获取的 targetId 对应的标签页已被关闭或失效

**正确做法：**
```
重新调用 browser(action=open, url=...) 获取新的 targetId
后续所有操作都使用新的 targetId
```

**预防：** 不要跨会话复用 targetId，每次会话重新 open

---

## PIT-005 | 忘记传 targetId 导致操作错误标签页

**现象：** snapshot/act 操作了错误的标签页

**根本原因：** 没有把 open 返回的 targetId 传给后续操作

**正确做法：**
```
targetId = browser(action=open, url=...).targetId
browser(action=snapshot, targetId=targetId)  ← 必须传
browser(action=act, targetId=targetId, ...)  ← 必须传
```
