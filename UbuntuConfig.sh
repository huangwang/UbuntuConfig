#!/bin/sh
#The script is used for initially configure after ubuntu-gnome 14.04 installed.
#This script cannot run directly, which needs modification.

#Uninstall unity
apt-get -y --auto-remove purge unity
apt-get -y --auto-remove purge unity-lens*
apt-get -y --auto-remove purge unity-services
apt-get -y --auto-remove purge unity-asset-pool

#Uninstall libreOffice
apt-get -y purge libreoffice*

#Install gnome
apt-get -y install gnome
#Install Gnome3 Extension, Visit https://extensions.gnome.org/

#Upgrade system
apt-get upgrade

#Install wireless card driver
apt-get install linux-headers-generic build-essential git
git clone https://github.com/lwfinger/rtlwifi_new.git
cd rtlwifi_new/rtl8723be/
make
make install
modprobe rtl8723be
lsmod | grep rtl8723be

#Prevents the WiFi card from automatically sleeping and halting connection
echo "options rtl8723be fwlps=0 swlps=0" > /etc/modprobe.d/rtl8723be.conf
reboot

#Install linux kernel header file for compiling program
apt-get install linux-headers-$(uname -r)

#Install anti-virus software
apt-get install clamav
freshclam
clamscan -r  --bell -i  / -l /tmp/clamav.log
#Install the GUI of clamav
#apt-get install clamtk

#Solve the problem that TTY can not display chinese character
apt-get -y install fbterm
fbterm

#Convert ubuntu load mode from graphic to text
sed -i '11s/text/quiet\ splash/g' /etc/default/grub
sed -i '11s/quiet\ splash/text/g' /etc/default/grub
update-grub

#Install lamp
chmod +x bitnami-lampstack-5.4.36-0-linux-x64-installer.run
./bitnami-lampstack-5.4.36-0-linux-x64-installer.run
#edit apache httpd.conf for solving the problem of apache bind to ipv6, not the ipv4
#Listen 0.0.0.0:80

#Install lamp environment
apt-get -y install lamp-server^
#Open the browser and visit the http://localhost to verify apache server is working or not.
#And then execute the follow command,visit the http://localhost/phpinfo.php to verify php is working or not.
echo "<?php phpinfo(); ?>" | tee /var/www/phpinfo.php
service apache2 restart
#Solve apache domain problem
echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn
service apache2 reload 
cat /etc/hosts | grep localhost
cat /etc/mysql/my.cnf | grep bind-address
#Install phpmyadmin, and visit http://localhost/phpmyadmin to verify.
apt-get -y install libapache2-mod-auth-mysql phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/html

#Install node.js
apt-get -y install nodejs
apt-get -y install npm
nodejs -v
npm -v

#Install the front tool, that is yeoman
npm install -g yo bower  grunt



#Install docker
apt-get -y install docker.io
#Link and fix path
ln -sf /usr/bin/docker.io /usr/local/bin/docker
sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
#Let docker service auto start
update-rc.d docker.io defaults
#Download a Docker Container
docker pull ubuntu
#Start ubuntu container
docker run -i -t ubuntu /bin/bash
docker search debian

#Install sublime3
cp sublime_text_3_build_3065_x64.tar.bz2 /opt
tar -jzxf sublime_text_3_build_3065_x64
rm sublime_text_3_build_3065_x64.tar.gz
#add the location of sublime3 to the $PATH environment viariblity
#edit gloably in /etc/profile, gedit /etc/profile, export PATH=$PATH:/opt/sublime_text_3

#create soft link for sublime3
#ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime

#Install greatagent
unzip ga_linux-master.zip
apt-get install python-vte
apt-get install python-gevent
python goagent-gtk.py
python addto-startup.py
reboot

#Install chrome
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -f

#Install drupal
cp drupal-7.28.tar.gz /var/www/
cd /var/www/
tar -xzvf drupal-7.28.tar.gz
rm drupal-7.28.tar.gz
mv drupal-7.28/ drupal/
chmod a+w ./drupal/sites/default
cp ./drupal/sites/default/default.settings.php ./drupal/site/default/settings.php 
chmod a+w settings.php
#create drupal database in phpmyadmin, this is important!
#
#Command for auto update drupal-7
sudo chown -R daemon:daemon ./drupal/sites

#Install git and its gui
apt-get install git
apt-get install gitk

#The method of using git
git init
git status
git add targetFile
git commit -m "some explain"
git push


#Install 32bit java
cp jdk-7u51-linux-i586.tar.gz /opt
tar -xvzf jdk-7u51-linux-i586.tar.gz
rm jdk-7u51-linux-i586.tar.gz
#to support 32bit program
apt-get install ia32-libs
#set JAVA_HOME,JAVA_CLASSPATH,PATH for java program in /etc/envrionment
export JAVA_HOME=/opt/jdk1.8.0_31
export JRE_HOME=${JAVA_HOME}/jre
export JAVA_CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib 
export PATH=${JAVA_HOME}/bin:/opt/sublime_text_3:$PATH

#Solve command can not found when sudo command
#visudo will edit /etc/sudoers, add the command path to secure_path
#In visudo command mode, press the key of esc, and then press the X key to leave
visudo

#add user to sudo group
usermod -a -G sudo username1

#Install uGet downloader and aria2 plugin
apt-get install uget aria2

#Install mldonkey for downloading em2k protocol file
apt-get install mldonkey-server
apt-get install mldonkey-gui

#Install the client of Baidu cloud
dpkg -i bcloud_3.6.1-1_all.deb
apt-get -f install

#Install flash plugin for firefox browser
apt-get install flashplugin-nonfree

#Install video player 
apt-get install smplayer VLC

#Install sougou language input method
dpkg -i sogou_pinyin_linux_1.1.0.0037_amd64.deb
#Uninstall sougou language input method
dpkg  -l  so*
dpkg  -r    sogoupinyin
apt-­get purge  fcitx*

#Install google pinyin input method
apt-get install ibus-googlepinyin

#Install wps office 
apt-get install -f
dpkg -i wps-office_8.1.0.3724~b1p2_i386.deb

#list the ubuntu service
ls /etc/init.d/
service --status-all

#Install tool for listing and edit service
apt-get install sysv-rc-conf

#To find the public IP of my host
curl ifconfig.me/all
curl icanhazip.com
curl curlmyip.com
curl ip.appspot.com
curl ipinfo.io/ip
curl ipecho.net/plain
curl www.trackip.net/i

#list pci or usb device
lspci
lsusb

#auto remove packets of no use
apt-get autoremove

#edit /etc/fstab for auto mount ntfs filesytem
vi /etc/fstab

#Install wine
apt-get install wine
#put FoxitReader.exe to .wine/drive_c/Windows folder, and then use wine to run it
wine FoxitReader.exe

#Install chm reader
apt-get install xchm

#Install notebook
apt-get install rednotebook 

#Install wireshark
apt-get install wireshark
#Set non-root user to capture packet
groupadd wireshark 
chgrp wireshark /usr/bin/dumpcap 
chmod 4755 /usr/bin/dumpcap 
gpasswd ­-a useraccount wireshark

#Go to http://abloz.com/huzheng/stardict-dic/zh_CN/ for downloading dictionary
#put the dictionary to 	/usr/share/stardict/dic and then uncompress them
#Install dictionary
#两款翻译软件
apt-get install stardict goldendict

#Install RSS reader
apt-get install liferea

#Install curl, which is a command line tool and library for transferring data with URL syntax
apt-get install curl

#Install traceroute, which is a tool of print the route packets trace to network host
apt-get install traceroute

#Install tor
apt-get install tor
service tor start
proxychains iceweasel

#Install rar
apt-get install rar unrar

#Install note software
apt-get install basket

#software used in linux
apt-get install anki xmind freemind 

#Install google earth
cd /tmp
wget http://ftp.us.debian.org/debian/pool/main/l/lsb/lsb-security_4.1+Debian13+nmu1_amd64.deb
sudo dpkg -i lsb-security_4.1+Debian13+nmu1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/l/lsb/lsb-invalid-mta_4.1+Debian13+nmu1_all.deb
sudo dpkg -i lsb-invalid-mta_4.1+Debian13+nmu1_all.deb
wget http://ftp.us.debian.org/debian/pool/main/l/lsb/lsb-core_4.1+Debian13+nmu1_amd64.deb
sudo dpkg -i lsb-core_4.1+Debian13+nmu1_amd64.deb
apt-get install -f
dpkg -i google-earth-stable_current_amd64.deb

#Query users and groups
cat /etc/passwd
cat /etc/group

#Enable FTP on your server
sudo  apt-get  install  vsftpd
sudo apt-get purge vsftpd

#Analyse file format
file java

#tar  command help
tar -czf all.tar.gz *.jpg 
tar -xzf all.tar.gz 

#Install fcitx input method
sudo apt-get install fcitx-table-wbpy
#添加源&安装fcitx
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get install fcitx fcitx-config-gtk fcitx-googlepinyin fcitx-module-cloudpinyin  fcitx-sogoupinyin  im-switch
#切换到fcitx输入法
sudo im-switch -s fcitx -z default

#iptables firewall
iptables -L -n | grep 80
#shutdown iptables firewall
iptables -P INPUT ACCEPT   
iptables -P OUTPUT ACCEPT 

#系统
uname -a               # 查看内核/操作系统/CPU信息
head -n 1 /etc/issue   # 查看操作系统版本 
cat /proc/cpuinfo      # 查看CPU信息
hostname               # 查看计算机名 
lspci -tv              # 列出所有PCI设备
lsusb -tv              # 列出所有USB设备 
lsmod                  # 列出加载的内核模块
env                    # 查看环境变量

#资源
free -m                # 查看内存使用量和交换区使用量 
df -h                  # 查看各分区使用情况 
du -sh <目录名>        # 查看指定目录的大小 
grep MemTotal /proc/meminfo   # 查看内存总量
grep MemFree /proc/meminfo    # 查看空闲内存量
uptime                 # 查看系统运行时间、用户数、负载 
cat /proc/loadavg      # 查看系统负载

#磁盘和分区
mount | column -t      # 查看挂接的分区状态 
mount /dev/sda1 /mnt        ### 将 sda1 挂载到 /mnt 中
umount /mnt                 ### 卸载 /mnt 这个挂载点的文件系统
fdisk -l               # 查看所有分区 
swapon -s              # 查看所有交换分区
hdparm -i /dev/hda     # 查看磁盘参数(仅适用于IDE设备)  
dmesg | grep IDE       # 查看启动时IDE设备检测状况

#网络
ifconfig               # 查看所有网络接口的属性
iptables -L            # 查看防火墙设置 
route -n               # 查看路由表 
netstat -lntp          # 查看所有监听端口 
netstat -antp          # 查看所有已经建立的连接
netstat -s             # 查看网络统计信息

#进程
ps -ef                 # 查看所有进程 
top                    # 实时显示进程状态
用户 w                      # 查看活动用户 
id <用户名>            # 查看指定用户信息  
last                   # 查看用户登录日志  
cut -d: -f1 /etc/passwd   # 查看系统所有用户  
cut -d: -f1 /etc/group    # 查看系统所有组  
crontab -l             # 查看当前用户的计划任务

#Command
tar -cvf filename.tar .       ### 将当前目录所有文件归档，但不压缩，注意后面有个 ’.‘ ，不可省略，代表当前目录的意思 
tar -xvf filename.tar         ### 解压 filename.tar 到当前文件夹
useradd -m -d /home/newuser -g users -G sudo -s /bin/bash newuser     ### -m 创建 home 目录， -g 所属的主组， -G 指定该用户在哪些附加组， -s 设定默认的 shell ，newuser 为新的用户名
usermod -a -G groupA user #将一个用户添加到用户组中
whereis bash  #whereis 用于查找文件、手册等。
find . -name PATTERN    ### 从当前目录查找符合 PATTERN 的文件
find . -iname PATTERN    ### 从当前目录查找符合 PATTERN 的文件,但是不区分大小写
wget -O newname.md https://github.com/LCTT/TranslateProject/blob/master/README.md     ### 下载 README 文件并重命名为 newname.md
wget -c url     ### 下载 url 并开启断点续传

#服务
chkconfig --list       # 列出所有系统服务  
chkconfig --list | grep on    # 列出所有启动的系统服务

#程序
rpm -qa                # 查看所有安装的软件包

#the audit tool
lynis -c -Q

#maintain symbolic links determining default command
update-alternatives --display java 
update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_31/bin/java 1072  

#display pci device
lspci | grep -i vga

#manage wireless device
rfkill block list

#Clone Iso image to mobile device
dd if=kali.Iso of=/dev/sdb bs=512k

#Make ISO file from  cdrom
dd if=/dev/cdrom of=./Win7.iso

#part storage device
gparted /dev/sdb

#dump traffic on a network
tcpdump -i  wlan0

#Install and remove System-V style init script links
# make service start or remove with system boot
update-rc.d postgresql enable

#Make a bootable USB device with Linux OS
dd if=kali.iso of=/dev/sdb bs=512k
#Add Persistence function for USB device
gparted /dev/sdb

#在 Bash Unix 或者 Linux shell 中逐行读取一个文件的语法
while IFS= read -r line; do COMMAND_on $line; done < input.file

#Git鼓励大量使用分支：
#查看分支：
git branch
#创建分支：
git branch <name>
#切换分支：
git checkout <name>
#创建+切换分支：
git checkout -b <name>
#合并某分支到当前分支，删除分支后，分支信息将丢失：
git merge <name>
#合并某分支到当前分支，并保留分支信息
git merge --no-ff -m "merge with no-ff" dev
#删除分支：
git branch -d <name>
#解决冲突
git log --graph
#Git还提供了一个stash功能，可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作：
git stash
git stash apply
git stash drop
git stash pop
git stash list
git stash apply stash@{0}
#要查看远程库的信息
git remote -v
#创建远程origin的dev分支到本地
git checkout -b dev origin/dev
#推送本地origin的dev分支到远程
git push orgin dev
#在Git v1.7.0 之后，可以使用这种语法删除远程分支：
git push origin --delete <branchName>

#因此，多人协作的工作模式通常是这样：
#1. 首先，可以试图用git push origin branch-name推送自己的修改；
#2. 如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并；
#3. 如果合并有冲突，则解决冲突，并在本地提交；
#4. 没有冲突或者解决掉冲突后，再用git push origin branch-name推送就能成功！
#5. 如果git pull提示“no tracking information”，则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream branch-name origin/branch-name。
#这就是多人协作的工作模式，一旦熟悉了，就非常简单。

#在Git中打标签非常简单，首先，切换到需要打标签的分支上：
#然后，敲命令git tag <name>就可以打一个新标签：
git tag v1.0

#find file
updatedb 
locate filename
find -name france1.jpg
find /var/log syslog
find / -name syslog
find /var -size +10M
find -name *.jpg -atime -7
find /var/log -name mysql -type d
find -name *.jpg -print
find -name *.jpg -delete

#adjust the color temperature of my screen
redshift -l 25:100  &

#learning music theory
apt-get install lenmus

#kernel会将开机信息存储在ring buffer中。您若是开机时来不及查看信息，可利用dmesg来查看。开机信息亦保存在/var/log目录中，名称为dmesg的文件里。
#终端输入dmesg，可以看到每行最开始显示的是一个综括号，里面的数字为timestamp，时间戳，该时间指示的系统从开机到现在的运行时间，单位为s 秒。
dmesg
#以当前时间的方式显示时间信息，而不是图1所示的开机时间
dmesg -T
#显示dmesg中两条打印信息的时间间隔
dmesg -d

#Verify md5sum
 md5sum -c  md5.txt 

#Run 32 bit program in 64 bit linux
dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install ia32-libs

#Install the excellent terminator
apt-get install terminator

#decompress a lot of files
for tar in *.tar.gz; do tar xvf $tar; done

#monitor tools
apt-get install htop iftop nethogs 

#backup and resume linux system
tar cvpzf backup.tgz --exclude=/proc --exclude=/lost+found --exclude=/backup.tgz --exclude=/mnt --exclude=/sys --exclude=/media /
tar xvpfz backup.tgz -C /

#Install Torrent Download software
apt-get install transmission

#To see every process on the system using standard syntax
ps -ef

#Invert the sense of matching, to select non-matching  lines
grep -v grep

#Say we have a text file containing the following.
#	bob 23 45 hello
#	jim 12 88 bye
#If we cat the file and do the awk print $2 thing, we get the following out.
#	23
#	12
#简单来说awk就是把文件逐行的读入，以空格为默认分隔符将每行切片，切开的部分再进行各种分析处理。
#awk '{pattern + action}' {filenames}
awk `{print $2}` $fileName

#find java process and kill it
kill -9 $(ps -ef | grep java | grep -v grep | awk '{print $2}')

#Find the inode information for file
stat example.txt

#Find the size of inode
sudo dumpe2fs -h /dev/hda | grep "Inode size"

#Find the inode of the file
ls -i example.txt

#Rename multi-files
rename 's/bartik/blog/' *.yml

#virtualBox manage
VBoxManage list vms

#md5校验
md5sum file > file.md5sum
md5sum -c file.md5sum

#查看内存条和内存槽信息
dmidecode | grep -A16 "Memory Device$"

#远程桌面访问
rdesktop 192.168.56.102

#
dpkg --add-architecture i386

#允许chrome访问本地文件
google-chrome --allow-file-access-from-files

#安装中文字体即可，推荐文泉驿字体
apt-get install ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy

#去掉文件或目录的执行权限
sudo chmod a-x -R *

#给文件目录所有者增加执行权限
sudo chmod u+X -R *

#调用密码库 charset.lst，生成8位密码；其中元素为 密码库 charset.lst中 mixalpha-numeric-all-space的项；
#格式为“两个小写字母+dog+三个小写字母”，并以cbdogaaa开始枚举（@代表小写字母）
crunch 8 8 -f charset.lst mixalpha-numeric-all-space -o wordlist.txt -t @@dog @@@ -s cbdogaaa

#crunch将生成以“dog”“cat”“bird”为元素的所有密码组合：
#birdcatdog，birddogcat，catbirddog,   catdogbird,  dogbirdcat, dogcatbird
crunch 4 5 -p dog cat bird

#生成4位密码，其中格式为“两个数字”+“一个小写字母”+“常见符号”（其中数字这里被指定只能为123组成的所有2位数字组合）。
#比如12f#      32j^    13t$    ......
crunch 4 4  + + 123 + -t %%@^

#生成3位密码，其中第一位由“a，b，c”中的一个；第二位为“1,2,3”中的一个；第三位为“！，@，#”中的一个。比如1a！   2a#      3b@ 	
# @代表小写字母
# ,代表大写字母    
# %代表数字
# ^代表符号
crunch 3 3 abc + 123 @#! -t @%^

#查询公网IP
echo $(wget -qO - https://api.ipify.org)
echo $(curl -s https://api.ipify.org)