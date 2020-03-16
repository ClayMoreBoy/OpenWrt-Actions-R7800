  
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

sed -i 's/ autosamba//g' target/linux/ipq806x/Makefile
# sed -i 's/ v2ray//g' target/linux/ipq806x/Makefile

#WIFI名为MAC后六位
sed -i "s/OpenWrt/ClayMore_$(cat /sys/class/ieee80211/${dev}/macaddress|awk -F ":" '{print $4""$5""$6 }'| tr a-z A-Z)/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

uci set wireless.@wifi-iface[0].ssid=OpenWrt_$(cat /sys/class/ieee80211/${dev}/macaddress|awk -F ":" '{print $4""$5""$6 }'| tr a-z A-Z)
uci commit

# 增加制作人
sed -i "s/echo \"DISTRIB_DESCRIPTION='OpenWrt '\"/echo \"DISTRIB_DESCRIPTION='OpenWrt Compiled by ClayMoreBoy '\"/g" package/lean/default-settings/files/zzz-default-settings

#更改固件名称
sed -i 's/OpenWrt/ClayMore/g' package/base-files/files/etc/init.d/system

# 替换默认Argon主题
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/ClayMoreBoy/OpenAppFilter package/OpenAppFilter
git clone https://github.com/ClayMoreBoy/luci-app-serverchan.git package/luci-app-serverchan
# git clone https://github.com/ClayMoreBoy/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone https://github.com/vernesong/OpenClash package/luci-app-OpenClash
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/ClayMoreBoy/luci-theme-rosy.git package/luci-theme-rosy

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
CONFIG_TARGET_ipq806x=y
CONFIG_TARGET_ipq806x_DEVICE_netgear_r7800=y
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
cat >> .config <<EOF
# CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
# CONFIG_PACKAGE_ipv6helper=y
# CONFIG_IPV6 is not set
EOF

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
# CONFIG_PACKAGE_luci-app-adguardhome=y #ADguardHome去广告服务
# CONFIG_PACKAGE_luci-app-openclash=y
EOF

# Lienol插件选择:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Server is not set
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

# 常用LuCI插件(禁用):
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-smartdns is not set #smartdnsDNS服务
CONFIG_PACKAGE_luci-app-unblockmusic=y #解锁网易云灰色歌曲
CONFIG_PACKAGE_luci-app-unblockneteasemusic-go=y #解锁网易云灰色歌曲
CONFIG_PACKAGE_luci-app-unblockneteasemusic-mini=y #解锁网易云灰色歌曲
# CONFIG_PACKAGE_luci-app-xlnetacc is not set #迅雷快鸟
# CONFIG_PACKAGE_luci-app-usb-printer is not set #USB打印机
# CONFIG_PACKAGE_luci-app-mwan3helper is not set #多拨负载均衡
# CONFIG_PACKAGE_luci-app-mwan3 is not set #多线多拨
# CONFIG_PACKAGE_luci-app-hd-idle is not set #磁盘休眠
# CONFIG_PACKAGE_luci-app-wrtbwmon is not set #实时流量监测
#
# passwall相关(禁用):
#
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ipt2socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ChinaDNS_NG=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_v2ray-plugin=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_simple-obfs=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_kcptun=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_haproxy=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_dns2socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_pdnsd=y
CONFIG_PACKAGE_kcptun-client=y
CONFIG_PACKAGE_chinadns-ng=y
CONFIG_PACKAGE_haproxy=y
CONFIG_PACKAGE_v2ray=y
CONFIG_PACKAGE_v2ray-plugin=y
CONFIG_PACKAGE_simple-obfs=y
CONFIG_PACKAGE_trojan=y
CONFIG_PACKAGE_brook=y
CONFIG_PACKAGE_ipt2socks=y
CONFIG_PACKAGE_shadowsocks-libev-config=y
CONFIG_PACKAGE_shadowsocks-libev-ss-local=y
CONFIG_PACKAGE_shadowsocks-libev-ss-redir=y
CONFIG_PACKAGE_shadowsocksr-libev-alt=y
CONFIG_PACKAGE_shadowsocksr-libev-ssr-local=y
#
# VPN相关插件(禁用):
#
# CONFIG_PACKAGE_luci-app-ipsec-vpnserver-manyusers is not set #ipsec VPN服务
# CONFIG_PACKAGE_luci-app-zerotier is not set #Zerotier内网穿透
# CONFIG_PACKAGE_luci-app-ipsec-vpnd is not set #IPSec VPN 服务器
# CONFIG_PACKAGE_luci-app-pppoe-relay is not set #PPPoE穿透
# CONFIG_PACKAGE_luci-app-pppoe-server is not set #PPPoE服务器
# CONFIG_PACKAGE_luci-app-pptp-vpnserver-manyusers is not set #PPTP VPN 服务器
# CONFIG_PACKAGE_luci-app-trojan-server is not set #Trojan服务器
# CONFIG_PACKAGE_luci-app-v2ray-server is not set #V2ray服务器
# CONFIG_PACKAGE_luci-app-brook-server is not set #brook服务端
# CONFIG_PACKAGE_luci-app-ssr-libev-server is not set #ssr-libev服务端
# CONFIG_PACKAGE_luci-app-ssr-python-pro-server is not set #ssr-python服务端
# CONFIG_PACKAGE_luci-app-kcptun is not set #Kcptun客户端
# CONFIG_PACKAGE_shadowsocksr-libev-server is not set #ssr服务端
#
# 文件共享相关(禁用):
#
# CONFIG_PACKAGE_luci-app-aria2 is not set #Aria2离线下载
# CONFIG_PACKAGE_luci-app-minidlna is not set #miniDLNA服务
# CONFIG_PACKAGE_luci-app-kodexplorer is not set #可到私有云
# CONFIG_PACKAGE_luci-app-filebrowser is not set #File Browser私有云
# CONFIG_PACKAGE_luci-app-fileassistant is not set #文件助手
# CONFIG_PACKAGE_luci-app-vsftpd is not set #FTP 服务器
# CONFIG_PACKAGE_luci-app-samba is not set #网络共享
# CONFIG_PACKAGE_autosamba is not set #网络共享
# CONFIG_PACKAGE_samba36-server is not set #网络共享
EOF

# 常用LuCI插件(启用):
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-adbyby-plus=y #adbyby去广告
# CONFIG_PACKAGE_luci-app-webadmin is not set #Web管理页面设置
CONFIG_PACKAGE_luci-app-filetransfer=y #系统-文件传输
CONFIG_PACKAGE_luci-app-autoreboot=y #定时重启
# CONFIG_PACKAGE_luci-app-frpc is not set #Frp内网穿透
# CONFIG_PACKAGE_luci-app-frps is not set #Frp内网穿透服务器
CONFIG_PACKAGE_luci-app-upnp=y #通用即插即用UPnP(端口自动转发)
# CONFIG_PACKAGE_luci-app-softethervpn is not set #SoftEtherVPN服务器
# CONFIG_DEFAULT_luci-app-vlmcsd is not set #KMS激活服务器
CONFIG_PACKAGE_luci-app-sqm=y #SQM智能队列管理
# CONFIG_PACKAGE_luci-app-ddns is not set #DDNS服务
# CONFIG_PACKAGE_luci-app-wol is not set #网络唤醒
# CONFIG_PACKAGE_luci-app-control-mia is not set #时间控制
# CONFIG_PACKAGE_luci-app-control-timewol is not set #定时唤醒
# CONFIG_PACKAGE_luci-app-control-webrestriction is not set #访问限制
# CONFIG_PACKAGE_luci-app-control-weburl is not set #网址过滤
CONFIG_PACKAGE_luci-app-flowoffload=y #Turbo ACC 网络加速
CONFIG_PACKAGE_luci-app-nlbwmon=y #宽带流量监控
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
CONFIG_PACKAGE_luci-theme-rosy=y
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
