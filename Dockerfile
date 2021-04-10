FROM tomcat:8
# Take the war and copy to webapps of tomcat
COPY  /home/jenkins/target/*.war /usr/local/tomcat/webapps/*.war


