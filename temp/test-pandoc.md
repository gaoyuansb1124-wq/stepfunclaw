# **Get 笔记 OpenAPI 文档**

在线文档：https://www.biji.com/openapi（点击\"使用文档\"Tab）Base
URL：https://openapi.biji.com

## **鉴权**

所有请求需携带以下 Header：

Authorization: gk_live_xxxxx \# API Key

X-Client-ID: cli_xxxxx \# Client ID

在 [开放平台](https://www.biji.com/openapi) 创建应用后获取。

## **笔记接口**

### **保存笔记**

POST /open/api/v1/resource/note/save

curl -X POST \'https://openapi.biji.com/open/api/v1/resource/note/save\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{

\"note_type\": \"plain_text\",

\"title\": \"笔记标题\",

\"content\": \"笔记正文内容\",

\"tags\": \[\"标签1\", \"标签2\"\]

}\'

**请求参数：**

  ---------------------------------------------------------------------------------
  **字段**     **类型**     **必填**      **说明**
  ------------ ------------ ------------- -----------------------------------------
  note_type    string       否            plain_text（默认）/ link / img_text

  title        string       否            笔记标题

  content      string       否            Markdown 正文

  tags         string\[\]   否            标签名称列表

  parent_id    int64        否            父笔记 ID，默认 0

  link_url     string       link 必填     要保存的链接 URL

  image_urls   string\[\]   img_text 必填 图片地址列表（来自上传凭证的 access_url）

  topic_id     string       否            保存到指定知识库
  ---------------------------------------------------------------------------------

**响应说明：**

- plain_text：同步，直接返回 {note_id, title, created_at, updated_at}

- link（分享链接 biji.com/note/share_note/\* 或 d.biji.com/\*
  短链）：同步，直接返回 note_id

- link（普通链接）/ img_text：异步，返回 {tasks:
  \[{task_id}\]}，需轮询任务进度

// plain_text 响应示例

{

\"success\": true,

\"data\": {

\"note_id\": \"1907975006118548200\",

\"title\": \"笔记标题\",

\"created_at\": \"2026-04-23 18:29:55\",

\"updated_at\": \"2026-04-23 18:29:55\"

}

}

// link（普通链接）响应示例

{

\"success\": true,

\"data\": {

\"created_count\": 1,

\"tasks\": \[{\"task_id\": \"69c3995e99f5a67e\", \"url\":
\"https://\...\"}\]

}

}

### **查询任务进度**

POST /open/api/v1/resource/note/task/progress

异步保存链接/图片后，轮询此接口（建议 10-30 秒间隔）。

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/note/task/progress\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"task_id\": \"69c3995e99f5a67e\"}\'

**响应：**

{

\"success\": true,

\"data\": {

\"status\": \"success\",

\"note_id\": \"1907975006118548200\"

}

}

status 取值：pending / processing / success / failed

⚠️ task_id 在 data.tasks\[0\].task_id，不是 data.task_id

### **笔记列表**

GET /open/api/v1/resource/note/list

curl
\'https://openapi.biji.com/open/api/v1/resource/note/list?cursor=0\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\'

**参数：**

- cursor（可选）：翻页游标，首次不传，后续传上一页响应中的 cursor 值

**响应（data 下）：**

  ----------------------------------
  **字段**   **说明**
  ---------- -----------------------
  notes      笔记列表（每次 20 条）

  has_more   是否还有更多

  cursor     下一页游标
  ----------------------------------

notes\[\]
每项包含：note_id、title、content、note_type、tags、topics、created_at、updated_at

### **笔记详情**

GET /open/api/v1/resource/note/detail

curl
\'https://openapi.biji.com/open/api/v1/resource/note/detail?id=1907975006118548200\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\'

**参数：**

- id（必填）：笔记 ID

- image_quality（可选）：传 original 返回原图链接

⚠️ 数据在 data.note 下，不是 data 直接取

**额外字段（列表接口不含）：**

  -----------------------------------------------------
  **字段**           **说明**
  ------------------ ----------------------------------
  audio.original     语音转写原文

  audio.play_url     音频播放地址

  audio.duration     音频时长（秒）

  web_page.content   链接网页完整原文

  web_page.url       原始链接地址

  web_page.excerpt   AI 生成摘要

  attachments\[\]    附件列表（image/audio/link/pdf）
  -----------------------------------------------------

### **更新笔记**

POST /open/api/v1/resource/note/update

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/note/update\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{

\"note_id\": 1907975006118548200,

\"title\": \"新标题\",

\"content\": \"新的正文内容\",

\"tags\": \[\"新标签\"\]

}\'

⚠️ tags 为替换操作（覆盖原有标签），至少传 title/content/tags 之一

### **删除笔记**

POST /open/api/v1/resource/note/delete

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/note/delete\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"note_id\": 1907975006118548200}\'

笔记移入回收站（可恢复）。

### **生成分享链接**

POST /open/api/v1/resource/note/sharing

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/note/sharing\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"note_id\": \"1907975006118548200\", \"share_exclude_audio\":
true}\'

**响应：**

{

\"data\": {

\"note_id\": \"1907975006118548200\",

\"share_id\": \"rBzdMlXrzgYVM\",

\"share_url\": \"https://biji.com/note/share_note/rBzdMlXrzgYVM\"

}

}

✅ 对同一笔记多次调用，返回相同的 share_url（幂等）

## **图片笔记完整流程**

### **第一步：获取上传凭证**

GET /open/api/v1/resource/image/upload_token

curl
\'https://openapi.biji.com/open/api/v1/resource/image/upload_token?mime_type=jpg&count=1\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\'

参数：mime_type（jpg/png/gif/webp，必须与实际文件一致）、count（最大 9）

### **第二步：上传到 OSS**

⚠️ 字段顺序必须严格遵守，否则签名验证失败

curl -X POST \'{host}\' \\

-F \'key={object_key}\' \\

-F \'OSSAccessKeyId={accessid}\' \\

-F \'policy={policy}\' \\

-F \'signature={signature}\' \\

-F \'callback={callback}\' \\

-F \'Content-Type=image/jpeg\' \\

-F \'file=@/path/to/image.jpg\'

### **第三步：保存图片笔记**

curl -X POST \'https://openapi.biji.com/open/api/v1/resource/note/save\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"note_type\": \"img_text\", \"content\": \"图片描述\",
\"image_urls\": \[\"{access_url}\"\]}\'

## **标签接口**

### **添加标签**

POST /open/api/v1/resource/note/tags/add

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/note/tags/add\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"note_id\": 1907975006118548200, \"tags\": \[\"工作\",
\"重要\"\]}\'

### **删除标签**

POST /open/api/v1/resource/note/tags/delete

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/note/tags/delete\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"note_id\": 1907975006118548200, \"tag_id\": \"123\"}\'

tag_id 来自添加标签返回或详情接口的 tags\[\].id；system 类型标签不可删除

## **知识库接口**

### **我的知识库列表**

GET /open/api/v1/resource/knowledge/list

curl
\'https://openapi.biji.com/open/api/v1/resource/knowledge/list?page=1\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\'

返回 topics\[\]，每项含：topic_id、name、description、stats.note_count
等

⚠️ 每天最多创建 50 个知识库

### **订阅知识库列表**

GET /open/api/v1/resource/knowledge/subscribe/list

获取订阅（非自己创建）的知识库。订阅知识库**只读，不能添加笔记**。

### **创建知识库**

POST /open/api/v1/resource/knowledge/create

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/knowledge/create\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"name\": \"知识库名称\", \"description\": \"描述\"}\'

### **知识库笔记列表**

GET /open/api/v1/resource/knowledge/notes

curl
\'https://openapi.biji.com/open/api/v1/resource/knowledge/notes?topic_id=abc123&page=1\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\'

### **添加笔记到知识库**

POST /open/api/v1/resource/knowledge/note/batch-add

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/knowledge/note/batch-add\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"topic_id\": \"abc123\", \"note_ids\":
\[\"1907975006118548200\"\]}\'

⚠️ 每批最多 20 条；订阅知识库不可写入

### **从知识库移除笔记**

POST /open/api/v1/resource/knowledge/note/remove

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/knowledge/note/remove\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"topic_id\": \"abc123\", \"note_ids\":
\[\"1907975006118548200\"\]}\'

## **搜索接口**

### **全局语义搜索**

POST /open/api/v1/resource/recall

curl -X POST \'https://openapi.biji.com/open/api/v1/resource/recall\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"query\": \"番茄工作法\", \"top_k\": 5}\'

**参数：** query（必填）、top_k（可选，默认 3，最大 10）

**响应：**

{

\"data\": {

\"results\": \[

{

\"note_id\": \"1896830231705320746\",

\"note_type\": \"NOTE\",

\"title\": \"笔记标题\",

\"content\": \"相关内容片段\",

\"created_at\": \"2025-12-24 15:20:15\"

}

\]

}

}

### **知识库语义搜索**

POST /open/api/v1/resource/recall/knowledge

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/recall/knowledge\' \\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"topic_id\": \"abc123\", \"query\": \"RAG 技术\", \"top_k\": 5}\'

## **博主与直播**

### **博主列表**

GET /open/api/v1/resource/knowledge/bloggers?topic_id={topic_id}&page=1

### **博主内容列表**

GET
/open/api/v1/resource/knowledge/blogger/contents?topic_id={topic_id}&follow_id={follow_id}&page=1

### **博主内容详情（含原文）**

GET
/open/api/v1/resource/knowledge/blogger/content/detail?topic_id={topic_id}&post_id={post_id_alias}

### **已完成直播列表**

GET /open/api/v1/resource/knowledge/lives?topic_id={topic_id}&page=1

### **直播详情（总结 + 原文）**

GET
/open/api/v1/resource/knowledge/live/detail?topic_id={topic_id}&live_id={live_id}

### **添加直播订阅**

POST /open/api/v1/resource/knowledge/live/follow

curl -X POST
\'https://openapi.biji.com/open/api/v1/resource/knowledge/live/follow\'
\\

-H \'Authorization: gk_live_xxxxx\' \\

-H \'X-Client-ID: cli_xxxxx\' \\

-H \'Content-Type: application/json\' \\

-d \'{\"topic_id\": \"abc123\", \"link\":
\"https://m.dedao.cn/live/xxxxx\"}\'

⚠️ 目前仅支持得到 App 直播链接

## **权限（Scope）说明**

  -------------------------------------------------
  **Scope**                **说明**
  ------------------------ ------------------------
  note.content.read        读取笔记（列表、详情）

  note.content.write       新增或修改笔记

  note.tag.read            获取标签列表

  note.tag.write           修改标签

  note.recall.read         全局语义搜索

  note.topic.read          获取知识库笔记

  note.topic.write         笔记加入/移出知识库

  note.topic.recall.read   知识库语义搜索

  topic.read               获取知识库信息

  topic.write              创建和编辑知识库

  note.image.upload        获取图片上传凭证

  note.content.trash       笔记移入回收站

  topic.blogger.read       获取知识库博主内容

  topic.live.read          获取知识库直播内容
  -------------------------------------------------

## **错误码**

  -----------------------------------
  **code**   **说明**
  ---------- ------------------------
  0          成功

  10000      参数错误

  10001      鉴权失败

  10100      数据不存在

  10201      非会员

  10202      QPS 限流

  30000      服务调用失败，稍后重试

  42900      配额限流

  50000      系统错误
  -----------------------------------

**限流响应（429）** 的 error.reason 取值：

  -------------------------------------------------------------
  **reason**    **说明**
  ------------- -----------------------------------------------
  qps_global    全局 QPS 超限

  qps_bucket    桶级 QPS 超限

  quota_day     当日配额用尽

  quota_month   当月配额用尽

  not_member    非会员，需开通：https://www.biji.com/checkout
  -------------------------------------------------------------

**配额说明（error.rate_limit 下）：**

{

\"read\": {

\"daily\": {\"limit\": 20000, \"used\": 100, \"remaining\": 19900,
\"reset_at\": 1741190400},

\"monthly\": {\"limit\": 200000, \"used\": 100, \"remaining\": 199900,
\"reset_at\": 1743811200}

},

\"write\": { \... }

}
