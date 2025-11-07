pipeline {
    agent any
    tools { nodejs 'Node18' }

    environment {
        IMAGE_NAME     = 'sirishaallarapu/frontend-and-backend'
        IMAGE_TAG      = "${env.BUILD_ID}"
        CONTAINER_NAME = 'test-container'
        HOST_PORT      = '8081'
        CONTAINER_PORT = '8080'
        DOCKERHUB_CRED = credentials('dockerhub-cred')  // ← Now works!
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/sirishaallarapu/frontend-and-backend.git'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    def image = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                    env.BUILT_IMAGE_ID = image.id
                }
            }
        }

        stage('Docker Run & Test') {
            steps {
                script {
                    def img = docker.image("${IMAGE_NAME}:${IMAGE_TAG}")
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    img.withRun("-d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME}") { c ->
                        sh 'sleep 15'
                        sh 'curl -f http://localhost:8081/static/js/main.c13741b3.js > /dev/null && echo "Frontend OK!"'
                    }
                }
            }
        }

        // PUSH ENABLED!
        stage('Docker Push') {
            when { branch 'main' }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-cred') {
                        def img = docker.image("${IMAGE_NAME}:${IMAGE_TAG}")
                        img.push()
                        img.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            sh "docker rm -f ${CONTAINER_NAME} || true"
            sh 'docker system prune -f || true'
        }
        success { echo 'SUCCESS! Image pushed to Docker Hub!' }
    }
}
