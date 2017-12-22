pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh '''echo "build stage"
              pwd
              whoami
              ls -latr
              chmod +x deploy.sh
              ./deploy.sh archive_and_transfer_server
            '''
      }
    }
  }
}
