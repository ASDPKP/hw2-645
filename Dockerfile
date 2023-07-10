FROM tomcat:9.0-jdk15
COPY ss645.war /usr/local/tomcat/webapps.dist
RUN mv webapps webapps2
RUN mv webapps.dist/ webapps