#!/bin/bash
set -x

# 将环境变量保存至 /etc/default/locale
env >> /etc/default/locale

# 安装 Gradle
sdk install gradle 4.4

# 启动 apache
apache2-foreground

exec "$@"