# Netgear R7800 路由器固件自动编译 [![OpenWrt](https://img.shields.io/badge/From-OpenWrt-blue.svg?style=for-the-badge&logo=appveyor)](https://github.com/openwrt/openwrt)[![QQ群](https://pub.idqqimg.com/wpa/images/group.png)](https://shang.qq.com/wpa/qunwpa?idkey=270264af86f9a325a0caf527654d13f0f4242c1a7dd433de3cdea880713676a9)
>固件来源：
[![Lean](https://img.shields.io/badge/Lede-Lean-red.svg?style=flat&logo=appveyor)](https://github.com/coolsnowwolf/lede) 
 [![Lienol](https://img.shields.io/badge/Package-Lienol-blueviolet.svg?style=flat&logo=appveyor)](https://github.com/Lienol/openwrt-package)  [![CTCGFW](https://img.shields.io/badge/OpenWrt-CTCGFW-orange.svg?style=flat&logo=appveyor)](https://github.com/project-openwrt/openwrt) [![ClayMoreBoy](https://img.shields.io/badge/Mod-ClayMoreBoy-success.svg?style=flat&logo=appveyor)](https://github.com/ClayMoreBoy)

## 简介：
- 自用 OpenWrt 定制项目
- 若 Fork 项目，请修改代码中自己的 TOKEN ( 项目 Settings/Secrets )

| TOKEN | 释义 |
| :--- | :--- |
| -- EMAIL  | Github用户邮箱 |
| -- TMP_LINK_TOKEN| TMP.link命令行上传文件-生成上传命令到剪贴板-token=xxxxxx |
| -- SCKEY | Server酱SCKEY |
| -- RELEASE_TOKEN | 个人 Settings/Developer settings/Personal access tokens新建获取 |

## 功能：
- 可以支持三种编译模式 
  1. 编译Lean源码 & Lienol Package(目前在用)
  2. 编译CTCGFW源码(含Lean & Lienol & Ntlf9t & Zxlhhyccc Package)(待测)
- 自动上传固件
- 自动发布固件
- 自动创建分支
- 自动上传到TMP.link
- 自动上传到奶牛快传

## 变量：

| 变量名 | 释义 |
| :--- | :--- |
| -- REPO_URL: https://github.com/coolsnowwolf/lede.git  | 定义源码 |
| -- REPO_BRANCH: master | 定义分支 |
| -- LIENOL_PACKAGES: true | 是否包含Lienol's package |
| -- DIY_SH: OpenWrt-R7800-Lean.sh | 定义脚本文件 |
| -- SSH_ACTION: false |是否打开 SSH |
| -- UPLOAD_BRANCH: true | 是否创建分支来存放编译固件及Package |
| -- BRANCH: R7800 | 分支名称 |
| -- GITHUB_USER_NAME: ClayMoreBoy | 定义Github用户名 |
| -- GITHUB_USER_EMAIL: ${{ secrets.EMAIL }} |定义Github用户邮箱 |
| -- GITHUB: github.com/ClayMoreBoy/OpenWrt-Actions-R7800.git | 定义上传分支 |
| -- UPLOAD_FIRMWARE: true | 是否上传固件| 
| -- UPLOAD_COWTRANSFER: true | 是否上传固件到奶牛快传 |
| -- UPLOAD_TMP_LINK: true| 上传到TMP.link |
| -- TARGET: ipq806x | 定义TARGET |
| -- SUBTARGET: generic | 定义SUBTARGET |
| -- CREATE_RELEASE: true | 是否创建发行版本 Release |
| -- BUILD_USER: ClayMoreBoy | 定义编译者 | 
| -- SEND_WECHAT_MSG: true | 是否微信通知 | 

## R7800 默认配置
### 默认登录IP地址:10.0.0.1
###           用户:root       (路由 & SSH)
###           密码:password   (路由 & SSH)
###       Wifi密码:password

## 固件下载
网件R7800：[点此下载](https://github.com/ClayMoreBoy/OpenWrt-Actions-R7800/releases)

## 来杯咖啡

![](https://raw.githubusercontent.com/ClayMoreBoy/OpenWrt-Actions-R7800/master/Sponsor.png)
