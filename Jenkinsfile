pipeline{
    agent "any"
    // environment{
    //     // TAG = "${params.TAG}"
    // }
    stages{
        stage("Clean-workspace"){
            steps{
                cleanWs()
            }
        }
   
        stage("Checkout scm"){
            steps{
                checkout scm Git(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github']])              
                
            }
        }
    }
}