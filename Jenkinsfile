pipeline {
    agent { label 'ecs' }
    stages {
    	stage ('CHECKOUT') {
			steps {
				checkout scm
			}
		}
		stage ('BUILD') {
			steps {
                sh """ 
                ./mvnw package -DskipTests
                """
				echo "done with maven"
            }
		}
		stage ('DOCKERIZE') {
			steps {
				docker.withRegistry('https://232484871880.dkr.ecr.eu-central-1.amazonaws.com', 'ecr:eu-central-1:ecr-admin') {

				def customImage = docker.build("spring-petclinic:${env.BUILD_ID}")

				customImage.push()
			  }
}
            }
		}
	}
}