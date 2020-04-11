  
#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: ClayMoreBoy
# Github: https://github.com/ClayMoreBoy
#=================================================

# 取掉默认主题
# sed -i 's/ +luci-theme-bootstrap//g' feeds/luci/collections/luci/Makefile

# WIFI名为MAC后六位
rm -rf package/kernel/mac80211/files/lib/wifi/mac80211.sh
cp -f ../mac80211-Snapshot.sh package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 替换banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/

# 自定义固件
rm -rf package/lean/default-settings/files/zzz-default-settings
cp -f ../zzz-default-settings-Snapshot package/lean/default-settings/files/zzz-default-settings

# 替换ipq806x/Makefile
rm -rf target/linux/ipq806x/Makefile
cp -f ../Makefile target/linux/ipq806x/

# 替换target.mk
rm -rf include/target.mk
cp -f ../target.mk include/

# 添加温度显示(By YYiiEt)
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 修改固件生成名字,增加当天日期(by:左右）
sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=ClayMoreBoy-$(shell date +%Y%m%d)-$(VERSION_DIST_SANITIZED)/g' include/image.mk

# 修改版本号
sed -i 's/V2020/V$(date "+%Y.%m.%d")/g' package/lean/default-settings/files/zzz-default-settings

# 切换
sed -i 's/Lean/Snapshot/g' package/base-files/files/etc/banner

# 修改版本号
sed -i 's/V2020/V$(shell date +%Y.%m.%d)/g' package/base-files/files/etc/banner

# 创建自定义配置文件 - OpenWrt-R7800

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

# 编译者信息
cat >> .config <<EOF
CONFIG_KERNEL_BUILD_USER="ClayMoreBoy"
CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions @ ClayMoreBoy"
EOF

# 编译R7800固件:
cat >> .config <<EOF
CONFIG_TARGET_ipq806x=y
CONFIG_TARGET_ipq806x_generic=y
CONFIG_TARGET_ipq806x_generic_DEVICE_netgear_r7800=y
EOF

# IPv6支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
# CONFIG_PACKAGE_ipv6helper=y
# EOF

# USB3.0支持:
cat >> .config <<EOF
CONFIG_PACKAGE_kmod-usb-ohci=y
CONFIG_PACKAGE_kmod-usb-ohci-pci=y
CONFIG_PACKAGE_kmod-usb2=y
CONFIG_PACKAGE_kmod-usb2-pci=y
CONFIG_PACKAGE_kmod-usb3=y
EOF

# 插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-adguardhome=y #ADguardHome去广告服务
CONFIG_PACKAGE_luci-app-cpufreq=y #CPU 性能优化调节
CONFIG_PACKAGE_luci-app-smartdns=y #SmartDnsDNS服务
CONFIG_PACKAGE_luci-app-filetransfer=y #系统-文件传输
CONFIG_PACKAGE_luci-app-guest-wifi=y #WiFi访客网络
CONFIG_PACKAGE_luci-app-netdata=y #Netdata实时监控(图表)
CONFIG_PACKAGE_luci-app-serverchan=y #微信推送
CONFIG_PACKAGE_luci-app-qos-gargoyle=y #Gargoyle QoS流控
CONFIG_PACKAGE_luci-app-ramfree=y #释放内存
CONFIG_PACKAGE_luci-app-unblockmusic=y #解锁网易云灰色歌曲
CONFIG_UnblockNeteaseMusic_Go=y #解锁网易云灰色歌曲
# CONFIG_UnblockNeteaseMusic_NodeJS is not set #解锁网易云灰色歌曲
CONFIG_PACKAGE_luci-app-upnp=y #通用即插即用UPnP(端口自动转发)
CONFIG_PACKAGE_luci-app-flowoffload=y #Turbo ACC 网络加速
CONFIG_PACKAGE_luci-app-autoreboot=y #支持计划重启
CONFIG_PACKAGE_luci-app-ddns=y #DDNS服务
CONFIG_PACKAGE_ddns-scripts_aliyun=y #DDNS服务
CONFIG_PACKAGE_ddns-scripts_dnspod=y #DDNS服务
CONFIG_PACKAGE_luci-app-upnp=y #通用即插即用UPnP(端口自动转发)
# CONFIG_PACKAGE_luci-app-filebrowser is not set #文件浏览器
CONFIG_PACKAGE_luci-app-arpbind=y #IP/MAC绑定
EOF

# Passwall插件:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ipt2socks=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_socks is not set
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_socks is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook is not set
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_kcptun is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_haproxy=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ChinaDNS_NG=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_pdnsd=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_dns2socks=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_v2ray-plugin is not set
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_simple-obfs is not set
EOF

# SSR-Plus插件:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-ssr-plus=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks=y
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Simple_obfs is not set
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_V2ray_plugin is not set
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_V2ray=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Trojan=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Redsocks2=y
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Kcptun is not set
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Server is not set
EOF

# ssr-plus-Jo(禁用):
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_Shadowsocks is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_V2ray is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_Trojan is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_Kcptun is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_ShadowsocksR_Server is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_Shadowsocks_Server is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_ShadowsocksR_Socks is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_Shadowsocks_Socks is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_ipt2socks is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_dnscrypt_proxy is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_dnsforwarder is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_ChinaDNS is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_haproxy is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_privoxy is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_simple-obfs is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_simple-obfs-server is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_udpspeeder is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_udp2raw-tunnel is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_GoQuiet-client is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_GoQuiet-server is not set
# CONFIG_PACKAGE_luci-app-ssr-plus-Jo_INCLUDE_v2ray-plugin is not set
# CONFIG_PACKAGE_luci-app-vssr is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Shadowsocks is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_V2ray is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Trojan is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Kcptun is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ShadowsocksR_Server is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Shadowsocks_Server is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ShadowsocksR_Socks is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Shadowsocks_Socks is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ipt2socks is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_microsocks is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_dns2socks is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_dnscrypt_proxy is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_dnsforwarder is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ChinaDNS is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_haproxy is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_privoxy is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_simple-obfs is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_simple-obfs-server is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_udpspeeder is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_udp2raw-tunnel is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_GoQuiet-client is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_GoQuiet-server is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_v2ray-plugin is not set
# CONFIG_PACKAGE_luci-app-diskman_INCLUDE_btrfs_progs is not set
# CONFIG_PACKAGE_luci-app-diskman_INCLUDE_lsblk is not set
# CONFIG_PACKAGE_luci-app-dockerman_INCLUDE_ttyd is not set
# CONFIG_POSTFIX_TLS is not set
# CONFIG_POSTFIX_SASL is not set
# CONFIG_POSTFIX_LDAP is not set
# CONFIG_POSTFIX_CDB is not set
# CONFIG_POSTFIX_SQLITE is not set
# CONFIG_POSTFIX_PCRE is not set
EOF

# LuCI主题:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-theme-argon is not set
CONFIG_PACKAGE_luci-theme-bootstrap=y
# CONFIG_PACKAGE_luci-theme-bootstrap-mod is not set
CONFIG_PACKAGE_luci-theme-material=y
# CONFIG_PACKAGE_luci-theme-openwrt is not set
EOF

# 
# ========================固件定制部分结束========================
#

sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
