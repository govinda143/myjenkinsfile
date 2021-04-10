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
             agent{
                 label 'maven'
         }
             steps{
                 sh "mvn clean package"
                 
             }
         }
         stage('copy of war file'){
            agent{
                 label 'maven'
         } 
             
            steps{
                 sshagent(credentials: ['ansible'], ignoreMissing: true) {

              sh 'scp -o StrictHostKeyChecking=no target/*.war  jenkins@10.0.3.203:/home/jenkins/workspace/mvn'
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
        
             steps{
                 withCredentials([string(credentialsId: 'doc1', variable: 'dochib')]) {
                 sh "docker login -u kgovinda -p ${dochib}"
                 } 
                 sh "docker push kgovinda/143:${DOCKER_TAG}"
             }
         }
         stage('ansible ping'){
             agent{
                 label 'ansible'
             }
             steps{
                 sh "ansible -m ping -i hosts all"
                 sh "ansible-palybook -i hosts deploy-docker.yml all"
             }
         }
     }
}
