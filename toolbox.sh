#!/bin/bash

# 一些全局变量
ver="1.0"

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
red "不支持你当前系统，请使用Ubuntu,Debian,Centos系统"
rm -f root.sh
exit 1
fi

if ! type curl >/dev/null 2>&1; then 
yellow "检测到curl未安装，安装中 "
if [ $release = "Centos" ]; then
yum -y update && yum install curl -y
else
apt-get update -y && apt-get install curl -y
fi	   
else
green "curl已安装"
fi

if ! type wget >/dev/null 2>&1; then 
yellow "检测到wget未安装，安装中 "
if [ $release = "Centos" ]; then
yum -y update && yum install wget -y
else
apt-get update -y && apt-get install wget -y
fi	   
else
green "wget已安装"
fi

if ! type sudo >/dev/null 2>&1; then 
yellow "检测到sudo未安装，安装中 "
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
    echo "                            "
    echo "1. VPS修改登录方式为root密码登录"
    echo "2. VPS安装warp"
    echo "3. X-ui面板安装"
    echo "4. Mack-a 节点配置脚本"
    echo "0. 退出脚本"
    echo "                            "
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in     
        1 ) rootLogin;;
        2 ) warp;;
        3 ) xui ;;
        4 ) macka ;;
        0 ) exit 0;;
    esac
}

start_menu
