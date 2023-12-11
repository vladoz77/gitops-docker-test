pipeline{
    agent "any"
    environment{
        IMAGE_TAG = "${params.IMAGE_TAG}"
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

        stage("argocd update"){
            environment {
                ARGOCDSERVER = "https://argocd-server.example.com"
                ARGOCDPROJECT = "default"
                ARGOCDAPP = "app"
                K8SCONTEXT = "minikube"
                K8SNAMESPACE = "default"
                ARGOCDSYNCOPTIONS = "--sync-policy=auto --prune"
            }
            steps{
                script {
                    def argocdToken = credentials('jenkins-token')
                    def appSpecFile = readFile("argocd-app.yaml")

                    def argocd = new Argocd(server: ARGOCDSERVER, token: argocdToken)
                    argocd.createApplication(appSpecFile, project: ARGOCDPROJECT)
                    argocd.syncApplication(ARGOCDAPP, ARGOCDSYNCOPTIONS)
                    }
                }
            }
        }
        
        
    }
}

