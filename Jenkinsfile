pipeline {
    agent any  // Runs on VM's main agent

    tools {
        nodejs 'Node18'  // Assumes you install Node tool in Jenkins (Manage Jenkins → Global Tool Config)
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/sirishaallarapu/frontend-and-backend.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'npm run test:frontend:unit'
            }
        }

        stage('Run API Tests') {
            steps {
                sh 'npm run test:api:with:servers'
            }
        }

        stage('Run UI Tests (Cypress Headless)') {
            steps {
                sh 'npm run test:frontend:with:server'
            }
        }

        stage('Build Docker Image (Optional)') {  // Add if you create a Dockerfile
            when {
                expression { return env.BRANCH_NAME == 'main' }  // Only on main
            }
            steps {
                script {
                    def image = docker.build("sirisha-app:${env.BUILD_ID}")
                    // Push to Docker Hub or Azure ACR if needed
                }
            }
        }
    }

    post {
        always {
            // Archive Cypress artifacts
            archiveArtifacts artifacts: 'cypress/screenshots/**, cypress/videos/**', allowEmptyArchive: true
            // Clean up
            sh 'docker system prune -f || true'
        }
        success {
            echo 'All tests passed! 🚀'
        }
        failure {
            echo 'Tests failed. Check artifacts.'
        }
    }
}
