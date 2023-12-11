pipeline{
    agent "any"
    environment{
        TAG = "${params.IMAGE_TAG}"
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
        
        stage("echo env"){
            steps{
                sh "echo $TAG"
            }
        }
        
    }
}