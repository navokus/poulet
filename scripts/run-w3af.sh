#!/bin/bash

#------------------------------------------------------------#
# Description: A script scans a website and returns          #
#  vulnerabilities using the open source w3af                # 
# Input: web adresse or web IP                               #
# Output: detected vulnerabilily files in csv or json format #
# Date: 22-25/09/2016                                        #
# Verion: 1.0.0                                              #
# Authors: DAO Van Toan                                      #
#------------------------------------------------------------#

WORKING_PATH="/home/myproj" 
W3="$WORKING_PATH/w3af"
SCRIPT_PATH="$WORKING_PATH/W3afConf.w3af"

# Return hostname of server from configuration file of w3af
old_name=$(grep "set target" $SCRIPT_PATH | cut -d' ' -f3)

# Run w3af with an input script of configure
w3af() {
   # Check NULL input
   if [[ -z $1 ]] then
      echo "Input Webname or IP"
   fi

   # Get input from keyboard
   sed -i 's/'$old_name'/'$1'/g' $SCRIPT_PATH 

   # Run w3af with a file input
   $W3/w3af_console -s $SCRIPT_PATH 
}

# Reformalue output file 
format_csv() {
   # Insert a text at the beginning of a file
   sed -i '1s/^/severity,vuln_name,method,link_req,token,link_err,res_id,descrip/' $W3/W3afReport.csv

   # Remove " bare in text
   sed -i 's/"//g' $W3/W3afReport.csv

   # Remove : character in text
   sed -i 's/://g' $W3/W3afReport.csv
}


w3af $1
format_csv
