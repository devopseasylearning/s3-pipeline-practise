pipeline {
    agent {
     label ("node1 || node2 ||  node3 || node4 ||  node5 ||  branch ||  main ||  jenkins-node || docker-agent ||  jenkins-docker2 ||  preproduction ||  production")
            }

  environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}

options {
    buildDiscarder(logRotator(numToKeepStr: '20'))
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
                            choices: ['DEV', 'SANBOX','PROD'], 
                            name: 'Environment'   
                                ),

                          string(
                            defaultValue: 's4user',
                            name: 'USER',
			                description: 'Required to enter your name',
                            trim: true
                            ),

                          string(
                            defaultValue: 'v1.0.0',
                            name: 'DBTag',
			                description: 'Required to enter the image tag',
                            trim: true
                            ),

                          string(
                            defaultValue: 'v1.0.0',
                            name: 'UITag',
			                description: 'Required to enter the image tag',
                            trim: true
                            ),

                          string(
                            defaultValue: 'v1.0.0',
                            name: 'WEATHERTag',
			                description: 'Required to enter the image tag',
                            trim: true
                            ),

                          string(
                            defaultValue: 'v1.0.0',
                            name: 'AUTHTag',
			                description: 'Required to enter the image tag',
                            trim: true
                            ),
                        ])
                    ])
                }
            }
        }
 
stage('permission') {
            steps {
                sh '''
cat permission.txt | grep -o $USER
echo $?

                '''
            }
        }
	    
        stage('cleaning') {
            steps {
                sh '''
                ls 
                '''
            }
        }

    stage('SonarQube analysis') {
            agent {
                docker {
                  image 'sonarsource/sonar-scanner-cli:4.7.0'
                }
               }
               environment {
        CI = 'true'
        //  scannerHome = tool 'Sonar'
        scannerHome='/opt/sonar-scanner'
    }
            steps{
                withSonarQubeEnv('Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage('build-dev') {
         when{ 
          expression {
            env.Environment == 'DEV' }
            }
            steps {
                sh '''
cd UI
docker build -t devopseasylearning2021/s4-ui:${BUILD_NUMBER}$UITag .
cd -
cd DB
docker build -t devopseasylearning2021/s4-db:${BUILD_NUMBER}$DBTag .
cd -
cd auth 
docker build -t devopseasylearning2021/s4-auth:${BUILD_NUMBER}$AUTHTag .
cd -
cd weather 
docker build -t devopseasylearning2021/s4-weather:${BUILD_NUMBER}$WEATHERTag .
cd -
                '''
            }
        }

        stage('build-sanbox') {
          when{ 
              expression {
                env.Environment == 'SANBOX' }
                }
            steps {
                sh '''
cd UI
docker build -t devopseasylearning2021/s4-ui:${BUILD_NUMBER}$UITag .
cd -
cd DB
docker build -t devopseasylearning2021/s4-db:${BUILD_NUMBER}$DBTag .
cd -
cd auth 
docker build -t devopseasylearning2021/s4-auth:${BUILD_NUMBER}$AUTHTag .
cd -
cd weather 
docker build -t devopseasylearning2021/s4-weather:${BUILD_NUMBER}$WEATHERTag .
cd -
                '''
            }
        }


        stage('build-prod') {
          when{ 
              expression {
                env.Environment == 'PROD' }
                }
            steps {
                sh '''
cd UI
docker build -t devopseasylearning2021/s4-ui:${BUILD_NUMBER}$UITag .
cd -
cd DB
docker build -t devopseasylearning2021/s4-db:${BUILD_NUMBER}$DBTag .
cd -
cd auth 
docker build -t devopseasylearning2021/s4-auth:${BUILD_NUMBER}$AUTHTag .
cd -
cd weather 
docker build -t devopseasylearning2021/s4-weather:${BUILD_NUMBER}$WEATHERTag .
cd -
                '''
            }
        }

        stage('login') {
            steps {
                sh '''
echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u devopseasylearning2021 --password-stdin
                '''
            }
        }

        stage('push-to-dockerhub-dev') {
          when{ 
              expression {
                env.Environment == 'DEV' }
                }
            steps {
                sh '''
docker push devopseasylearning2021/s4-ui:${BUILD_NUMBER}$UITag 
docker push devopseasylearning2021/s4-db:${BUILD_NUMBER}$DBTag 
docker push devopseasylearning2021/s4-auth:${BUILD_NUMBER}$AUTHTag 
docker push devopseasylearning2021/s4-weather:${BUILD_NUMBER}$WEATHERTag 
                '''
            }
        }

        stage('push-to-dockerhub-sanbox') {
          when{ 
              expression {
                env.Environment == 'SANBOX' }
                }
            steps {
                sh '''
docker push devopseasylearning2021/s4-ui:${BUILD_NUMBER}$UITag 
docker push devopseasylearning2021/s4-db:${BUILD_NUMBER}$DBTag 
docker push devopseasylearning2021/s4-auth:${BUILD_NUMBER}$AUTHTag 
docker push devopseasylearning2021/s4-weather:${BUILD_NUMBER}$WEATHERTag 
                '''
            }
        }

        stage('push-to-dockerhub-prod') {
          when{ 
              expression {
                env.Environment == 'PROD' }
                }
            steps {
                sh '''
docker push devopseasylearning2021/s4-ui:${BUILD_NUMBER}$UITag 
docker push devopseasylearning2021/s4-db:${BUILD_NUMBER}$DBTag 
docker push devopseasylearning2021/s4-auth:${BUILD_NUMBER}$AUTHTag 
docker push devopseasylearning2021/s4-weather:${BUILD_NUMBER}$WEATHERTag 
                '''
            }
        }

        stage('update helm charts-dev') {
            steps {
                sh '''
                ls 
                pwd
                '''
            }
        }

        stage('update helm charts-sanbox') {
            steps {
                sh '''
                ls 
                pwd
                '''
            }
        }

        stage('update helm charts-prod') {
            steps {
                sh '''
                ls 
                pwd
                '''
            }
        }

        stage('wait for argocd') {
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
      slackSend (channel: '#development-alerts', color: 'good', message: "SUCCESSFUL: Application S4-EKTSS  Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }

 
    unstable {
      slackSend (channel: '#development-alerts', color: 'warning', message: "UNSTABLE: Application S4-EKTSS  Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }

    failure {
      slackSend (channel: '#development-alerts', color: '#FF0000', message: "FAILURE: Application S4-EKTSS Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
   
    cleanup {
      deleteDir()
    }
}


	
}


