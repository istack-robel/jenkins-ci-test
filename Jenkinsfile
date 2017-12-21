pipeline {
  agent none
  stages {
    stage('build') {
      steps {
        sh '''echo "build stage"
pwd
ls -latr
whoami'''
      }
    }
    stage('clean up') {
      steps {
        sh '''echo "clean up stage"
pwd
whoami
ls -latr'''
      }
    }
    stage('') {
      steps {
        sh '''echo "last script"
node -v'''
      }
    }
  }
}