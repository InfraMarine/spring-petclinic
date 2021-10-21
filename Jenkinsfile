pipeline {
    agent { label 'ecs-dind' }
    stages {
		stage ('BUILD') {
			steps {
                sh """
				whoami
				pwd
				ls
				ls /home/jenkins/
                unset MAVEN_CONFIG && env &&./mvnw package -DskipTests
                """
				echo "done with maven"
            }
		}
		stage ('DOCKERIZE') {
			steps {
				script {
				withAWS(credentials:'ecr-admin', region:'eu-central-1') {
					def login = ecrLogin()
					sh "echo ${login} && sudo ${login}"
					sh """
					sudo docker build -t ${ECR_URL}/spring-petclinic:${env.BUILD_ID} .
					sudo docker push ${ECR_URL}/spring-petclinic:${env.BUILD_ID}
					"""
				}
			  }
			}
        }
	}
}