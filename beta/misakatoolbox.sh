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
    green "VPS的防火墙端口已放行！"
}

bbr_script(){
    virt=$(systemd-detect-virt)
    TUN=$(cat /dev/net/tun 2>&1 | tr '[:upper:]' '[:lower:]')
    if [ ${virt} =~ "kvm"|"zvm"|"microsoft"|"xen"|"vmware" ]; then
        wget -N --no-check-certificate "https://raw.githubusercontents.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
    elif [ ${virt} == "openvz" ]; then
        if [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ '处于错误状态' ]] && [[ ! $TUN =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
            wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/tun-script/master/tun.sh && bash tun.sh
        else
            wget -N --no-check-certificate https://raw.githubusercontents.com/mzz2017/lkl-haproxy/master/lkl-haproxy.sh && bash lkl-haproxy.sh
        fi
    else
        red "抱歉，你的VPS虚拟化架构暂时不支持bbr加速脚本"
    fi
}

v6_dns64(){
    wg-quick down wgcf 2>/dev/null
    v66=`curl -s6m8 https://ip.gs -k`
    v44=`curl -s4m8 https://ip.gs -k`
    if [[ -z $v44 && -n $v66 ]]; then
        echo -e "nameserver 2a01:4f8:c2c:123f::1" > /etc/resolv.conf
        green "设置DNS64服务器成功！"
    else
        red "非纯IPv6 VPS，设置DNS64服务器失败！"
    fi
    wg-quick up wgcf 2>/dev/null
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
        2) wget -N https://raw.githubusercontents.com/fscarmen/warp/main/menu.sh && bash menu.sh ;;
        3) wget -N https://raw.githubusercontents.com/fscarmen/warp/main/docker.sh && bash docker.sh ;;
        4) bash <(curl -sSL https://raw.githubusercontents.com/fscarmen/warp_unlock/main/unlock.sh) ;;
        5) bash <(curl -fsSL https://raw.githubusercontents.com/P3TERX/warp.sh/main/warp.sh) menu ;;
        0) menu ;;
    esac
}

setChinese(){
    chattr -i /etc/locale.gen
    cat > '/etc/locale.gen' << EOF
zh_CN.UTF-8 UTF-8
zh_TW.UTF-8 UTF-8
en_US.UTF-8 UTF-8
ja_JP.UTF-8 UTF-8
EOF
    locale-gen
    update-locale
    chattr -i /etc/default/locale
    cat > '/etc/default/locale' << EOF
LANGUAGE="zh_CN.UTF-8"
LANG="zh_CN.UTF-8"
LC_ALL="zh_CN.UTF-8"
EOF
    export LANGUAGE="zh_CN.UTF-8"
    export LANG="zh_CN.UTF-8"
    export LC_ALL="zh_CN.UTF-8"
}

menu(){
    clear
    echo "#############################################################"
    echo -e "#                 ${RED}Misaka Linux Toolbox${PLAIN}                     #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo -e "# ${GREEN}GitHub${PLAIN}: https://github.com/Misaka-blog                    #"
    echo -e "# ${GREEN}Bitbucket${PLAIN}: https://bitbucket.org/misakano7545             #"
    echo -e "# ${GREEN}GitLab${PLAIN}: https://gitlab.com/misaka-blog                    #"
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
    read -rp " 请输入选项 [0-9]:" menuInput
    case $menuInput in
        1) menu1 ;;
        2) menu2 ;;
        3) menu3 ;;
        4) menu4 ;;
        5) menu5 ;;
        *) exit 1 ;;
    esac
}

menu1(){
    clear
    echo "#############################################################"
    echo -e "#                 ${RED}Misaka Linux Toolbox${PLAIN}                     #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo -e "# ${GREEN}GitHub${PLAIN}: https://github.com/Misaka-blog                    #"
    echo -e "# ${GREEN}Bitbucket${PLAIN}: https://bitbucket.org/misakano7545             #"
    echo -e "# ${GREEN}GitLab${PLAIN}: https://gitlab.com/misaka-blog                    #"
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
    echo " -------------"
    echo -e " ${GREEN}0.${PLAIN} 返回主菜单"
    echo ""
    read -rp " 请输入选项 [0-13]:" menuInput
    case $menuInput in
        1) open_ports ;;
        2) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/rootLogin/master/root.sh && bash root.sh ;;
        3) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/screenManager/master/screen.sh && bash screen.sh ;;
        4) bbr_script ;;
        5) v6_dns64 ;;
        6) warp_script ;;
        7) curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun ;;
        8) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/acme-1key/master/acme1key.sh && bash acme1key.sh ;;
        9) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/argo-tunnel-script/master/argo.sh && bash argo.sh ;;
        10) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/Ngrok-1key/master/ngrok.sh && bash ngrok.sh ;;
        11) bash <(curl -sSL https://cdn.jsdelivr.net/gh/SuperManito/LinuxMirrors@main/ChangeMirrors.sh) ;;
        12) setChinese ;;
        13) wget -N --no-check-certificate https://raw.githubusercontents.com/Misaka-blog/tun-script/master/tun.sh && bash tun.sh ;;
        *) exit 1 ;;
    esac
}

menu2(){
    clear
    echo "#############################################################"
    echo -e "#                 ${RED}Misaka Linux Toolbox${PLAIN}                     #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo -e "# ${GREEN}GitHub${PLAIN}: https://github.com/Misaka-blog                    #"
    echo -e "# ${GREEN}Bitbucket${PLAIN}: https://bitbucket.org/misakano7545             #"
    echo -e "# ${GREEN}GitLab${PLAIN}: https://gitlab.com/misaka-blog                    #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} aapanel面板"
    echo -e " ${GREEN}2.${PLAIN} x-ui面板"
    echo -e " ${GREEN}3.${PLAIN} aria2(面板为远程链接)"
    echo -e " ${GREEN}4.${PLAIN} CyberPanel面板"
    echo -e " ${GREEN}5.${PLAIN} 青龙面板"
    echo -e " ${GREEN}6.${PLAIN} Trojan面板"
    echo " -------------"
    echo -e " ${GREEN}0.${PLAIN} 返回主菜单"
    echo ""
    read -rp " 请输入选项 [0-6]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu3(){
    clear
    echo "#############################################################"
    echo -e "#                 ${RED}Misaka Linux Toolbox${PLAIN}                     #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo -e "# ${GREEN}GitHub${PLAIN}: https://github.com/Misaka-blog                    #"
    echo -e "# ${GREEN}Bitbucket${PLAIN}: https://bitbucket.org/misakano7545             #"
    echo -e "# ${GREEN}GitLab${PLAIN}: https://gitlab.com/misaka-blog                    #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} mack-a"
    echo -e " ${GREEN}2.${PLAIN} wulabing v2ray"
    echo -e " ${GREEN}3.${PLAIN} wulabing xray"
    echo -e " ${GREEN}4.${PLAIN} misaka xray"
    echo -e " ${GREEN}5.${PLAIN} teddysun shadowsocks"
    echo -e " ${GREEN}6.${PLAIN} telegram mtproxy"
    echo " -------------"
    echo -e " ${GREEN}0.${PLAIN} 返回主菜单"
    echo ""
    read -rp " 请输入选项 [0-6]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu4(){
    clear
    echo "#############################################################"
    echo -e "#                 ${RED}Misaka Linux Toolbox${PLAIN}                     #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo -e "# ${GREEN}GitHub${PLAIN}: https://github.com/Misaka-blog                    #"
    echo -e "# ${GREEN}Bitbucket${PLAIN}: https://bitbucket.org/misakano7545             #"
    echo -e "# ${GREEN}GitLab${PLAIN}: https://gitlab.com/misaka-blog                    #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} VPS测试 (misakabench)"
    echo -e " ${GREEN}2.${PLAIN} VPS测试 (bench.sh)"
    echo -e " ${GREEN}3.${PLAIN} VPS测试 (superbench)"
    echo -e " ${GREEN}4.${PLAIN} VPS测试 (lemonbench)"
    echo -e " ${GREEN}5.${PLAIN} VPS测试 (融合怪全测)"
    echo -e " ${GREEN}6.${PLAIN} 流媒体检测"
    echo -e " ${GREEN}7.${PLAIN} 三网测速"
    echo ""
    read -rp " 请输入选项 [0-7]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu5(){
    clear
    echo "#############################################################"
    echo -e "#                 ${RED}Misaka Linux Toolbox${PLAIN}                     #"
    echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
    echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
    echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
    echo -e "# ${GREEN}GitHub${PLAIN}: https://github.com/Misaka-blog                    #"
    echo -e "# ${GREEN}Bitbucket${PLAIN}: https://bitbucket.org/misakano7545             #"
    echo -e "# ${GREEN}GitLab${PLAIN}: https://gitlab.com/misaka-blog                    #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} 哪吒面板"
    echo -e " ${GREEN}2.${PLAIN} 可乐ServerStatus-Horatu"
    echo " -------------"
    echo -e " ${GREEN}0.${PLAIN} 返回主菜单"
    echo ""
    read -rp " 请输入选项 [0-2]:" menuInput
    case $menuInput in
        *) exit 1 ;;
    esac
}

menu
