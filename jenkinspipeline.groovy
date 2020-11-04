pipeline {
	agent {label 'master'}
	
	stages {
		stage('CLEAN WORKSPACE IN JENKINS SERVER'){
			steps {
				cleanWs()
			} // Steps Completed	
		}  // Stage Completed
	

		stage('CLONE THE SOURCE CODE FROM GIT-HUB'){
			steps {
				echo 'In SCM Stage'
				
				git credentialsId: 'f278eddc-9430-40ea-8dd6-048a31ddca83', url: 'https://github.com/gopinathPersonal/terraformSample.git',branch: 'main'
				sh '''
					ls
					pwd
				'''

			} // Steps Completed
		}  // Stage Completed	


		stage('initiating terraform'){
			steps {
				
				sh'''
					terraform init -input=false
				'''
			} // Steps Completed
		}  // Stage Completed

		stage('Applying terraform'){
			steps {
				
				sh'''
					terraform apply -input=false -auto-approve
				'''
			} // Steps Completed
		}  // Stage Completed


		
	}
}
