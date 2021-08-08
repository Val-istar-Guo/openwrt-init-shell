opkg update


# 汉化
opkg install luci-i18n-base-zh-cn luci-i18n-opkg-zh-cn luci-i18n-firewall-zh-cn


# 升级所有依赖
opkg list-upgradable | cut -f 1 -d ' ' | xargs opkg upgrade


# 实时监控
opkg install luci-app-statistics luci-i18n-statistics-zh-cn collectd-mod-curl

uci set luci_statistics.collectd_curl.enable='1'

uci add luci_statistics collectd_curl_page
uci set luci_statistics.@collectd_curl_page[-1].enable='1'
uci set luci_statistics.@collectd_curl_page[-1].name='BaiDu'
uci set luci_statistics.@collectd_curl_page[-1].url='baidu.com'

uci add luci_statistics collectd_curl_page
uci set luci_statistics.@collectd_curl_page[-1].enable='1'
uci set luci_statistics.cfg288c80.name='Google'
uci set luci_statistics.cfg288c80.url='google.com'

# 无线网设置
PASSWORD="changeme"
ESSID="无线账户"
uci set wireless.radio0.country='US'
uci set wireless.radio0.htmode='VHT160'
uci set wireless.radio0.channel='auto'
uci set wireless.default_radio0.key=$PASSWORD
uci set wireless.default_radio0.ssid=$ESSID
uci set wireless.default_radio0.encryption='psk2'
uci set wireless.default_radio1.key=$PASSWORD
uci set wireless.default_radio1.ssid=$ESSID
uci set wireless.default_radio1.encryption='psk2'
uci set wireless.default_radio2.key=$PASSWORD
uci set wireless.default_radio2.ssid=$ESSID
uci set wireless.default_radio2.encryption='psk2'


# DDNS
opkg install ddns-scripts luci-app-ddns luci-i18n-ddns-zh-cn


# 支持HTTPS
opkg install libustream-openssl


#  配置局域网NAS
## 设置静态路由，NAS在局域网具有固定IP。（此操作也需要在NAS中配置静态IP地址）
uci add dhcp host
uci set dhcp.@host[-1].mac='00:11:32:EA:11:F9'
uci set dhcp.@host[-1].dns='1'
uci set dhcp.@host[-1].name='NAS'
uci set dhcp.@host[-1].ip='192.168.1.2'
uci set dhcp.@host[-1].mac=' 00:11:32:EA:11:FA'
uci set dhcp.@host[-1].dns='1'
uci set dhcp.@host[-1].name='NAS'
uci set dhcp.@host[-1].ip='192.168.1.3'
## 设置端口转发。（如果NAS有网页版操作界面，外网访问需要防火墙配置端口转发）
### NAS终端
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='5000'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='NAS'
uci set firewall.@redirect[-1].src_dport='5000'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
### Photo Station管理服务
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='80'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='Photo Station'
uci set firewall.@redirect[-1].src_dport='19000'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
### Vidio Station管理服务
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='9007'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='Vidio Station'
uci set firewall.@redirect[-1].src_dport='18000'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
### MAIL邮箱服务
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='25'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='SMTP'
uci set firewall.@redirect[-1].src_dport='25'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
uci add_list firewall.@redirect[-1].proto='tcp'
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='143'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='IMAP'
uci set firewall.@redirect[-1].src_dport='143'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='110'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='POP3'
uci set firewall.@redirect[-1].src_dport='110'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
uci add_list firewall.@redirect[-1].proto='tcp'
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='465'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='SMTP-SS'
uci set firewall.@redirect[-1].src_dport='465'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
uci add_list firewall.@redirect[-1].proto='tcp'
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='587'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='SMTP-TLS'
uci set firewall.@redirect[-1].src_dport='587'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
uci add_list firewall.@redirect[-1].proto='tcp'
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='993'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='IMAP-SSL/TLS'
uci set firewall.@redirect[-1].src_dport='993'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
uci add_list firewall.@redirect[-1].proto='tcp'
uci add firewall redirect
uci set firewall.@redirect[-1].dest_port='995'
uci set firewall.@redirect[-1].src='wan'
uci set firewall.@redirect[-1].name='POP3-SSL/TLS'
uci set firewall.@redirect[-1].src_dport='995'
uci set firewall.@redirect[-1].target='DNAT'
uci set firewall.@redirect[-1].dest_ip='192.168.1.2'
uci set firewall.@redirect[-1].dest='lan'
uci add_list firewall.@redirect[-1].proto='tcp'
uci commit firewall


# 每天4点更新OPKG
touch /etc/root/root
echo "0 4 * * * opkg update" > /etc/crontabs/root
/etc/init.d/cron enable


# 科学上网
# 本项目使用 https://github.com/Hill-98/luci-app-shadowsocksr
# 作者仅将相关包为WRT3200ACM路由器编译，并未支持其他架构路由器
# 需要的请自行编译ipk安装包
# 或者为 https://github.com/Val-istar-Guo/openwrt-packages-arm_cortex-a9_vfpv3-d16 项目提交代码支持您的路由器架构
# 作者不会予以支持
## 必要依赖
opkg install libpcre libev libsodium libudns
opkg install ipset
## 支持UDP协议透明代理
opkg install iptables-mod-tproxy ip
## DNS污染列表解析
opkg remove dnsmasq
opkg install dnsmasq-full
## 获取 DNS 域名污染列表和服务器订阅数据
opkg install curl
## base64 解码 DNS 域名污染列表和服务器订阅数据
opkg install coreutils-base64
## 服务器订阅脚本使用 bash 解释器运行
opkg install bash
## 用于订阅脚本解析域名
opkg install bind-dig
## 仅适用于WRT3200ACM路由器的安装源
## 后续安装需要私搭安装源支持
wget http://openwrt.val-istar-guo.com/mime.pub
opkg-key add mime.pub
echo "src/gz vg http://openwrt.val-istar-guo.com/" > /etc/opkg/customfeeds.conf
opkg update
## 用于订阅脚本检测 IP 地址合法性
opkg install ckipver
## 防污染包
opkg install cdns dns-forwarder pdnsd
opkg install shadowsocksr-libev luci-app-shadowsocksr


# 每天4点更新OPKG
mkdir /usr/share/crontabs
wget https://raw.githubusercontent.com/Val-istar-Guo/openwrt-init-shell/master/update.sh -O /usr/share/crontabs/update.sh
chmod +x /usr/share/crontabs/update.sh
touch /etc/root/root
echo "0 4 * * * /usr/share/crontabs/update.sh" > /etc/crontabs/root
/etc/init.d/cron enable


# 美化界面
wget --no-check-certificate https://github.com/jerrykuku/luci-theme-argon/releases/download/v2.2.5/luci-theme-argon_2.2.5-20200914_all.ipk -O luci-theme-argon.ipk
opkg install luci-theme-argon.ipk
