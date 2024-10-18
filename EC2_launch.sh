pipeline {
    agent any
        stages {
            stage  ('launching an ec2') {
                script {
                    sh './LauncInstance.sh'
                }
            }
        }
}