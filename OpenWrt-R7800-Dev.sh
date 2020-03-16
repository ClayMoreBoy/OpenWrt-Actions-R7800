  
#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: ClayMoreBoy
# Github: https://github.com/ClayMoreBoy
#=================================================

# 定制默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

#取掉默认主题
sed -i 's/ +luci-theme-bootstrap//g' feeds/luci/collections/luci/Makefile

# sed -i 's/ autosamba//g' target/linux/ipq806x/Makefile
# sed -i 's/ v2ray//g' target/linux/ipq806x/Makefile

#WIFI名为MAC后六位
sed -i 's/OpenWrt/ClayMore_$(cat /sys/class/ieee80211/${dev}/macaddress|awk -F ":" '{print $4""$5""$6 }'| tr a-z A-Z)/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 增加制作人
sed -i "s/echo \"DISTRIB_DESCRIPTION='OpenWrt '\"/echo \"DISTRIB_DESCRIPTION='OpenWrt Compiled by ClayMoreBoy '\"/g" package/default-settings/files/zzz-default-settings

#更改固件名称
sed 's/OpenWrt/ClayMore/g' package/base-files/files/bin/config_generate

# 替换默认Argon主题
#rm -rf package/lean/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/ClayMoreBoy/OpenAppFilter package/OpenAppFilter
git clone https://github.com/ClayMoreBoy/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/ClayMoreBoy/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/vernesong/OpenClash package/luci-app-OpenClash
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/ClayMoreBoy/luci-theme-rosy.git package/luci-theme-rosy
git clone https://github.com/ClayMoreBoy/luci-app-serverchan.git package/OpenAppFilter

#创建自定义配置文件 - OpenWrt-R7800

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎样的定制, 都需要且只需要修改 EOF 回环内的内容.
# 

# 编译R7800固件:
cat >> .config <<EOF
CONFIG_TARGET_ipq806x_generic=y
CONFIG_TARGET_ipq806x_generic_DEVICE_netgear_r7800=y
EOF

# 设置固件大小:
# cat >> .config <<EOF
# CONFIG_TARGET_KERNEL_PARTSIZE=300
# CONFIG_TARGET_ROOTFS_PARTSIZE=500
# EOF

# 固件压缩:
# cat >> .config <<EOF
# CONFIG_TARGET_IMAGES_GZIP=y
# EOF

# 编译UEFI固件:
# cat >> .config <<EOF
# CONFIG_EFI_IMAGES=y
# EOF

# IPv6支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
# CONFIG_PACKAGE_ipv6helper=y
# EOF

# 多文件系统支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-fs-nfs=y
# CONFIG_PACKAGE_kmod-fs-nfs-common=y
# CONFIG_PACKAGE_kmod-fs-nfs-v3=y
# CONFIG_PACKAGE_kmod-fs-nfs-v4=y
# CONFIG_PACKAGE_kmod-fs-ntfs=y
# CONFIG_PACKAGE_kmod-fs-squashfs=y
# EOF

# USB3.0支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-usb-ohci=y
# CONFIG_PACKAGE_kmod-usb-ohci-pci=y
# CONFIG_PACKAGE_kmod-usb2=y
# CONFIG_PACKAGE_kmod-usb2-pci=y
# CONFIG_PACKAGE_kmod-usb3=y
# EOF

# 第三方插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-oaf=y #应用过滤
CONFIG_PACKAGE_luci-app-serverchan=y #微信推送
CONFIG_PACKAGE_luci-app-adguardhome=y #ADguardHome去广告服务
# CONFIG_PACKAGE_luci-app-openclash=y
EOF

# lienol插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-unblockmusic=y
# CONFIG_POSTFIX_TLS is not set
# CONFIG_POSTFIX_SASL is not set
# CONFIG_POSTFIX_LDAP is not set
# CONFIG_POSTFIX_CDB is not set
# CONFIG_POSTFIX_SQLITE is not set
# CONFIG_POSTFIX_PCRE is not set
# CONFIG_KERNEL_IPV6 is not set
# CONFIG_KERNEL_IPV6_MULTIPLE_TABLES is not set
# CONFIG_KERNEL_IPV6_SUBTREES is not set
# CONFIG_KERNEL_IPV6_MROUTE is not set
EOF

# 常用LuCI插件(启用):
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-mwan3helper=y #多拨负载均衡
CONFIG_PACKAGE_luci-app-mwan3=y #多线多拨
CONFIG_PACKAGE_luci-app-guest-wifi=y #WiFi访客网络
EOF

# LuCI主题:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-theme-argon is not set
# CONFIG_PACKAGE_luci-theme-netgear is not set
CONFIG_PACKAGE_luci-theme-argon-dark-mod=y
# CONFIG_PACKAGE_luci-theme-argon-light-mod is not set
# CONFIG_PACKAGE_luci-theme-bootstrap-mod is not set
CONFIG_PACKAGE_luci-theme-atmaterial=y
# CONFIG_PACKAGE_luci-theme-rosy is not set
EOF

# 常用软件包:
# cat >> .config <<EOF
# CONFIG_PACKAGE_curl=y
# CONFIG_PACKAGE_htop=y
# CONFIG_PACKAGE_nano=y
# CONFIG_PACKAGE_screen=y
# CONFIG_PACKAGE_tree=y
# CONFIG_PACKAGE_vim-fuller=y
# CONFIG_PACKAGE_wget=y
# EOF

# 
# ========================固件定制部分结束========================
# 


sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
