pipeline {
    agent any

    environment {
        BACKEND_IMAGE = "backend:latest"
        FRONTEND_IMAGE = "frontend:latest"
        BACKEND_CONTAINER = "backend-container"
        FRONTEND_CONTAINER = "frontend-container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Cloning repository..."
                git branch: 'main', url: 'https://github.com/sirishaallarapu/frontend-and-backend.git'
            }
        }

        stage('Build Backend Docker Image') {
            steps {
                echo "Building backend image..."
                dir('backend') {
                    sh 'docker build -t ${BACKEND_IMAGE} .'
                }
            }
        }

        stage('Build Frontend Docker Image') {
            steps {
                echo "Building frontend image..."
                dir('frontend') {
                    sh 'docker build -t ${FRONTEND_IMAGE} .'
                }
            }
        }

        stage('Run Containers') {
            steps {
                echo "Starting backend and frontend containers..."
                sh 'docker stop ${BACKEND_CONTAINER} || true'
                sh 'docker rm ${BACKEND_CONTAINER} || true'
                sh 'docker stop ${FRONTEND_CONTAINER} || true'
                sh 'docker rm ${FRONTEND_CONTAINER} || true'

                sh 'docker run -d -p 3000:3001 --name ${BACKEND_CONTAINER} ${BACKEND_IMAGE}'
                sh 'docker run -d -p 8080:8080 --name ${FRONTEND_CONTAINER} ${FRONTEND_IMAGE}'
            }
        }

        stage('Test Application') {
            steps {
                echo "Testing backend API..."
                sh 'curl -X POST http://localhost:3000 -H "Content-Type: application/json" -d \'{"name":"JenkinsTest"}\''

                echo "Testing frontend page..."
                sh 'curl -I http://localhost:8080 || true'
            }
        }

        stage('Clean Up') {
            steps {
                echo "Cleaning up containers..."
                sh 'docker stop ${BACKEND_CONTAINER} || true'
                sh 'docker rm ${BACKEND_CONTAINER} || true'
                sh 'docker stop ${FRONTEND_CONTAINER} || true'
                sh 'docker rm ${FRONTEND_CONTAINER} || true'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
            sh 'docker system prune -f || true'
        }
    }
}
