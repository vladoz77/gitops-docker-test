pipeline{
    agent "any"
    environment{
        TAG = "${params.TAG}"
    }
    stages{
        stage("Clean-workspace"){
            steps{
                cleanWs()
            }
        }
   
        stage("Checkout scm"){
            steps{
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/vladoz77/gitops-docker-test'
            }
        }

        
    }
}