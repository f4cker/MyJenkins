#!/bin/bash
set -e

# 将环境变量保存至 /etc/default/locale
env >> /etc/default/locale

# 安装 Gradle
sdk install gradle 4.4

# 启动 tomcat
catalina.sh run

exec "$@"