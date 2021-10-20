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
				docker.withRegistry('https://232484871880.dkr.ecr.eu-central-1.amazonaws.com', 'ecr:eu-central-1:ecr-admin') {

				def customImage = docker.build("spring-petclinic:${env.BUILD_ID}")

				customImage.push()
				}
			  }
			}
        }
	}
}