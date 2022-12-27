pipeline {

agent {
 label ("node1 || node2 ||  node3 || node4 ||  node5 ||  branch ||  main ||  jenkins-node || docker-agent ||  jenkins-docker2 ||  preproduction ||  production")
} 

options {
    buildDiscarder(logRotator(numToKeepStr: '2'))
    disableConcurrentBuilds()
    timeout (time: 60, unit: 'MINUTES')
    timestamps()
}

    stages {

stage('Setup parameters') {
            steps {
                script {
                    properties([
                        parameters([   
                        
                        choice(
                            choices: ['dev', 'sanbox', 'prod'], 
                            name: 'Environment'
                                 
                        ),


                          string(
                            defaultValue: 'yvan',
                            name: 'User-yvan',
			    description: 'Enter the image Tag to deploy',
                            trim: true
                        ),

                          string(
                            defaultValue: 'yvan',
                            name: 'DB-Tag',
			    description: 'Enter the image Tag to deploy',
                            trim: true
                        ),


                          string(
                            defaultValue: 'yvan',
                            name: 'UI-Tag',
			    description: 'Enter the image Tag to deploy',
                            trim: true
                        ),


                          string(
                            defaultValue: 'yvan',
                            name: 'WEATHER-Tag',
			    description: 'Enter the image Tag to deploy',
                            trim: true
                        ),

                            string(
                            defaultValue: 'yvan',
                            name: 'AUTH-Tag',
			    description: 'Enter the image Tag to deploy',
                            trim: true
                        ),

                        ])
                    ])
                }
            }
        }

	    
	    
	    

        stage('Hello') {
            steps {
                sh '''
                ls 
                pwd
                '''
            }
        }
    }
	
post {
    
    success {
      slackSend (channel: '#development-alerts', color: 'good', message: "the job pass")
    }

    failure {
      slackSend (channel: '#development-alerts', color: '#FF0000', message: "the job faille")
    }
}
	
	
}
