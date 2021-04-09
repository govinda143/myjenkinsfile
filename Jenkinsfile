def getversion(){
    def commitHash = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
  }
pipeline{   
    agent any

    environment {
  DOCKER_TAG = getversion()
}

     stages{
         stage('scm checkout'){
             steps{
                git credentialsId: 'git', url: 'https://github.com/govinda143/dockeransiblejenkins.git'
             }
         }
         stage ('mvn build'){
             steps{
                 sh "mvn clean package"
                 sh 'mv /workspace/mvn/target/*.war /workspace/mvn/target/myweb.war'
             }
         }
         stage('copy of war file'){
             
             steps{
                 sshagent(credentials: ['ansible'], ignoreMissing: true) {

              sh 'scp -o StrictHostKeyChecking=no /workspace/mvn/target/myweb.war  jenkins@10.0.3.203:/workspace/mvn/target/'
               }

             }
         }
         
         stage('docker image build'){
             agent{
                 label 'ansible'
             }
             steps{
                 sh "docker image build . -t kgovinda/143:${DOCKER_TAG}" 
             }
         }
         stage('ansible ping'){
             agent{
                 label 'ansible'
             }
             steps{
                 sh "ansible -m ping -i hosts al"
                 sh "ansible-palybook -i hosts deploy-docker.yml all"
             }
         }
     }
}
