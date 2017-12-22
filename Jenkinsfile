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
              ssh -o "StrictHostKeyChecking no" -tt root@172.104.36.189 'bash -s' < .gitlab-staging-deploy.sh cleanup
              ./deploy.sh archive_and_transfer_server
            '''
      }
    }
  }
}
