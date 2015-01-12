# GavinHosts

## 简介
一个能让DD-WRT或OpenWRT路由出墙的东东，利用DNSMasq指定Hosts原理，以访问到正确的IP地址，避免被墙。

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

# 开始部署

以下教程以DD-WRT路由为例：

## 一、获取最新Hosts文件
路由器先启用jffs2，SSH或Telnet连接到路由，执行：
```sh
mkdir /jffs/hosts/ && cd /jffs/hosts/ && wget http://hosts.gav1n.com/start.sh && sh start.sh
```
稍等片刻，执行成功后得到Hosts文件，保存在 </b>/jffs/hosts/GavinHosts.txt</b>

<b>[选做] 没有jffs空间的路由</b>，请先完成以下两步重启路由后再执行上面的命令：

* 执行命令：
```
mkdir /tmp/jffs
```
* 在管理-命令 处，输入：
```
mount --bind /tmp/jffs /jffs
```
保存为启动指令。

## 二、为DNSMasq指定Hosts文件
在路由管理界面“服务-服务”处：

启用DNSMasq，并在 DNSMasq附加选项 填入：
```
addn-hosts=/jffs/hosts/GavinHosts.txt
```
## 三、定时更新
在路由管理界面“管理-管理”处：
启用Cron

附加任务 输入：
```
59 2 * * * root sh /jffs/hosts/start.sh
```
这样就实现了每天凌晨2点59分获取最新的Hosts文件。数字0和3代表时间，请改成任意时间，以免太多用户在同一时间访问造成服务器拥堵。

至此，已完成，重启路由！

<i>（由于大部分路由器上的wget不支持https协议，而Github又仅限https协议发布文件，故使用了支持http协议的镜像网址。）</i>
