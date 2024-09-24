
pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                git "git branch: 'main', credentialsId: '625dfc55-8ffa-4c2c-a32b-6b7dd6bedc98', url: 'https://github.com/abdulmusavvir/terraform-advance.git'"
            }
        }
    }
    post{
        always{
            echo 'cleaning up workspace'
        }
    }
}
