import org.jenkinsci.plugins.workflow.Library
@Library("jenkins.pipeline.library@master") jpac
pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
		withGradle {
			sh './gradlew assemble'
		}
            }
            post {
                success {
                   archiveArtifacts artifacts: 'build/libs/*.jar'
                }
            }

        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}