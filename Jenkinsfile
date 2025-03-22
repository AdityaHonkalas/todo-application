pipeline {

    agent any

    environment {
        DOCKER_HUB_CRED_ID = "docker-hub-credentials"
        DOCKER_IMAGE = "adityahonkalas/todo-application-image:latest"
    }

    stages {
        stage("Clone the todo-application repository") {

            steps{
                git branch: "main", url: "https://github.com/AdityaHonkalas/todo-application.git"
            }
        }

        stage("Build the project with maven skipping the test") {

            steps{
                sh 'mvn clean package --DskipTests'
            }
        }

        stage('Build docker image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage("Push the image to the docker hub") {

            steps{
                withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CRED_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage("Deploy the application using docker compose") {

            steps{
                sh 'docker compose down || true'
                sh 'docker compose up -d'
            }
        }

        stage("Verify the deployment") {

            steps{
                sh 'docker ps'
            }
        }

        stage("Clean up the workspace") {

            steps{
                sh 'rm -rf *'
            }
        }
    }
}