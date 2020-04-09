#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: ClayMoreBoy
# Github: https://github.com/ClayMoreBoy
#=================================================

# 定制默认IP
# sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

#取掉默认主题
sed -i 's/ +luci-theme-bootstrap//g' feeds/luci/collections/luci/Makefile

# root默认密码password
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
# sed -i 's/lienol//g' /etc/opkg/distfeeds.conf

# WIFI名为MAC后六位
rm -rf package/kernel/mac80211/files/lib/wifi/mac80211.sh
cp -f ../mac80211.sh package/kernel/mac80211/files/lib/wifi/

# 替换banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/

# 自定义固件
rm -rf package/lean/default-settings/files/zzz-default-settings
cp -f ../zzz-default-settings package/lean/default-settings/files/

# 增加制作人
# sed -i "s/echo \"DISTRIB_DESCRIPTION='OpenWrt SNAPSHOT '\"/echo \"DISTRIB_DESCRIPTION='OpenWrt SNAPSHOT Compiled by ClayMoreBoy '\"/g" package/default-settings/files/zzz-default-settings

# 更改改机器名称
# sed -i 's/OpenWrt/R7800/g' package/base-files/files/bin/config_generate

# 替换默认Argon主题
# rm -rf package/lean/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 添加第三方软件包
# git clone https://github.com/ClayMoreBoy/OpenAppFilter package/OpenAppFilter
# git clone https://github.com/ClayMoreBoy/luci-app-serverchan.git package/luci-app-serverchan
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone https://github.com/ClayMoreBoy/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone https://github.com/vernesong/OpenClash package/luci-app-OpenClash
# git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
# git clone https://github.com/ClayMoreBoy/luci-theme-rosy.git package/luci-theme-rosy

#创建自定义配置文件 - OpenWrt-R7800

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 编译R7800固件:
#cat >> .config <<EOF
#CONFIG_TARGET_ipq806x=y
#CONFIG_TARGET_ipq806x_generic=y
#CONFIG_TARGET_ipq806x_generic_DEVICE_netgear_r7800=y
#EOF

# 编译R7800固件:
cat >> .config <<EOF
CONFIG_TARGET_ipq806x=y
CONFIG_TARGET_ipq806x_DEVICE_netgear_r7800=y
EOF

# LuCI主题:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-theme-argon is not set
# CONFIG_PACKAGE_luci-theme-bootstrap is not set
# CONFIG_PACKAGE_luci-theme-bootstrap-mod is not set
CONFIG_PACKAGE_luci-theme-material=y
# CONFIG_PACKAGE_luci-theme-openwrt is not set
EOF

# 
# ========================固件定制部分结束========================
#

sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
