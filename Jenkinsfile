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
                unset MAVEN_CONFIG && env && ./mvnw package -DskipTests
                """
				echo "done with maven"
            }
		}
	}
}