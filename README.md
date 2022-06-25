# Installation

- At https://www.nic.ru
  - login to your account
  - go to: https://www.nic.ru/manager/oauth.cgi?step=oauth.app_register
  - create APP named "**zabbix_nicru**"
  - get and remember: **APP-LOGIN**, **APP-PASSWORD**
- At Zabbix server
  - copy *.sh scripts from this repo to /usr/lib/zabbix/externalscripts
  - import zabbix template *.xml from this repo into zabbix
  - create host "NIC.RU___<login_account_nic.ru>"
  - write macros in the host:
    - {$NICRU_ACCOUNTUSER} - account login
    - {$NICRU_ACCOUNTPASS} - account password
    - {$NICRU_APPUSER}, {$NICRU_APPPASS} - application login and password (**APP-LOGIN**, **APP-PASSWORD**)
  - Attach template to the host
  - Discovery rule will get array with domain names
  - Items and triggers will be created
