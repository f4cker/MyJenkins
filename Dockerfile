FROM daocloud.io/library/tomcat:8.5.15
ADD ./jenkins.war /usr/local/tomcat/webapps/root
EXPOSE 8080