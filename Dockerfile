FROM tomcat:9.0
RUN rm -rf /usr/local/tomcat/webapps/*
COPY src/main/webapp/index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp
EXPOSE 8090
