pipeline {
    agent any
    options {
        ansiColor('xterm')
        }
    stage {
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
        stage('QA') {
            steps {
                withGradle {
                    sh './gradlew check'
                }
            }
        }
            stage('SonarQube Analysis') {
              steps {
            withSonarQubeEnv('local') {
            sh "./gradlew sonarqube"
                 }
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

        stage('Deploy') {
            steps {
            echo 'Deploying'

            }
        }
    }
}
