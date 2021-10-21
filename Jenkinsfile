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
				docker.withRegistry('https://${ECR_URL}', 'ecr:eu-central-1:ecr-admin') {
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