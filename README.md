# 《逆天仙尊：李晓鹏》iPhone 版

一款原生 SwiftUI 中文文字冒险游戏。主角李晓鹏回归现代都市，表面毫无修为，真实身份却是轮回归来的诸天至尊。游戏主打扮猪吃虎、连续反转、爽文式打脸，同时包含成年角色之间的情感羁绊。

## 已实现内容

- 8 章主线、30 个剧情场景、多个分支与 3 个最终结局
- 4 位成年女主：林晚晴、苏清寒、沈星璃、江雨柔
- 境界、灵力、财富、声望、爽点等角色数值
- 红颜好感与羁绊阶段
- 乾坤袋背包和不同稀有度道具
- 7 条主线任务及状态变化
- 自动存档、3 个手动存档、二周目继承
- 原生 iPhone 深色鎏金界面和完整 App 图标
- GitHub Actions 自动生成未签名 IPA

## 最省事的安装方式：GitHub 生成 IPA + 全能签

当前交付目录内已经配置好苹果的云端编译流程，不需要把证书上传到 GitHub。

1. 在 GitHub 新建一个仓库。
2. 将本目录中的全部内容上传到仓库根目录。注意 `.github` 文件夹也必须上传。
3. 打开仓库的 **Actions** 页面，选择 **Build Unsigned IPA**。
4. 点击 **Run workflow**，等待编译完成。
5. 在这次任务页面底部下载 `LiXiaopengImmortal-unsigned-IPA`。
6. 解压下载的压缩包，得到 `LiXiaopengImmortal-unsigned.ipa`。
7. 将 IPA 传到 iPhone 的“文件”App，使用全能签导入。
8. 在全能签中选择你自己的证书和描述文件，签名后安装。

如果描述文件不接受默认包名 `com.lixiaopeng.immortal`，请在全能签中将 Bundle ID 改成证书允许的标识符后再签名。

## 使用 Mac 和 Xcode 直接安装

1. 使用 Xcode 15 或更高版本打开 `LiXiaopengImmortal.xcodeproj`。
2. 点击项目中的 `LiXiaopengImmortal` Target，进入 **Signing & Capabilities**。
3. 选择你的 Team；如包名冲突，改成属于你的唯一 Bundle Identifier。
4. 用数据线或同一 Wi-Fi 连接 iPhone，选择该设备后点击运行按钮。
5. iOS 16 及以上首次调试可能需要在“设置 → 隐私与安全性 → 开发者模式”中开启开发者模式。

## 在 Mac 上导出未签名 IPA

在本目录打开终端，执行：

```bash
xcodebuild \
  -project LiXiaopengImmortal.xcodeproj \
  -scheme LiXiaopengImmortal \
  -configuration Release \
  -sdk iphoneos \
  -derivedDataPath build \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  clean build

mkdir -p Payload
cp -R build/Build/Products/Release-iphoneos/LiXiaopengImmortal.app Payload/
ditto -c -k --sequesterRsrc --keepParent Payload LiXiaopengImmortal-unsigned.ipa
```

## 系统要求

- 游戏最低支持 iOS 16.0。
- 使用全能签安装需要可用的签名证书和与之匹配的描述文件。
- 未签名 IPA 不能直接点击安装，必须先在全能签中重签。
- 免费 Apple ID 通过 Xcode 安装时，签名通常只有 7 天有效期。

## 工程结构

- `LiXiaopengImmortal/Data/GameContent.swift`：全部章节、剧情节点、选择与奖励
- `LiXiaopengImmortal/Stores/GameStore.swift`：数值、分支、背包、关系与存档逻辑
- `LiXiaopengImmortal/Views/`：iPhone 界面
- `.github/workflows/build-unsigned-ipa.yml`：云端未签名 IPA 编译流程

剧情内容采用数据驱动结构，后续增加章节时只需继续添加 `StoryNode`，无需重写界面和存档系统。
