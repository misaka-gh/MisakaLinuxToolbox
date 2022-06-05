#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN="\033[0m"

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

open_ports(){
    systemctl stop firewalld.service 2>/dev/null
    systemctl disable firewalld.service 2>/dev/null
    setenforce 0 2>/dev/null
    ufw disable 2>/dev/null
    iptables -P INPUT ACCEPT 2>/dev/null
    iptables -P FORWARD ACCEPT 2>/dev/null
    iptables -P OUTPUT ACCEPT 2>/dev/null
    iptables -t nat -F 2>/dev/null
    iptables -t mangle -F 2>/dev/null
    iptables -F 2>/dev/null
    iptables -X 2>/dev/null
    netfilter-persistent save 2>/dev/null
}

warp_script(){
    green "请选择你接下来使用的脚本"
    echo "1. Misaka-WARP"
    echo "2. fscarmen"
    echo "3. fscarmen-docker"
    echo "4. fscarmen warp解锁奈飞流媒体脚本"
    echo "5. P3TERX"
    echo "0. 返回主菜单"
    echo ""
    read -p "请输入选项:" warpNumberInput
	case $warpNumberInput in
        1) wget -N https://raw.githubusercontents.com/Misaka-blog/Misaka-WARP-Script/master/misakawarp.sh && bash misakawarp.sh ;;
        2) wget -N https://cdn.jsdelivr.net/gh/fscarmen/warp/menu.sh && bash menu.sh ;;
        3) wget -N https://cdn.jsdelivr.net/gh/fscarmen/warp/docker.sh && bash docker.sh ;;
        4) bash <(curl -sSL https://raw.githubusercontent.com/fscarmen/warp_unlock/main/unlock.sh) ;;
        5) bash <(curl -fsSL git.io/warp.sh) ;;
        0) menu ;;
    esac
}

menu(){
    clear
    echo "#############################################################"
    echo -e "#                ${RED}Misaka Linux Toolbox${PLAIN}                      #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} 系统相关"
    echo -e " ${GREEN}2.${PLAIN} 面板相关"
    echo -e " ${GREEN}3.${PLAIN} 节点相关"
    echo -e " ${GREEN}4.${PLAIN} 性能测试"
    echo -e " ${GREEN}5.${PLAIN} VPS探针"
    echo " -------------"
    echo -e " ${GREEN}9.${PLAIN} 更新脚本"
    echo -e " ${GREEN}0.${PLAIN} 退出脚本"
    echo ""
    read -rp " 请输入选项 [0-14]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu1(){
    clear
    echo "#############################################################"
    echo -e "#                ${RED}Misaka Linux Toolbox${PLAIN}                      #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} 开放系统防火墙端口"
    echo -e " ${GREEN}2.${PLAIN} 修改登录方式为 root + 密码"
    echo -e " ${GREEN}3.${PLAIN} Screen 后台任务管理"
    echo -e " ${GREEN}4.${PLAIN} BBR加速系列脚本"
    echo -e " ${GREEN}5.${PLAIN} 纯IPv6 VPS设置DNS64服务器"
    echo -e " ${GREEN}6.${PLAIN} 设置CloudFlare WARP"
    echo -e " ${GREEN}7.${PLAIN} 下载并安装Docker"
    echo -e " ${GREEN}8.${PLAIN} Acme.sh 证书申请"
    echo -e " ${GREEN}9.${PLAIN} CF Argo Tunnel隧道穿透"
    echo -e " ${GREEN}10.${PLAIN} Ngrok 内网穿透"
    echo -e " ${GREEN}11.${PLAIN} 修改Linux系统软件源"
    echo -e " ${GREEN}12.${PLAIN} 切换系统语言为中文"
    echo -e " ${GREEN}13.${PLAIN} OpenVZ VPS启用TUN模块"
    echo ""
    read -rp " 请输入选项 [0-14]:" menuInput
    case $menuInput in
        1) open_ports ;;
        2) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/rootLogin/master/root.sh && bash root.sh ;;
        3) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/screenManager/master/screen.sh && bash screen.sh ;;
        *) exit 1 ;;
    esac
}

menu2(){
    clear
    echo "#############################################################"
    echo -e "#                ${RED}Misaka Linux Toolbox${PLAIN}                      #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} aapanel面板"
    echo -e " ${GREEN}2.${PLAIN} x-ui面板"
    echo -e " ${GREEN}3.${PLAIN} aria2(面板为远程链接)"
    echo -e " ${GREEN}4.${PLAIN} CyberPanel面板"
    echo -e " ${GREEN}5.${PLAIN} 青龙面板"
    echo -e " ${GREEN}6.${PLAIN} Trojan面板"
    echo ""
    read -rp " 请输入选项 [0-14]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu3(){
    clear
    echo "#############################################################"
    echo -e "#                ${RED}Misaka Linux Toolbox${PLAIN}                      #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} mack-a"
    echo -e " ${GREEN}2.${PLAIN} wulabing v2ray"
    echo -e " ${GREEN}3.${PLAIN} wulabing xray"
    echo -e " ${GREEN}4.${PLAIN} misaka xray"
    echo -e " ${GREEN}5.${PLAIN} teddysun shadowsocks"
    echo -e " ${GREEN}6.${PLAIN} telegram mtproxy"
    echo ""
    read -rp " 请输入选项 [0-14]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu4(){
    clear
    echo "#############################################################"
    echo -e "#                ${RED}Misaka Linux Toolbox${PLAIN}                      #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} VPS测试 (misakabench)"
    echo -e " ${GREEN}2.${PLAIN} 流媒体检测"
    echo -e " ${GREEN}3.${PLAIN} 三网测速"
    echo ""
    read -rp " 请输入选项 [0-14]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu5(){
    clear
    echo "#############################################################"
    echo -e "#                ${RED}Misaka Linux Toolbox${PLAIN}                      #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} 哪吒面板"
    echo -e " ${GREEN}2.${PLAIN} 可乐ServerStatus-Horat"
    echo ""
    read -rp " 请输入选项 [0-14]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu
