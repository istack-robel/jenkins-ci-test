pipeline {
  agent {
    node {
      label 'nodejs'
    }
    
  }
  stages {
    stage('build') {
      steps {
        echo 'first step build'
      }
    }
    stage('clean up') {
      steps {
        sh 'clear;ls -latr;whoami;pwd'
      }
    }
  }
}