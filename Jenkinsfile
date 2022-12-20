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
                            choices: ['Dev', 'sanbox', 'Prod'], 
                            name: 'Environment'
                                 
                                ),

                          string(
                            defaultValue: 's3nivelle',
                            name: 'User',
                            trim: true
                            ),

                        string(
                            defaultValue: 's3nivelle',
                            name: 'DB-Tag',
                            trim: true
                            ),

                        string(
                            defaultValue: 's3nivelle',
                            name: 'UI-Tag',
                            trim: true
                            ),
                        string(
                            defaultValue: 's3nivelle',
                            name: 'WEATHER-Tag',
                            trim: true
                            ),

                        string(
                            defaultValue: 's3nivelle',
                            name: 'AUTH-Tag',
                            trim: true
                            ),

                        ])
                    ])
                }
            }
        }

        stage('permission') {
            steps {
                echo 'checking the employee belong to s4 session'
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


    
  
    
}


}
