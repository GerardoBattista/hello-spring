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
        
        stage('Publish') {
            steps {
            tag 'docker tag 10-250-14-1:5050/gerardod/hello-spring/hello-gradle:latest 10.250.14.1:5050/gerardod/hello-spring/hello-gradle:latest-1.0.${BUILD_NUMBER}'
            withDockerRegistry([url:'http://10.250.14.1:5050'], credentialsID:'dockerCli' ]) {
                sh 'docker push 10.250.14.1:5050/gerardod/hello-gradle:latest'
              }
           }
        }
        stage('Deploy') {
            steps {
            echo 'Deploying'

            }
        }
    }
}
