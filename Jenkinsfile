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
                ./mvnw package
                """
				echo "done with maven"
            }
		}
	}
}