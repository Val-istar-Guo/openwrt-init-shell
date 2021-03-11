wget http://openwrt.val-istar-guo.com/mime.pub -O /tmp/mime.pub
opkg-key add /tmp/mime.pub
opkg update
wget https://raw.githubusercontent.com/Val-istar-Guo/openwrt-init-shell/master/update.sh -O /usr/share/crontabs/update.sh
