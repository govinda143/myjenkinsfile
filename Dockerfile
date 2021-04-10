FROM tomcat:8
# Take the war and copy to webapps of tomcat
COPY  /home/jenkins/target.war /home/jenkins/workspace/mvn/usr/local/tomcat/webapps/*.war


