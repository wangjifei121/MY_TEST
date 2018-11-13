今日内容：

vim用法
详细请看博客：谢谢！
https://www.cnblogs.com/pyyu/p/9460649.html


Linux命令命令：

1.如果你电脑上没有 ifconfig
只有 ip  addr 
yum install net-tools  -y  

启动/关闭一块网卡
ifup eth0
ifdown eth0

此命令其实是调用网络服务配置文件
/etc/init.d/network  start
/etc/init.d/network  stop 
/etc/init.d/network  restart 
---
如果关闭网卡，xshell会怎样?


#查看系统版本信息
cat /etc/redhat-release 
CentOS Linux release 7.4.1708 (Core) 
#查看内核版本号
uname -r
3.10.0-693.el7.x86_64
#查看系统多少位
uname -m
x86_64
#查看内核所有信息
uname -a

#更改主机名
hostnamectl set-hostname s12_linux

linux用户篇

root为超级用户，uid为0，通过id命令查看
id root 
id xiaofeng

普通用户创建
useradd xiaofeng 
更改用户密码
passwd root 
passwd xiaofeng 
通过普通用户登录
ssh xiaofeng@10.0.0.10

切换用户
su命令可以切换用户身份的需求，
su - username

su命令中间的-号很重要，意味着完全切换到新的用户，即环境变量信息也变更为新用户的信息

/etc/passwd  用户账号信息
/etc/shadow  存放用户密码
/etc/group  存放用户组

userdel删除用户
-f     强制删除用户
-r    同事删除用户以及家目录
userdel -r pyyu 


文件，文件夹的权限
通过 ls -l  /tmp/* 去查看文件 文件夹所有权限
drwx------. 2 root root       6 Nov  8 19:05 vmware-root
-rw-r--r--. 1 root root 1977763 Nov  8 22:17 xiaobo.gif

解读权限：
文件，文件夹的用户分类
分为三种，   user(属主)  group（属组）   other（外包，其他人  ）

-  			 rw-            r--           r--
文件类型     属主的权限     属组的权限     other（外包）的权限

对于普通文本权限来说，
- 是普通文本
r 读取
w   写入 
x  执行

对于文件夹来说
d  文件夹类型
r    可以对此目录执行ls列出所有文件
w    可以在这个目录创建文件
x    可以cd进入这个目录，或者查看详细信息

文件权限的  r  w  x  对于数字的转化，转化为8进制的数字

r   4  
w   2 
x   1



文件权限练习：
提示：
r w x   rwx  rwx  
4 2 1


7  0  0
rwx  ---   ---

7   4     4
rwx r--   r--

777
rwxrwxrwx

7  5  5
rwxr-xr-x

666
rw-rw-rw-



5 5 5 
r-x    r-x    r-x
4+0+1  4+0+1  4+0+1

更改用户属主
语法
chown  用户名  file
更改用户属组
chgrp  组名  file


软连接配置
ln -s 目标文件  软连接名
ln -s /tmp/xiaofeng.txt   /home/xf.txt


Linux的PS1变量
用于控制命令提示符
[root@s12_linux bin]#PS1='[\u@\h \W]\$'
但是！你这个操作，重启丢失
怎么办呢？写入到系统的配置文件，每次登陆都加载
写入到/etc/profile这个用户配置文件里
vim /etc/profile  #打开文件，到最底行，写入变量赋值
PS1='[\u@\h \w \t]\$'


tar解压缩命令
tar -zxvf Python-3.7.0b3.tgz #解压

tar -czvf oldboy.txt.tar.gz oldboy.txt #压缩oldboy.txt  
上述命令等于 tar -cvf oldboy.tar oldboy.txt
　　　　　　  gzip oldboy.tar

tar -cf all_pic.tar *.jpg #压缩当前目录所有jpg结尾的文件

tar -xjf xx.tar.bz2　　#解压缩bz2结尾的文件

#查看网络端口的命令
netstat -tunlp
#过滤3306端口
netstat -tunlp | grep 3306


#启动一个应用程序
crm来说
	8000端口
		netstat -tunlp|grep 8000
	python进程
		ps -ef|grep  python 
		ps -ef|grep mysql
		ps -ef|grep nginx
		ps -ef|grep redis

kill命令
杀死进程的命令
	1.通过ps -ef找到你想杀死的进程
		然后观察pid号
		用户名    pid                                     进程执行命令
		root      33588  22560  0 13:55 pts/0    00:00:00 vim pwd.txt
	2.通过kill命令杀死pid
		kill 33588
	3.如果遇见杀不死的恶心进程
		-9 是发给kill命令的一个信号，强制杀死信号
		kill -9 33588

killall命令
一次性杀死多个有依赖的进程
比如nginx会启动多个nginx的子进程

如果是这样的多个进程，使用kill杀死就比较麻烦，通过killall指令

killall nginx  一次性杀死nginx的所有进程

root      6878  22560  0 13:55 pts/0    00:00:00 nginx 
root      6834  22560  0 13:55 pts/0    00:00:00 nginx
root      6823  22560  0 13:55 pts/0    00:00:00 nginx
root      6234  22560  0 13:55 pts/0    00:00:00 nginx


man帮助手册
	用于查询linux命令的详细文档
man ls 
man kill 



防火墙的作用：
	防止服务器被恶意攻击，保护系统资源
	例如恶意攻击你的端口，你的进程等等

防火墙就是定义类一对规则，控制什么ip能访问，什么ip禁止访问
定义了当前服务器允许什么端口可以访问，什么端口禁止访问

防火墙控制外界“因素” 进入和出去！！ 就理解为是小区那个保安(门卫)

selinux
linux内置防火墙

iptables
linux软件防火墙

firewalld
linux软件防火墙

可能大家还会遇见硬件防火墙


关闭selinux
1.通过修改配置文件，然后重启机器，可以永久关闭selinux防火墙
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

2.临时关闭selinux，不需要重启机器，重启后失效
	1.先获取selinux状态
	getenforce
	2.临时关闭selinux
	setenforce 0

关闭iptables
1.查看iptables规则
iptables -L
2.清空iptables规则
iptables -F
3.关闭iptables服务
systemctl stop firewalld

复制代码
centos7默认已经使用firewall作为防火墙了
1.关闭防火墙
systemctl status firewalld #查看防火墙状态
systemctl stop firewalld    #关闭防火墙
systemctl disable firewalld#关闭防火墙开机启动
systemctl is-enabled firewalld.service#检查防火墙是否启动


linux中文设置：
1.查看linux当前的字符集
echo $LANG
2.永久生效，更改字符集，写入配置文件
vim /etc/locale.conf
LANG="zh_CN.UTF-8"
3.使得配置文件生效
source /etc/locale.conf
4.保证客户端软件编码和linux一致
xshell  utf8 
centos utf8


查看磁盘使用量
df -h  

以树装图显示文档目录结构
tree 


DNS介绍  
一般来说dns服务器是通过bind这个软件搭建的

域名解析系统
DNS1=119.29.29.29
cat /etc/resolv.conf
#dns服务器地址
nameserver 119.29.29.29
nameserver 223.5.5.5

还可以通过nslookup解析域名
nslookup pythonav.cn


hosts文件介绍
强制dns记录解析，常用于开发测试用，自定义域名
linux下指定本地解析：
/etc/hosts
主机IP    主机名    主机别名
127.0.0.1        www.pyyuc.cn   

linux的计划任务crontab
语法格式：

*  		*　		 *　		 *		　 *　　	command
1,2    *   *  *  *  command 
1-5  *  *  *  *  command 

分钟(0-59)　小时(0-23)　日期(1-31)　月份(1-12)　星期(0-6,0代表星期天)　 命令

星号（*）：代表所有可能的值，例如month字段如果是星号，则表示在满足其它字段的制约条件后每月都执行该命令操作。
逗号（,）：可以用逗号隔开的值指定一个列表范围，例如，“1,2,5,7,8,9”
中杠（-）：可以用整数之间的中杠表示一个整数范围，例如“2-6”表示“2,3,4,5,6”
正斜线（/）：可以用正斜线指定时间的间隔频率，例如“0-23/2”表示每两小时执行一次。同时正斜线可以和星号一起使用，例如*/10，如果用在minute字段，表示每十分钟执行一次。




#每分钟执行一次命令
* * * * * 命令

#每小时的3,15分组执行命令
3,15 * * * * 命令


#在上午8-11点的第3和第15分钟执行
*   *     *    *  *  
3,15    8-11    * *  *  命令


3,15 8-11 * * * 命令


#每晚21:30执行命令

*    *    *  *  *  
30   21   *   *  *  



30 21 * * * 命令


#没周六、日的下午1：30执行命令

30  13   *   *  6,0  command  



#每周一到周五的凌晨1点，清空/tmp目录的所有文件

0   1   *   *  1-5  /usr/bin/rm  -rf /tmp/*      必须用绝对路径

      


#每晚的21:30重启nginx


30 21 * * * /opt/nginx/sbin/nginx -s reload


#每月的1,10,22日的4:45重启nginx
*   *   *   *   * 
分  时     日     月   周 
 
45   4   1,10,22   *    *   /opt/nginx/sbin/nginx -s reload




#每个星期一的上午8点到11点的第3和15分钟执行命令


*       *      *   *   * 
分     时       日     月   周 

3,15   8-11   *     *   1    command  


3,15 8-11 * * 1 command

咱们练习这个crontab规则，写入到crontab文件中
通过命令 crontab -e 打开文件




软件包管理部分
1.rpm命令管理，需要手动处理依赖关系  mysql-5.6.rpm  
	安装软件的命令格式                rpm -ivh filename.rpm     # i表示安装   v显示详细过程  h以进度条显示
	升级软件的命令格式                rpm -Uvh filename.rpm
	卸载软件的命令格式                rpm -e filename.rpm
	查询软件描述信息的命令格式         rpm -qpi filename.rpm
	列出软件文件信息的命令格式         rpm -qpl filename.rpm
	查询文件属于哪个 RPM 的命令格式 　 rpm -qf filename

安装小的软件，可以选择rpm安装
实例
1.下载rpm包
wget https://rpmfind.net/linux/centos/7.5.1804/os/x86_64/Packages/lrzsz-0.12.20-36.el7.x86_64.rpm
2. 安装rpm包
[root@s12_linux opt]#rpm  -ivh lrzsz-0.12.20-36.el7.x86_64.rpm 
准备中...                          ################################# [100%]
	软件包 lrzsz-0.12.20-36.el7.x86_64 已经安装

	
	
	
2.通过yum自动安装软件，自动处理依赖关系  ，这个非常方便！！！
yum安装软件，其实就是在线搜索一个rpm包，然后自动帮你rpm -ivh 包.rpm 
yum install mysql 
yum install mysql 

yum源的配置
1.知道yum源的老家在哪？
	cd /etc/yum.repos.d/
	ls  看一下有哪些yum源文件
	所有以  *.repo 结尾的就是yum源文件
	
2.我们要更改linux的yum源为aliyun的yum源仓库
	1.找到阿里巴巴的yum网站
	https://opsx.alibaba.com/mirror 
	2.找到 centos标签，点击  “帮助”
	3.找到centos7相关
	找到以下命令
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	4.在linux上执行命令，下载阿里巴巴的yum源文件
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	5.清空原本yum的缓存
	yum clean all
	6.安装linux的额外仓库源，也就是epel源,继续在阿里云源上找，找到epel那个标签，点击后发现
	wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
	7.安装epel源，在linux上输入命令
	wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
	8.生成yum的缓存，便于之后加速下载
	yum makecache


3.下载mysql源码，编译安装



yum使用，安装redis，得配置好epel源

系统服务管理命令  
1.在centos7底下才有systemctl
2.如果你公司是centos6
	那只有service命令
	例如  service  network    start/restart/stop 



1.  yum install redis -y   #安装redis
2.  这里请注意！！！  只有通过 yum安装的软件，才可以使用systemctl 命令去管理
3.启动redis服务
systemctl start redis   启动
systemctl restart redis   重启 
systemctl stop redis    停止
systemctl status redis   看状态



今日博客：
https://www.cnblogs.com/pyyu/articles/9355477.html 










