FROM tomcat:8
# Take the war and copy to webapps of tomcat
RUN cp /home/jenkins/workspace/mvn/target/myweb.war /usr/local/tomcat/webapps/dockeransible.war

