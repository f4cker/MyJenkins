#!/bin/bash
set -x

# 将环境变量保存至 /etc/default/locale
env >> /etc/default/locale

# 启动 tomcat
catalina.sh run

exec "$@"