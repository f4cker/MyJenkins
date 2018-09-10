FROM daocloud.io/library/tomcat:8.5.15
ADD ./jenkins.war /usr/local/tomcat/webapps
# EXPOSE 8080
RUN value=`cat conf/server.xml` && echo "${value//8080/80}" >| conf/server.xml