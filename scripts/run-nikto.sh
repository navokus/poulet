#!/bin/bash

#------------------------------------------------------------#
# Description: A script scans a website and returns          #
#  vulnerabilities using 2 open sources nikto and w3af       # 
# Input: web adresse or web IP                               #
# Output: detected vulnerabilily files in csv or json format #
# Date: 22-25/09/2016                                        #
# Verion: 1.0.0                                              #
# Authors: DANG Xuan Bach, DAO Van Toan                      #
#------------------------------------------------------------#

#!!! IL FAUT MODIFIER LE CORE SOURCE CODE DE NIKTO POUR AVOIR BIEN LE RESULTAT DE SCANNER
# Nikto scan 


#Domains and IP address of our services
MYHOST="myweb.com sub1.myweb.com sub2.myweb.com" ;
MYIP="118.22.247.0" ;

WORKING_PATH="/home/lion/Desktop/Hackathon"
NiktoFormat="JSON" 
NiktoLOG="$WORKING_PATH/nikto"
NiktoExec="$WORKING_PATH/nikto/program/nikto.pl" 

_SSL_FLAG="-nossl";
_URL="";
_DEFAUT_PROTOCOL="http://" ;
_DOMAIN="google.com";

#List user-agent
getUserAgent(){
	agent="$1";
	if [ "$agent" = "apple" ]; then
		apple="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36";
		return apple;			
	fi
	if [ "$agent" = "firefox" ]; then
		firefox="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1";
		return firefox;
	fi
	
	def_useragent="Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36";
	return $def_useragent;
}

compare_str(){
	if [[ "$1" == "$2" ]]; then 
		return 0;
	else
		return 1;
	fi
}

#prevent leak server information
prevent_leak_info(){
	#Verify information
	#1. Verify your domain name
	#Not support scan Myhost
	for str in "$MYHOST"
	do
		if [ "$domain" == "$str" ]; then
			return 1;
		fi
	done
	#2. Verify Host IP with your IP address
	if grep -qi $MYIP $TEXTFILE
	then
		rm $LOGFILE;
		rm $TEXTFILE;
		return 1
	fi
}

#Only check http and https
#No support scan myhost
check_domain() {
	protocol=`echo $1 | cut -d':' -f1 |  tr '[:upper:]' '[:lower:]'` ;
	domain=`echo $1 | cut -d'/' -f3 |  tr '[:upper:]' '[:lower:]'` ;
	_URL="$protocol://$domain";
	_DOMAIN="$domain";
	LOGFILE="WORKING_PATH/$_DOMAIN.$NiktoFormat";
	TEXTFILE="WORKING_PATH/$_DOMAIN.txt";
	
	compare_str "$protocol" "https" ;
	if [ "$?" == 0 ]; then 
		_SSL_FLAG="-ssl";		
		return 0;
	else
		compare_str "$protocol" "http" ;
		if [ "$?" == 0 ]; then		
			_SSL_FLAG="-nossl";
			return 0;
		else
			return 1;
		fi
	fi

	#Not support scan Myhost
	for str in "$MYHOST"
	do
		if [ "$domain" == "$str" ]; then
			return 0;
		fi
	done
	return 1; #Not support scan this domain
}

nikto(){
	rm -rf $LOGFILE;
	perl $NiktoExec -host $_URL $_SSL_FLAG -output $LOGFILE > $TEXTFILE;
	remove_espze $LOGFILE;
	# prevent_leak_info ;
}

remove_espze(){
	#Fix error json output of nikto_origin
	for i in 1 2 3 4 5 6
	do
		#find ./ -name "$1" -exec sed -i 's/\"id\": 0/\"id\": /g' {} +
		sed -i -- 's/\"id\": 0/\"id\": /g' "$1" ;
		sed -i -- 's/\"id\":0/\"id\": /g' "$1" ;
	done
	sed -i -- 's/}, ],/}]/g' "$1" ;
	sed -i -- 's/},],/}]/g' "$1" ;
}

#./run.sh [host]
if [  "$#" -ne 1 ]; then
	echo "./run.sh [host]" >&2;
	exit 1;
else	
	check_domain $1;
	if [ $? = 0 ]; then 	
		nikto $_URL;
	else
		echo "Can't detect the protocol!";
	fi
fi
