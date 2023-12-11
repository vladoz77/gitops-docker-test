pipeline{
    agent "any"
    environment{
        IMAGE_TAG = "${params.IMAGE_TAG}"
        IMAGE_NAME = "vladoz77/cicd-docker"
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
        
        stage("replace build number"){
            steps{
                script{
                    sh """
                       git config user.name vladoz77
                       git config user.email vladoz77@yandex.com
                       cat manifest/app.yaml
                       sed -i s/${IMAGE_NAME}.*/${IMAGE_NAME}.${IMAGE_TAG}/g
                       cat manifest/app.yaml
                    """
                }
            }
        }
        
        
        
    }
}

sh "git config user.email vladoz77@yandex.com"
                sh "git config user.name vlado77"
                sh "cat manifest/deployment.yaml"
                sh "sed -i 's+vladoz77/cicd-test-project.*+vladoz77/cicd-test-project:${TAG}+g' manifest/deployment.yaml"
                sh "cat manifest/deployment.yaml"
                sh "git add ."
                sh "git commit -m 'Done by Jenkins Job update manifest: ${TAG}'"