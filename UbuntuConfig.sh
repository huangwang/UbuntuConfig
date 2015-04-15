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
clamscan -r /
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
npm install -g yo



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
chmod a+w ./drupal/site/default
cp ./drupal/site/default/default.settings.php ./drupal/site/default/settings.php 
chmod a+w settings.php
#create drupal database in phpmyadmin, this is important!

#Install git and its gui
apt-get install git
apt-get install gitk

#The method of using git
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
#export JAVA_HOME=/opt/jdk1.8.0_31
#export JRE_HOME=${JAVA_HOME}/jre
#export JAVA_CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib 
#export PATH=${JAVA_HOME}/bin:/opt/sublime_text_3:$PATH

#Solve command can not found when sudo command
#visudo will edit /etc/sudoers, add the command path to secure_path
#In visudo command mode, press the key of esc, and then press the X key to leave
visudo

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

#Install wine
apt-get install wine
#put FoxitReader.exe to .wine/drive_c/Windows folder, and then use wine to run it
wine FoxitReader.exe

#Install chm reader
apt-get install xchm

#Install dictionary
apt-get install stardict
#Go to http://abloz.com/huzheng/stardict-dic/zh_CN/ for downloading dictionary
#put the dictionary to 	/usr/share/stardict/dic and then uncompress them

#Install wireshark
apt-get instlal wireshark
#Set non-root user to capture packet
groupadd wireshark 
chgrp wireshark /usr/bin/dumpcap 
chmod 4755 /usr/bin/dumpcap 
gpasswd ­-a useraccount wireshark

#Install tor
add-apt-repository ppa:webupd8team/tor-browser
apt-get update
apt-get install tor-browser

#Install rar
apt-get install rar unrar

#Install note software
apt-get install basket

#list the ubuntu service
ls /etc/init.d/
service --status-all

#Install tool for listing and edit service
apt-get install sysv-rc-conf

#Install RSS reader
apt-get install liferea

#Install curl, which is a command line tool and library for transferring data with URL syntax
apt-get install curl

#Install traceroute, which is a tool of print the route packets trace to network host
apt-get install traceroute

#To find the public IP of my host
curl ifconfig.me

#list pci or usb device
lspci
lsusb

#auto remove packets of no use
apt-get autoremove

#edit /etc/fstab for auto mount ntfs filesytem
vi /etc/fstab

#Install google earth
sudo apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0
apt-get install -f
dpkg -i google-earth-stable_current_amd64.deb

#Query users and groups
cat /etc/passwd
cat /etc/group

#Command for auto update drupal-7
sudo chown -R daemon:daemon ./drupal/sites

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