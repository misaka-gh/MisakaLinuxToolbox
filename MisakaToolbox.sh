#!/bin/bash

# 一些全局变量
ver="1.4.4"
changeLog="在主菜单提示VPS信息，并新增部署Telegram MTProxy脚本"
arch=`uname -m`
virt=`systemd-detect-virt`
kernelVer=`uname -r`

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

if [[ -f /etc/redhat-release ]]; then
release="Centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
release="Debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
release="Ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
release="Centos"
elif cat /proc/version | grep -q -E -i "debian"; then
release="Debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
release="Ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
release="Centos"
else 
red "不支持你当前系统，请使用Ubuntu、Debian、Centos的主流系统"
rm -f MisakaToolbox.sh
exit 1
fi

if ! type curl >/dev/null 2>&1; then 
yellow "curl未安装，安装中"
if [ $release = "Centos" ]; then
yum -y update && yum install curl -y
else
apt-get update -y && apt-get install curl -y
fi	   
else
green "curl已安装"
fi

if ! type wget >/dev/null 2>&1; then 
yellow "wget未安装，安装中"
if [ $release = "Centos" ]; then
yum -y update && yum install wget -y
else
apt-get update -y && apt-get install wget -y
fi	   
else
green "wget已安装"
fi

if ! type sudo >/dev/null 2>&1; then 
yellow "sudo未安装，安装中"
if [ $release = "Centos" ]; then
yum -y update && yum install sudo -y
else
apt-get update -y && apt-get install sudo -y
fi	   
else
green "sudo已安装"
fi

function rootLogin(){
    wget -N https://cdn.jsdelivr.net/gh/Misaka-blog/rootLogin@master/root.sh && chmod -R 777 root.sh && bash root.sh
}

function warp(){
    wget -N https://cdn.jsdelivr.net/gh/fscarmen/warp/menu.sh && bash menu.sh
}

function xui(){
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
}

function macka(){
    wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh && /root/install.sh
}

function bbr(){
    wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

function bthappy(){
    echo "                   "
    echo "请选择你需要安装的版本"
    echo "1. 专业版"
    echo "2. 企业版"
    echo "0. 返回主页"
    read -p "请输入选项:" menuNumberInput1
    case "$menuNumberInput1" in     
        1 ) bthappypro;;
        2 ) bthappyent;;
        0 ) start_menu;;
    esac
}

function bthappyent(){
    if [ $release = "Centos" ]; then
        yum install -y wget && wget -O install.sh http://download.moetas.com/ltd/install/install_6.0.sh && sh install.sh
    elif [ $release = "Debian" ]; then
        wget -O install.sh http://download.moetas.com/ltd/install/install-ubuntu_6.0.sh && bash install.sh
    else
        wget -O install.sh http://download.moetas.com/ltd/install/install-ubuntu_6.0.sh && sudo bash install.sh
    fi
}

function bthappypro(){
    if [ $release = "Centos" ]; then
        yum install -y wget && wget -O install.sh http://download.moetas.com/install/install_6.0.sh && sh install.sh
    elif [ $release = "Debian" ]; then
        wget -O install.sh http://download.moetas.com/install/install-ubuntu_6.0.sh && bash install.sh
    else
        wget -O install.sh http://download.moetas.com/install/install-ubuntu_6.0.sh && sudo bash install.sh
    fi
}

function docker(){
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
}

function mediaUnblockTest(){
    bash <(curl -sSL "https://github.com/CoiaPrant/MediaUnlock_Test/raw/main/check.sh")
}

function vpsSpeedTest(){
    bash <(curl -sSL "https://github.com/CoiaPrant/Speedtest/raw/main/speedtest-multi.sh")
}

function serverstatus(){
    wget -N https://raw.githubusercontent.com/cokemine/ServerStatus-Hotaru/master/status.sh
    echo "请选择你需要安装的客户端类型"
    echo "1. 服务端"
    echo "2. 监控端"
    echo "0. 返回主页"
    read -p "请输入选项:" menuNumberInput1
    case "$menuNumberInput1" in     
        1 ) serverstatusServer;;
        2 ) serverstatusClient;;
        0 ) start_menu;;
    esac
}

function serverstatusServer(){
    bash status.sh s
}

function serverstatusClient(){
    bash status.sh c
}

function changehostname(){
    read -p "您的新主机名:" newhostname
    hostnamectl set-hostname $newhostname
    green "修改完成，请重新连接ssh或重新启动服务器!"
}

function hijk(){
    bash <(curl -sL https://raw.githubusercontent.com/Misaka-blog/hijk-backup/master/xray.sh)
}

function updateScript(){
    wget -N https://raw.githubusercontent.com/Misaka-blog/MisakaLinuxToolbox/master/MisakaToolbox.sh && chmod -R 777 MisakaToolbox.sh && bash MisakaToolbox.sh
}

function tgMTProxy(){
    mkdir /home/mtproxy && cd /home/mtproxy
    curl -s -o mtproxy.sh https://raw.githubusercontent.com/sunpma/mtp/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh
    bash mtproxy.sh start
}

function start_menu(){
    clear
    red "============================"
    red "                            "
    red "    Misaka Linux Toolbox    "
    echo "                            "
    red "  https://blog.misaka.rest  "
    echo "                            "
    red "============================"
    echo "                            "
    green "检测到您当前运行的工具箱版本是：$ver"
    green "更新日志：$changeLog"
    echo "                            "
    yellow "检测到VPS信息如下"
    yellow "处理器架构：$arch"
    yellow "虚拟化架构：$virt"
    yellow "操作系统：$release"
    yellow "内核版本：$kernelVer"
    echo "                            "
    echo "下面是我们提供的一些功能"
    echo "1. VPS修改登录方式为root密码登录"
    echo "2. VPS安装warp"
    echo "3. X-ui面板安装"
    echo "4. Mack-a 节点配置脚本"
    echo "5. 一键开启BBR"
    echo "6. 安装宝塔开心版"
    echo "7. 一键安装docker"
    echo "8. 流媒体解锁测试"
    echo "9. VPS三网测速"
    echo "10. 修改主机名"
    echo "11. 安装可乐大佬的ServerStatus-Horatu探针"
    echo "12. hijk大佬的v2脚本，支持IBM LinuxONE s390x的机器搭建节点"
    echo "13. 一键安装 Telegram MTProxy 代理服务器"
    echo "v. 更新脚本"
    echo "0. 退出脚本"
    echo "                            "
    read -p "请输入选项:" menuNumberInput
    case "$menuNumberInput" in     
        1 ) rootLogin;;
        2 ) warp;;
        3 ) xui ;;
        4 ) macka ;;
        5 ) bbr ;;
        6 ) bthappy ;;
        7 ) docker ;;
        8 ) mediaUnblockTest ;;
        9 ) vpsSpeedTest ;;
        10 ) changehostname ;;
        11 ) serverstatus ;;
        12 ) hijk ;; 
        13 ) tgMTProxy ;;
        v ) updateScript ;;
        0 ) exit 0;;
    esac
}

start_menu
