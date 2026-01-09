pipeline{

    agent none
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        APP_IMAGE = 'spygram/peoplemgnt'
        IMAGE_TAG = 'latest'
        DOCKERHUB_URL = 'https://registry.hub.docker.com'

    }
    stages {
        stage("Git checkout"){
	    agent any	
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

        stage('Deploy on Deployment Server') {
            agent { label 'Deployment Server' }   // 👈 Run this stage on that agent
            steps {
                sh '''
		    cd ./app_deploy	
                    docker compose down || true
                    docker compose pull
                    docker compose up -d
                '''
            }
        }
    }
}
