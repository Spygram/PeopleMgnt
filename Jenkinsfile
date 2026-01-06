pipeline{

    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        APP_IMAGE = 'spygram/peoplemgnt'
        IMAGE_TAG = 'latest'
        DOCKERHUB_URL = 'https://registry.hub.docker.com'
        
    }
    stages {
        stage("Git checkout"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github_cred', url: 'https://github.com/Spygram/PeopleMgnt.git']])
            }
        }
       
        stage('Build and Push'){
            steps {
                script {
                    def image = docker.build("${APP_IMAGE}:${IMAGE_TAG}")
                    docker.withRegistry(DOCKERHUB_URL, 'dockerhub-credentials-id') {
                        image.push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['jenkins_ssh']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@10.10.1.228 << 'EOF'
                        cd /home/ec2-user/app-deploy/
                        docker compose down
                        docker compose pull
                        docker compose up -d
                        EOF
                    '''
                }
            }
        }
    }
}
