#!/bin/bash

##############
# THE SCRIPT #
##############
# check $1
if [[ -z "$1" ]]; then
  echo "Please use \"links_counter.sh host.domain\" syntax"
  exit 1

# check URL
elif echo $1 |grep 'http://' 2>&1 ; then
  echo "Do not enter 'http://'"
  exit 1 

# check curl status 
else  
  CURL_STATUS=`curl -Is http://$1 | head -n 1 | awk -F" " '{print $2}'` #curl http://$1 #> /dev/null 2>&1 
  if [[ "$CURL_STATUS" -ge 400 ]]; then
    echo "The curl command failed with status: $CURL_STATUS \n Is this URL avalible?"
    exit 1
  else
    lynx -pauth='a.prososov:!Qq112345' --dump --listonly http://$1 > /tmp/links_counter.tmp
    echo "For URL" $1 
    echo "Number of internal links is:" `cat /tmp/links_counter.tmp| grep -o "http.*"| grep -E "(/$1/|www.$1/)"| wc -l`
    echo "Number of external links is:" `cat /tmp/links_counter.tmp| grep -o "http.*"| grep -v "$1/"| wc -l`
    echo "Number of links for subdomains:" `cat /tmp/links_counter.tmp|grep -o "http.*"| grep "\.$1/"| grep -v "www.$1/"| wc -l`
# Total: cat /tmp/links_counter.tmp |grep -o "http.*"| wc -l 
  fi
fi

