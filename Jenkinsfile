pipeline {
    agent any

    environment {
        IMAGE_NAME = "gopal82/hospital-mis"
        IMAGE_TAG = "v1"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $IMAGE_NAME:$IMAGE_TAG .
                '''
            }
        }

        stage('List Docker Images') {
            steps {
                sh 'docker images'
            }
        }
    }

    post {
        success {
            echo 'Docker image built successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}