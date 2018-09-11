FROM daocloud.io/library/tomcat:8.5.15
RUN rm -rf /usr/local/tomcat/webapps/ROOT/*
ADD ./jenkins.war /usr/local/tomcat/webapps/ROOT.war
RUN sed -i 's/8080/80/' /usr/local/tomcat/conf/server.xml
EXPOSE 80