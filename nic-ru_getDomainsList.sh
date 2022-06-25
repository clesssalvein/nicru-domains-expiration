#!/bin/bash


# VARS

apiBaseUrl="https://api.nic.ru"
OauthUrl="https://api.nic.ru/oauth/token"

#nicruAccountUser="1498232/NIC-D"
#nicruAccountPass="PASSWORD"
#nicruAppLogin="8eadca8b3e6fd0f34fa974e001f37814"
#nicruAppPass="PASSWORD"

nicruAccountUser=$1
nicruAccountPass=$2
nicruAppLogin=$3
nicruAppPass=$4


# GET TOKEN

token=`curl -s --location --request POST "${OauthUrl}" \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=password' \
--data-urlencode "password=${nicruAccountPass}" \
--data-urlencode "client_id=${nicruAppLogin}" \
--data-urlencode "client_secret=${nicruAppPass}" \
--data-urlencode "username=${nicruAccountUser}" \
--data-urlencode 'scope=.*' \
| jq -r ".access_token"`

# debug
#echo ${token}

response=`curl -s --location --request GET "${apiBaseUrl}/dns-master/zones?token=${token}"`

# debug
#echo ${response}

domainsListArray=()
while IFS= read -r line || [[ "$line" ]];
  do
    domainsListArray+=( "$line" )
  done < <( echo ${response} | xmlstarlet sel -t -v '/response/data/zone/@idn-name' )

domainsListJsonForZabbix=$(for i in "${domainsListArray[@]}"; do echo $i; done)
echo "$domainsListJsonForZabbix" | /usr/bin/awk 'BEGIN { printf "{\"data\": ["; } { if (NR != 1) printf ","; printf "{\"{#DOMAINNAME}\": \"%s\"}", $1; } END { printf "]}"; }'
