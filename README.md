## Netgear R7800路由器固件自动编译
固件来源：
[Lean](https://github.com/coolsnowwolf/lede)  丨  [Lienol](https://github.com/Lienol/openwrt)

--------------
* [编译状态](#编译状态)
* [更新建议](#更新建议)
* [特别功能](#特别功能)
* [固件下载](#固件下载)
--------------

### 编译状态
[![OpenWrt-R7800-Lienol-Lean](https://github.com/ClayMoreBoy/OpenWrt-R7800-Actions/workflows/OpenWrt-R7800-Lienol-Lean/badge.svg)](https://github.com/ClayMoreBoy/OpenWrt-R7800-Actions/actions?query=workflow%3AOpenWrt-R7800-Lienol-Lean)

[![OpenWrt-R7800-Lean](https://github.com/ClayMoreBoy/OpenWrt-R7800-Actions/workflows/OpenWrt-R7800-Lean/badge.svg)](https://github.com/ClayMoreBoy/OpenWrt-R7800-Actions/actions?query=workflow%3AOpenWrt-R7800-Lean)

[![OpenWrt-R7800-Dev](https://github.com/ClayMoreBoy/OpenWrt-R7800-Actions/workflows/OpenWrt-R7800-Dev/badge.svg)](https://github.com/ClayMoreBoy/OpenWrt-R7800-Actions/actions?query=workflow%3AOpenWrt-R7800-Dev)

仅编译网件R7800的路由器固件，原则上不接受个性化定制。

编译的固件永久保存以供挑选使用。

### 更新建议
重大版本或重大改动时，建议不保留配置全新更新。

### 特别功能

#### 不服来跑个分？cpu跑分
使用SSH连接路由器终端，输入`/etc/coremark.sh` ，回车，稍等片刻后，访问路由器主页，概况里将显示分数，例如网件R7800的主页主机型号末尾将会显示路由器跑分` Netgear Nighthawk X4S R7800 (CpuMark : 12654.587288 Scores) ` 。

#### 温度监控（仅限网件R7800）
网件r7800添加额外功能温度监控。

### 固件下载
#### 最新固件下载
网件r7800：[点此下载](https://github.com/ClayMoreBoy/OpenWrt-Actions-Lean-R7800/actions)

- 请注意：你需要点击`OpenWrt-R7800-Actions`按钮进入页面，然后点击`OpenWrt_Firmware_R7800`按钮进行下载。


### 固件首次安装方式/刷机/救砖介绍
- 网件r7800：官方固件-更新固件-刷入img格式即可
