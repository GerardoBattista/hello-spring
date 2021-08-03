pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {

        stage('Test'){
            steps {
                echo 'Testing...'
                withGradle {
                    sh './gradlew clean test'
                }
            }    
            post{
                always{
                    junit 'build/test/results/test/TEST-*.xml'
                }
            }   
        }
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
