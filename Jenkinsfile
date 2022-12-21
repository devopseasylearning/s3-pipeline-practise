pipeline {

     agent {
                  label ("node1 || node2 ||  node3 || node4 ||  node5 ||  branch ||  main ||  jenkins-node || docker-agent ||  jenkins-docker2 ||  preproduction ||  production")

            }

     options {
    timeout (time: 1, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '2'))
    disableConcurrentBuilds()
    timestamps()
  }       

    stages {

        stage('Setup parameters') {
            steps {
                script {
                    properties([
                        parameters([
                        
                        choice(
                            choices: ['Dev', 'Sanbox', 'Prod'], 
                            name: 'Environment'
                                 
                                ),

                          string(
                            defaultValue: 's3nivelle',
                            name: 'User',
                            description: 'Required to enter your name',
                            trim: true
                            ),

                        string(
                            defaultValue: 's3nivelle',
                            name: 'DB-Tag',
                            description:'Required to enter the image tag',
                            trim: true
                            ),

                        string(
                            defaultValue: 's3nivelle',
                            name: 'UI-Tag',
                            description: 'Required to enter the image tag',
                            trim: true
                            ),
                        string(
                            defaultValue: 's3nivelle',
                            name: 'WEATHER-Tag',
                            description: 'Required to enter the image tag',
                            trim: true
                            ),

                        string(
                            defaultValue: 's3nivelle',
                            name: 'AUTH-Tag',
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
cat <<EOF > check.sh
#! /bin/bash 
USER=${User}
cat permission.txt | grep -i $USER
if 
[[ $? -eq 0 ]]
then 
echo "You have permission to run this job"
else 
echo "You DON'T have permission to run this job"
exit 1
fi 
EOF
                '''
            }
        }
  
          stage('cleaning') {
            steps {
                echo 'clean the environment'
            }
        }
          stage('sonarqube') {
            steps {
                echo 'test the code using sonarqube'
            }
        }

          stage('build-dev') {
            steps {
                echo 'build image for dev environment only '
            }
        }
          stage('build-sandox') {
            steps {
                echo 'build image for sanbox environment only'
            }
        }
          stage('build-prod') {
            steps {
                echo 'build image for prod environment only'
            }
        }
          stage('login') {
            steps {
                echo 'login to company dockerhub account'
            }
        }
          stage('push-to-dockerhub-dev') {
            steps {
                echo 'push image for dev environment only'
            }
        }
          stage('push-to-dockerhub-sanbox') {
            steps {
                echo 'push image sandbox  dev environment only '
            }
        }
          stage('push-to-dockerhub-prod') {
            steps {
                echo 'push image for prod  environment only '
            }
        }
          stage('update helm charts-sanbox') {
            steps {
                echo 'update values file  for prod  environment only'
            }
        }
          stage('update helm charts-dev') {
            steps {
                echo 'update values file  for dev  environment only'
            }
        }
          stage('update helm charts-prod') {
            steps {
                echo 'update values file  for test  environment only'
            }
        }
          stage('wait for argocd') {
            steps {
                echo 'waiting for argocd to detect the change'
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
