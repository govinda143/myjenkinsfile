FROM tomcat:8
# Take the war and copy to webapps of tomcat
RUN cp /home/jenkins/workspace/mvn/target/*.war /usr/local/tomcat/webapps/*.war

