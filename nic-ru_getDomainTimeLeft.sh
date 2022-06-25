#!/bin/bash


# VARS

domainName=$1
dateCurrentEpoch=`date '+%s'`


# GET DOMAIN TIME LEFT

# get domain paid-till value
domainDatePaidTill=`whois "portal6400.ru" | awk '/paid-till:/{print $2}'`

# convert paid-till to epoch format
domainDatePaidTillEpoch=`date --date="${domainDatePaidTill}" '+%s'`

# debug
#echo ${domainPaidTillEpoch}

# calc
domainTimeLeft=`echo $[${domainDatePaidTillEpoch}-${dateCurrentEpoch}]`

# output
echo ${domainTimeLeft}
