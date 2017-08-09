#!/bin/bash

##########
# CONFIG #
##########

INTERNAL_LINKS=`lynx --dump --listonly http://$1| grep -E "(http|https)://($1|www.$1)"`
#INTERNAL_LINKS=`lynx --dump --listonly http://$1| grep -E "http://$1|http://www.$1|https://$1|https://www.$1"| grep -v "*htt*"`
#EXTERNAL_LINKS=`lynx --dump --listonly http://$1| grep -v "http://'$1'"| grep -v "https://'$1'"| grep -v "http://www.'$1'"| grep -v "https://www.'$1'"`
#EXTERNAL_LINKS=`lynx --dump --listonly http://$1| grep -v "http://$1"| grep -v "https://$1"| grep -v "http://www.$1"| grep -v "https://www.$1"`
EXTERNAL_LINKS=`lynx --dump --listonly http://$1| grep -v -E "(http|https)://($1|www.$1|*.$1|www.*.$1)"`
#EXTERNAL_LINKS=`lynx --dump --listonly http://$1| grep -v "http://$1|http://www.$1|https://$1|https://www.$1|http://*.$1|http://www.*.$1|https://*.$1|https://www.*.$1"| grep -v "*htt*"`
SUBDOMAIN_LINKS=`lynx --dump --listonly http://$1 | grep -E -v 'http://www.$1' |grep -E "http://*.$1|http://www.*.$1|https://*.$1|https://www.*.$1"| grep -v "*htt*"`


##############
# THE SCRIPT #
##############
# check $1
if [[ -z "$1" ]]; then
  echo "1st cond"
  echo "Please use \"links_counter.sh host.domain\" syntax"
  exit 1

# check URL
elif echo $1 |grep 'http://' 2>&1 ; then
  echo "2st cond"
  echo "Do not enter 'http://'"
  exit 1 

# check curl status 
else  curl http://$1 > /dev/null 2>&1 
  res=$?
  echo "3d cond"
  if [[ "$res" != "0" ]]; then
    echo "The curl command failed with: $res \n Is this URL avalible? \n Please enter URL w"
    exit 1

  else
    echo "For URL" $1 
#    echo "Number of internal links is:" $INTERNAL_LINKS
#    echo  $INTERNAL_LINKS
    echo "Number of external links is:" $EXTERNAL_LINKS
#    echo  $EXTERNAL_LINKS
#    echo "Number of links for subdomains:" $SUBDOMAIN_LINKS
#    echo  $SUBDOMAIN_LINKS
  fi
fi

