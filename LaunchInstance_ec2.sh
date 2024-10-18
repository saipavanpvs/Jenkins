pipeline {
    agent any
    stages {
        stage('Launch EC2 Instance') {
            steps {
                script {
                    sh 'LaunchInstance_ec2.sh'
                }
            }
        }
    }
}
