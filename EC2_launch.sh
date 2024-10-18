pipeline {
    agent any
        stages {
            stage  ('launching an ec2') {
                script {
                    sh './EC2_launch.sh'
                }
            }
        }
}