# Netgear R7800 路由器固件自动编译 [![OpenWrt](https://img.shields.io/badge/From-OpenWrt-blue.svg?style=for-the-badge&logo=appveyor)](https://github.com/openwrt/openwrt) 
欢迎加入 QQ 交流群：[320907156](https://shang.qq.com/wpa/qunwpa?idkey=270264af86f9a325a0caf527654d13f0f4242c1a7dd433de3cdea880713676a9)
>固件来源：
[![Lean](https://img.shields.io/badge/Lede-Lean-red.svg?style=flat&logo=appveyor)](https://github.com/coolsnowwolf/lede) 
 [![Lienol](https://img.shields.io/badge/Package-Lienol-blueviolet.svg?style=flat&logo=appveyor)](https://github.com/Lienol/openwrt-package)  [![CTCGFW](https://img.shields.io/badge/OpenWrt-CTCGFW-orange.svg?style=flat&logo=appveyor)](https://github.com/project-openwrt/openwrt) [![ClayMoreBoy](https://img.shields.io/badge/Mod-ClayMoreBoy-success.svg?style=flat&logo=appveyor)](https://github.com/ClayMoreBoy)

## 简介：
- 自用 OpenWrt 定制项目
- 若 Fork 项目，请修改代码中自己的 TOKEN ( 项目 Settings/Secrets )

| TOKEN | 释义 |是否必须 |
| :--- | :--- | :--- |
| -- EMAIL  | Github用户邮箱 | 是 |
| -- SCKEY | Server酱SCKEY | 否 |
| -- RELEASE_TOKEN | 个人 Settings/Developer settings/Personal access tokens新建获取 | 是 |

## 功能：
- 可以支持两种种编译模式
  1. 编译Lean源码(含Lienol Package)
  2. 编译CTCGFW源码(含Lean & Lienol & CTCGFW & Ntlf9t & Zxlhhyccc Package)
- 自动上传固件
- 自动发布固件
- 自动创建分支
- 自动上传到奶牛快传

## 变量：

| 变量名 | 释义 |
| :--- | :--- |
| -- REPO_URL: https://github.com/coolsnowwolf/lede.git  | 定义源码 | 
| -- REPO_BRANCH: master | 定义分支 |
| -- DIY_SH: OpenWrt-R7800-Lean.sh | 定义脚本文件 |
| -- SSH_ACTION: false |是否打开 SSH |
| -- UPLOAD_BRANCH: true | 是否创建分支来存放编译固件及Package |
| -- BRANCH: R7800 | 分支名称 |
| -- GITHUB_USER_NAME: ClayMoreBoy | 定义Github用户名 |
| -- GITHUB_USER_EMAIL: ${{ secrets.EMAIL }} |定义Github用户邮箱 |
| -- GITHUB: github.com/ClayMoreBoy/OpenWrt-Actions-R7800.git | 定义上传分支 |
| -- UPLOAD_FIRMWARE: true | 是否上传固件| 
| -- UPLOAD_COWTRANSFER: true | 是否上传固件到奶牛快传 |
| -- CREATE_RELEASE: true | 是否创建发行版本 Release |
| -- BUILD_USER: ClayMoreBoy | 定义编译者 | 
| -- SEND_WECHAT_MSG: true | 是否微信通知 | 

## 默认配置

| 默认配置 | IP | 用户名 | 密码 |
| :--- | :--- | :--- | :--- |
| 路由 & SSH | 10.0.0.1 | root | password |
| WIFI | -- | -- | password |

## 固件下载
网件R7800：[![GitHub release (latest by date)](https://img.shields.io/github/v/release/ClayMoreBoy/OpenWrt-Actions-R7800?style=for-the-badge&label=Download)](https://github.com/ClayMoreBoy/OpenWrt-Actions-R7800/releases/latest)


## 来杯咖啡

![](https://raw.githubusercontent.com/ClayMoreBoy/OpenWrt-Actions-R7800/master/Sponsor.png)
