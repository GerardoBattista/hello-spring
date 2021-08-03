pipeline {
    agent any

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
                            tools:[
                                pmdParser(pattern: 'build/reports/pmd/*.xml')
                            ]
                    )
                }    
            }
        }

        stage('Build') {
            steps {
                echo 'Building...'
                  buildscript {
                    repositories{
                        maven {
                        url "https://plugins.gradle.org/m2/"
                        }
                    }
                    dependencies {
                    classpath "gradle.plugin.com.github.spotbugs.snom:spotbugs-gradle-plugin:4.7.2"  
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
