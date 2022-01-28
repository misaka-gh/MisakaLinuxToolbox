# 御坂妹妹们的Linux VPS工具箱

为了方便妹妹们更好的管理他们的服务器，姐姐大人为您们写好了一系列管理脚本了

虽然目前我给你们一键管理的功能并不多，但是我有时间还是给你们准备的啦！

![image.png](https://s2.loli.net/2021/12/26/WkiwbdExvnGAXCh.png)

## 使用方法

```shell
wget -N https://cdn.jsdelivr.net/gh/Misaka-blog/MisakaLinuxToolbox@master/MisakaToolbox.sh && chmod -R 777 MisakaToolbox.sh && bash MisakaToolbox.sh
```

快捷方式 `bash MisakaToolbox.sh`

## 赞助我们

![afdian-MisakaNo.jpg](https://s2.loli.net/2021/12/25/SimocqwhVg89NQJ.jpg)

## 交流群
[Telegram](https://t.me/misakanetcn)

## 来自姐姐大人的更新日志

Ver 2.0.8 增加青龙面板，修复纯净Debian系统获取不到VPS IP地址的问题

Ver 2.0.7 增加脚本运行次数统计，fscarmen的warp docker版脚本

Ver 2.0.6 增加DD系统选项（选项仅在KVM VPS显示）

Ver 2.0.5 添加不同作者的WARP脚本，给予用户更多选择。增加德鸡DiG9网络解决方案

Ver 2.0.4 增加安装ShadowSocks脚本，BBR支持IBM LinuxONE

Ver 2.0.3.1 解决修复OpenVZ的BBR，TUN模块判断问题

Ver 2.0.3 优化系统判断机制，增加本博客的Acme.sh证书申请脚本

Ver 2.0.2 删除宝塔开心版脚本，优化BBR判断规则

Ver 2.0.1 新增一些VPS测试脚本

Ver 2.0 重构脚本，详细内容可看Github项目的思维导图

Ver 1.4.5 新增禁用Oracle系统自带防火墙、Acme.sh和Screen后台任务管理脚本

Ver 1.4.4 在主菜单提示VPS信息，并新增部署Telegram MTProxy脚本

Ver 1.4.3 更新hijk大佬的v2脚本，支持IBM LinuxONE s390x的机器搭建节点

Ver 1.4.2 更新脚本，修复jsdelivr无法解析问题

Ver 1.4.1 关于加了探针却没加到菜单的一个小bug的修复

Ver 1.4: 添加修改主机名，以及修改一些小问题

Ver 1.3: 添加可乐的ServerStatus-Horatu探针管理及客户端

Ver 1.2: 添加流媒体检测，三网测速脚本

Ver 1.1: 添加BBR及宝塔开心版、Docker安装脚本

## 感谢列表

感谢他们的贡献，让脚本得到进一步完善

BBR(KVM)：https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed

BBR(OpenVZ)：https://github.com/mzz2017/lkl-haproxy/

WARP脚本：https://github.com/fscarmen/warp

宝塔国际版（aapanel）：https://www.aapanel.com/

X-ui: https://github.com/vaxilu/x-ui

Aria2: https://github.com/P3TERX/aria2.sh

CyberPanel：https://cyberpanel.net/

Mack-a：https://github.com/mack-a/v2ray-agent

233boy：https://github.com/233boy/v2ray/wiki/V2Ray%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85%E8%84%9A%E6%9C%AC

hijk：https://github.com/hijkpw/scripts

ShadowSocks: https://github.com/teddysun/shadowsocks_install/tree/master

bench.sh https://bench.sh

superbench https://github.com/oooldking/script

lemonbench https://blog.ilemonrain.com/linux/LemonBench.html

流媒体检测：https://github.com/lmc999/RegionRestrictionCheck

三网测速：https://github.com/ernisn/superspeed/

哪吒面板：https://github.com/naiba/nezha

可乐 ServerStartus-Horatu：https://github.com/cokemine/ServerStatus-Hotaru

DD系统：https://www.cxthhhhh.com/network-reinstall-system-modify

青龙面板：https://github.com/whyour/qinglong
