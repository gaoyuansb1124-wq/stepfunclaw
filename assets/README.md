# 资产库说明

> 本地资产的源文件仓库，存放成熟的经验文档和自制技能。
> 知识库（knowledge/）是毛坯，资产库（assets/）是精装。

## 目录结构

```
assets/
├── experiences/   # 经验文档（可发布到水产市场）
└── skills/        # 自制技能源文件（要用时安装到系统路径）
```

## 资产生命周期

```
knowledge/ 积累原始知识
      ↓
整理成完整格式
      ↓
存入 assets/（experiences/ 或 skills/）
      ↓
时机合适 → 发布到水产市场
```

## 各类资产的调用方式

| 资产类型 | 调用方式 |
|---------|---------|
| 知识库（knowledge/） | 执行任务前主动查阅 |
| 经验文档（assets/experiences/） | 做同类任务时主动参考 |
| 自制技能源文件（assets/skills/） | 需要使用时安装到 ~/.stepclaw/skills/ |

## 注意

- `assets/skills/` 是源文件备份，系统不会自动识别
- 技能要生效必须安装到 `~/.stepclaw/skills/` 路径
- 经验文档无需安装，主动读取即可
