pipeline{
    agent "any"
    environment{
        // TAG = "${params.TAG}"
    }
    stages{
        stage("Clean-workspace"){
            steps{
                cleanWs()
            }
        }
    }

    stages{
        stage("Checkout scm"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github']])              
                
            }
        }
    }
}