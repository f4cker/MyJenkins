FROM daocloud.io/library/tomcat:8.5.15
MAINTAINER Layoute
# 安装所需依赖
RUN apt-get update \
    && apt-get install -y \
        git \
        zip \
        unzip \
    # 安装 Oracle JDK
    && wget -c --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz \
    && mkdir /usr/local/java \
    && tar zxvf jdk-8u181-linux-x64.tar.gz \
    && rm jdk-8u181-linux-x64.tar.gz \
    && ls -al
# 配置 JDK 环境变量
COPY ./profile /etc/profile    
RUN /bin/bash -c "source /etc/profile"
# 安装 SDKMAN 开发包管理器
RUN curl -sS "https://get.sdkman.io" | bash
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh"
# 安装 Gradle
RUN /bin/bash -c "sdk install gradle 4.4"
RUN rm -rf /usr/local/tomcat/webapps/ROOT
ADD ./jenkins.war /usr/local/tomcat/webapps/ROOT.war
RUN sed -i 's/8080/80/' /usr/local/tomcat/conf/server.xml
EXPOSE 80