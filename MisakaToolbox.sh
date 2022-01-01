#!/bin/bash

# 一些全局变量
ver="2.0.1"
changeLog="新增一些VPS测试脚本"
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

function oraclefirewall(){
    if [ $release = "Centos" ]; then
        systemctl stop oracle-cloud-agent
        systemctl disable oracle-cloud-agent
        systemctl stop oracle-cloud-agent-updater
        systemctl disable oracle-cloud-agent-updater
        systemctl stop firewalld.service
        systemctl disable firewalld.service
    else
        iptables -P INPUT ACCEPT
        iptables -P FORWARD ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -F
        apt-get purge netfilter-persistent -y
    fi
}

#第一页

function rootLogin(){
    wget -N https://cdn.jsdelivr.net/gh/Misaka-blog/rootLogin@master/root.sh && chmod -R 777 root.sh && bash root.sh
}

function screenManager(){
    wget -N https://cdn.jsdelivr.net/gh/Misaka-blog/screenManager@master/screen.sh && chmod -R 777 screen.sh && bash screen.sh
}

function bbr(){
    if [ ${virt} == "kvm" ]; then
        wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
    fi
    if [[ ${virt} == "lxc" || ${virt} == "openvz" ]]; then
        if [[ ${TUN} == "cat: /dev/net/tun: File descriptor in bad state" ]]; then
            green "已开启TUN，准备安装针对OpenVZ / LXC架构的BBR"
            wget --no-cache -O lkl-haproxy.sh https://github.com/mzz2017/lkl-haproxy/raw/master/lkl-haproxy.sh && bash lkl-haproxy.sh
        else
            red "未开启TUN，请在VPS后台设置以开启TUN"
            exit 1
        fi
    fi
}

function warp(){
    wget -N https://cdn.jsdelivr.net/gh/fscarmen/warp/menu.sh && bash menu.sh
}

function docker(){
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
}

# 第二页

function bt(){
    echo "                   "
    green "请选择你需要安装的版本"
    echo "                            "
    echo "1. 开心版"
    echo "2. 国际版"
    echo "                            "
    read -p "请输入选项:" btNumberInput
    case "$btNumberInput" in     
        1 ) btHappy;;
        2 ) 
            if [ $release = "Centos" ]; then
                yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh forum
            elif [ $release = "Debian" ]; then
                wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && bash install.sh forum
            else
                wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh forum
            fi
        ;;
        0 ) menu;;
    esac
}

function btHappy(){
    echo "                   "
    green "请选择你需要安装的版本"
    echo "                   "
    echo "1. 专业版"
    echo "2. 企业版"
    echo "0. 返回主页"
    echo "                            "
    read -p "请输入选项:" btHappyNumberInput
    case "$btHappyNumberInput" in     
        1 ) 
            if [ $release = "Centos" ]; then
                yum install -y wget && wget -O install.sh http://download.moetas.com/ltd/install/install_6.0.sh && sh install.sh
            elif [ $release = "Debian" ]; then
                wget -O install.sh http://download.moetas.com/ltd/install/install-ubuntu_6.0.sh && bash install.sh
            else
                wget -O install.sh http://download.moetas.com/ltd/install/install-ubuntu_6.0.sh && sudo bash install.sh
            fi
        ;;
        2 ) 
            if [ $release = "Centos" ]; then
                yum install -y wget && wget -O install.sh http://download.moetas.com/install/install_6.0.sh && sh install.sh
            elif [ $release = "Debian" ]; then
                wget -O install.sh http://download.moetas.com/install/install-ubuntu_6.0.sh && bash install.sh
            else
                wget -O install.sh http://download.moetas.com/install/install-ubuntu_6.0.sh && sudo bash install.sh
            fi
        ;;
        0 ) menu;;
    esac
}

function xui(){
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
}

function aria2(){
    if ! type ca-certificates >/dev/null 2>&1; then 
        yellow "ca-certificates未安装，安装中"
        if [ $release = "Centos" ]; then
            yum -y update && yum install ca-certificates -y
        else
            apt-get update -y && apt-get install ca-certificates -y
        fi	   
    else
        green "ca-certificates已安装"
    fi
    wget -N git.io/aria2.sh && chmod +x aria2.sh && bash aria2.sh
}

# 第三页

function macka(){
    wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh && /root/install.sh
}

function boy233(){
    bash <(curl -s -L https://git.io/v2ray.sh)
}

function hijk(){
    bash <(curl -sL https://raw.githubusercontent.com/Misaka-blog/hijk-backup/master/xray.sh)
}

function tgMTProxy(){
    mkdir /home/mtproxy && cd /home/mtproxy
    curl -s -o mtproxy.sh https://raw.githubusercontent.com/sunpma/mtp/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh
    bash mtproxy.sh start
}

# 第四页

function vpsBench(){
    echo "                            "
    green "请选择你接下来使用的脚本"
    echo "                            "
    echo "1. 使用bench.sh"
    echo "2. 使用superbench"
    echo "3. 使用lemonbench"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page3NumberInput
    case "$page3NumberInput" in
        1 ) wget -qO- bench.sh | bash ;;
        2 ) wget -qO- --no-check-certificate https://raw.githubusercontent.com/oooldking/script/master/superbench.sh | bash ;;
        3 ) curl -fsL https://ilemonra.in/LemonBenchIntl | bash -s fast ;;
        0 ) menu
    esac
}

function mediaUnblockTest(){
    bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
}

function speedTest(){
    bash <(curl -Lso- https://git.io/superspeed)
}

function updateScript(){
    wget -N https://raw.githubusercontent.com/Misaka-blog/MisakaLinuxToolbox/master/MisakaToolbox.sh && chmod -R 777 MisakaToolbox.sh && bash MisakaToolbox.sh
}

# 第五页

function nezha(){
    curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh  -o nezha.sh && chmod +x nezha.sh
    sudo ./nezha.sh
}

function serverstatus(){
    wget -N https://raw.githubusercontent.com/cokemine/ServerStatus-Hotaru/master/status.sh
    echo "                            "
    green "请选择你需要安装的客户端类型"
    echo "                            "
    echo "1. 服务端"
    echo "2. 监控端"
    echo "0. 返回主页"
    echo "                            "
    read -p "请输入选项:" menuNumberInput1
    case "$menuNumberInput1" in     
        1 ) bash status.sh s ;;
        2 ) bash status.sh c ;;
        0 ) menu;;
    esac
}

function menu(){
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
    green "下面是脚本分类，请选择对应的分类后进入到相对应的菜单中"
    echo "                            "
    echo "1. 系统相关"
    echo "2. 面板相关"
    echo "3. 节点相关"
    echo "4. VPS测试"
    echo "5. VPS探针"
    echo "                            "
    echo "9. 更新脚本"
    echo "0. 退出脚本"
    echo "                            "
    read -p "请输入选项:" menuNumberInput
    case "$menuNumberInput" in
        1 ) page1 ;;
        2 ) page2 ;;
        3 ) page3 ;;
        4 ) page4 ;;
        5 ) page5 ;;
        9 ) updateScript ;;
        0 ) exit 0
    esac
}

function page1(){
    echo "                            "
    green "请选择你接下来的操作"
    echo "                            "
    echo "1. Oracle 原生系统关闭防火墙"
    echo "2. 修改登录方式为 root + 密码 登录"
    echo "3. Screen 后台任务管理"
    echo "4. 开启BBR"
    echo "5. 启用WARP"
    echo "6. 安装docker"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page1NumberInput
    case "$page1NumberInput" in
        1 ) oraclefirewall ;;
        2 ) rootLogin ;;
        3 ) screenManager ;;
        4 ) bbr ;;
        5 ) warp ;;
        6 ) docker ;;
        0 ) menu
    esac
}

function page2(){
    echo "                            "
    green "请选择你准备安装的面板"
    echo "                            "
    echo "1. 安装宝塔面板"
    echo "2. 安装x-ui面板"
    echo "3. 安装aria2面板"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page2NumberInput
    case "$page2NumberInput" in
        1 ) bt ;;
        2 ) x-ui ;;
        3 ) aria2 ;;
        0 ) menu
    esac
}

function page3(){
    echo "                            "
    green "请选择你接下来使用的脚本"
    echo "                            "
    echo "1. 使用Mack-a的脚本"
    echo "2. 使用233boy的脚本"
    echo "3. 使用hijk的脚本"
    echo "4. 搭建Telegram MTProxy代理"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page3NumberInput
    case "$page3NumberInput" in
        1 ) macka ;;
        2 ) boy233 ;;
        3 ) hijk ;;
        4 ) tgMTProxy ;;
        0 ) menu
    esac
}

function page4(){
    echo "                            "
    green "请选择你接下来的操作"
    echo "                            "
    echo "1. VPS测试"
    echo "2. 流媒体检测"
    echo "3. VPS三网测速"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page4NumberInput
    case "$page4NumberInput" in
        1 ) vpsBench ;;
        2 ) mediaUnblockTest ;;
        3 ) speedTest ;;
        0 ) menu
    esac
}

function page5(){
    echo "                            "
    green "请选择你需要的探针"
    echo "                            "
    echo "1. 哪吒面板"
    echo "2. 可乐ServerStatus-Horatu"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page5NumberInput
    case "$page5NumberInput" in
        1 ) nezha ;;
        2 ) serverstatus ;;
        0 ) menu
    esac
}

menu
