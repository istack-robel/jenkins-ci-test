pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh '''echo "build stage"
              whoami
              ls -latr
              chmod +x deploy.sh
              ./deploy.sh archive_and_transfer_server
            '''
      }
    }
  }
}
