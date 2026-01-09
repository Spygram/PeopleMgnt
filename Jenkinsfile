pipeline{

    agent none
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        APP_IMAGE = 'spygram/peoplemgnt'
        IMAGE_TAG = 'latest'
        DOCKERHUB_URL = 'https://registry.hub.docker.com'

    }
    options { skipDefaultCheckout(true) } // Prevent Jenkins from auto-checking out repo
    stages {
        stage("Git checkout"){
	    agent { label 'buildserver' }  // force this stage to run only on the build node	
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github_cred', url: 'https://github.com/Spygram/PeopleMgnt.git']])
            }
        }

        stage('Build and Push'){
	    agent { label 'buildserver' }  // force this stage to run only on the build node
            steps {
                script {
                    def image = docker.build("${APP_IMAGE}:${IMAGE_TAG}")
                    docker.withRegistry(DOCKERHUB_URL, DOCKERHUB_CREDENTIALS) {
                        image.push()
                    }
                }
            }
        }

        stage('Deploy on Deployment Server') {
            agent { label 'Deployment Server' }   // 👈 Run this stage on that agent
            steps {
                sh '''
		    cd /home/jenkins/app_deploy	
                    docker compose down || true
                    docker compose pull
                    docker compose up -d
                '''
            }
        }
    }
}
