pipeline{
    agent "any"
    environment{
        IMAGE_TAG = "10.0.0"
        IMAGE_NAME = "vladoz77/cicd-docker"
        REPO = "https://github.com/vladoz77/gitops-docker-test"
    }
    stages{
        stage("Clean-workspace"){
            steps{
                cleanWs()
            }
        }
   
        stage("Checkout scm"){
            steps{
                git branch: 'main', credentialsId: 'github', url: "${REPO}"
            }
        }
        
        stage("git config"){
            steps{
                script{
                    sh """
                       git config user.name vladoz77
                       git config user.email vladoz77@yandex.com2
                    """
                }
            }
        }
        
        stage("replace build number"){
            steps{
                script{
                    sh"""
                       cat manifest/app.yaml
                       sed -i 's+${IMAGE_NAME}.*+${IMAGE_NAME}:${IMAGE_TAG}+g' manifest/app.yaml
                       cat manifest/app.yaml
                    """
                }
            }
        }

        stage("git commit"){
            steps{
                script{
                    sh """
                       git add .
                       git commit -m 'Done by Jenkins Job update manifest: ${IMAGE_TAG}'
                    """
                }
            }
        }
        
        stage("git push"){
            steps{
                withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]) {
                    sh "git push  ${REPO} main"
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