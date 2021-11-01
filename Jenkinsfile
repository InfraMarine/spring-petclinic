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
					sh "sudo ${login}"
					sh """
					sudo docker build -t ${ECR_URL}/spring-petclinic:${env.BUILD_ID}-${env.GIT_COMMIT} .
					sudo docker push ${ECR_URL}/spring-petclinic:${env.BUILD_ID}-${env.GIT_COMMIT}
					"""
				}
				}
			}
        }
        stage ('Trigger deploy job') {
        	steps {
	        	build(job: 'petclinic-deploy-ci', parameters:[
		        	string(name: 'AWS_REGION', value: 'eu-central-1'),
		        	string(name: 'ECR_URL', value: '232484871880.dkr.ecr.eu-central-1.amazonaws.com'),
		        	string(name: 'ECS_CLUSTER_NAME', value: 'petclinic-CI-QA-deploy'),
		        	string(name: 'IMAGE_TAG', value: "${env.BUILD_ID}-${env.GIT_COMMIT}")]
	        	)
        	}
        }
	}
}