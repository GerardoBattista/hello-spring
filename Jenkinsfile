pipeline {
    agent any
    options {
        ansiColor('xterm')
        }
    stages {
        stage('Test') {
            steps {
                echo 'Testing...'
                withGradle {
                    sh './gradlew clean test'
                }
            }
            post {
                always {
                    junit 'build/test-results/test/TEST-*.xml'
                    jacoco execPattern:'build/jacoco/*.exec'
                }
            }
        }
        stage('QA') {
            steps {
                withGradle {
                    sh './gradlew check'
                }
            }
            post {
                always {
                    recordIssues(
                        tools: [
                            pmdParser(pattern: 'build/reports/pmd/*.xml'),
                            spotBugs(pattern: 'build/reports/spotbugs/*.xml', useRankAsPriority: true)
                        ]
                    )
                }
            }
        }
/*
            stage('SonarQube Analysis') {
              steps {
            withSonarQubeEnv('local') {
            sh "./gradlew sonarqube"
                 }
               }
            }
*/
        stage('Build') {
            steps {
               echo 'Ejecutando build de Docker'
                sh 'docker-compose build'

            }
        }
        stage('Security') {
            steps {
                echo 'Security analysis...'
                sh 'trivy image --format=json --output=trivy-image.json hello-gradle:latest'

            }
            post {
                always {
                    recordIssues(
                        enabledForFailure: true,
                        aggregatingResults: true,
                        tool: trivy(pattern: 'trivy-*.json')
                                 )
                   } 
                }
            } 
/*
       stage('Publish') {
            steps {
            tag 'docker tag hello-gradle:latest 10.250.14.1:5050/gerardod/hello-gradle:latest-1.0.${BUILD_NUMBER}'
            withDockerRegistry([url:'http://10.250.14.1:5050', credentialsId:'Docker-gitlab' ]) {
                sh 'docker push 10.250.14.1:5050/gerardod/hello-spring:latest'
                sh 'docker push 10.250.14.1:5050/gerardod/hello-spring:TESTING-1.0.${BUILD_NUMBER}'
              }
           }
        }
*/
        stage('Deploy') {
            steps {
               echo 'Deplegando servicio...'
               sshagent(credentials:['appkey']){
                   sh '''
                   ssh -o StrictHostKeyChecking=no app app@10.250.14.1 'cd hello-spring && docker-compose pull && docker-compose up -d'
                   '''
                }
            }
        }
    }
}
