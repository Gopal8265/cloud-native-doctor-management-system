pipeline {
    agent any

    environment {
        DOCKER_USER = 'gopal82'
        IMAGE_NAME = 'hospital-mis'
        IMAGE_TAG = 'v1'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify Docker') {
            steps {
                sh 'docker --version'
                sh 'kubectl version --client'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Build & Push Image') {
            steps {
                sh '''
                docker buildx build \
                  --platform linux/amd64 \
                  -t $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG \
                  --push .
                '''
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh '''
                kubectl apply -f k8s/

                kubectl rollout restart deployment/hospital-app

                kubectl rollout status deployment/hospital-app
                '''
            }
        }
    }

    post {
        success {
            echo 'Application built, pushed, and deployed to Minikube successfully!'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}