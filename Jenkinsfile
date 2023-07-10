def accesskey = "AKIASOV5WRTZITA6BUNP"
def secaccesskey = "joNrZKuVjJNRPCu9aefJ5c6EGfO5GjnA8BAifK7v"
def regioncode = "us-east-2"
def outputtype = "None"
def usrnme = "asdpkp"
pipeline {
    agent any
    environment {
        DOCKERHUB_CREDS = credentials('docker-user')
    }
    stages {
        stage('Check the repository out') {
            steps {
                echo 'Getting the latest'
                checkout scm
            }
        }
        stage('Display Creds') {
            steps {
                echo "Docker Hub Username: ${usrnme}"
                echo "Docker Hub Password: ${DOCKERHUB_CREDS_PSW}"
            }
        }

        stage('Build and push the image') {
            steps {
                script {
                    dockerImage = docker.build('asdpkp/hw2')
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-user') {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Testing AWS Configure') {
            steps {
                sh 'aws configure set aws_access_key_id AKIAWDDFPAHBRNA22YWF'
                sh "aws configure set aws_secret_access_key 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"
                sh "aws configure set default_region_name us-east-2"
                sh "aws configure set default_output_type None"
                sh 'aws sts get-caller-identity'
            }
        }
        
        stage('Deploy using the deployment.yaml') {
            steps {
                script {
                    sh 'kubectl get svc'
                    sh 'kubectl apply -f deployement.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}
