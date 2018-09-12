FROM daocloud.io/library/tomcat:8.5.15
LABEL Name="jenkins"
LABEL Version="0.1"
LABEL Maintainer="Layoute <reallayoute@gmail.com>"
# 环境变量
ENV GRADLE_VERSION 4.4
ENV JAVA_VERSION 8u181

# 安装所需依赖
RUN apt-get update \
    && apt-get install -y \
        git \
        zip \
        unzip \
    && apt-get clean \
    && apt-get autoclean

# 配置 jenkins 为 80 端口
RUN rm -rf /usr/local/tomcat/webapps/ROOT
# ADD ./jenkins.war /usr/local/tomcat/webapps/ROOT.war
ADD https://updates.jenkins-ci.org/download/war/2.141/jenkins.war /usr/local/tomcat/webapps/ROOT.war
RUN sed -i 's/8080/80/' /usr/local/tomcat/conf/server.xml

# 配置 JDK 环境变量
COPY ./profile /etc/profile

# 安装 Oracle JDK
# ADD http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz /usr/local/java
# RUN /bin/bash -c "source /etc/profile"

# 安装 SDKMAN 开发包管理器
WORKDIR /root
RUN curl -s "https://get.sdkman.io" | bash
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh"
# 安装 Gradle 等依赖
# -l 伪装为登录的 shell 执行命令
# -c 读取字符串命令
RUN yes | /bin/bash -l -c 'sdk install gradle ${GRADLE_VERSION}'
RUN yes | /bin/bash -l -c 'sdk install java ${JAVA_VERSION}'

EXPOSE 80

WORKDIR /usr/local/tomcat
COPY ./entrypoint.sh /usr/local/tomcat/
RUN cd /usr/local/tomcat

RUN chmod 0777 ./entrypoint.sh
# 执行脚本
ENTRYPOINT [ "./entrypoint.sh" ]