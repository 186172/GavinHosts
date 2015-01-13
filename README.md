# GavinHosts

## 简介

本项目旨在让从未接触过路由自动翻墙的你，5分钟轻松简单的搞定路由自动翻墙，并且一次部署后，从此每日自动更新以适应GFW的封锁变化。

让路由器自动翻墙被越来越多的人所期望，方法也多种多样，本项目所使用的方法为：利用路由器的DNSMasq功能，指定一份自动更新的Hosts列表，让路由下的所有设备都能访问到正确的网站IP，避免被墙。

## Hosts内容

支持出墙的网站：

* Google 家族（包括 YouTube，Gmail，Google+，Google Drive 等）Youtube可能有些地区无法播放视频
* OneDrive
* Wikipedia
* Facebook
* Twitter
* Flickr
* Dropbox

Hosts内容由Gavin更新维护。

## 开始部署

以下教程以DD-WRT路由为例：

### 一、获取最新Hosts文件

路由器先启用jffs2，SSH或Telnet连接到路由，执行：

> mkdir /jffs/hosts/ && cd /jffs/hosts/ && wget http://hosts.gav1n.com/start.sh && sh start.sh

稍等片刻，执行成功后得到Hosts文件，保存在 `/jffs/hosts/GavinHosts.txt`

[选做](#) _没有jffs空间的路由，请先完成以下两步后再执行上面的命令：_

* 执行命令：

> mkdir /tmp/jffs

* 在管理-命令 处，输入：

> mount

保存为启动指令，重启路由。

### 二、为DNSMasq指定Hosts文件

在路由管理界面“服务-服务”处：

启用DNSMasq，并在 DNSMasq附加选项 填入：

> addn-hosts=/jffs/hosts/GavinHosts.txt

### 三、定时更新

在路由管理界面“管理-管理”处：

启用Cron

附加任务 输入：

> 59 2 \* \* \* root sh /jffs/hosts/start.sh

这样就实现了每天凌晨2点59分获取最新的Hosts文件。数字59和2代表时间，请改成任意时间，以免太多用户在同一时间访问造成服务器拥堵。

至此，已完成，重启路由！

**（由于大部分路由器上的wget不支持https协议，而Github又仅限https协议发布文件，故使用了支持http协议的镜像网址。）**
