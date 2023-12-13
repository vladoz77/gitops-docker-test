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

        stage("argocd deploy"){
            environment{
                    ARGO_APP_MANIFEST = "argocd-app.yaml"
                    ARGO_APP_NAME = "cicd-docker"
                    ARGOCD_SERVER = "argocd.dev.local"
                    ARGOCD_PROJECT = "apps2deploy"
                }
            steps{
                script{
                    def argocdToken = credentials('argocd-token')
                    def appSpecFile = readFile("argocd-app.yaml")
                    def argocd = new Argocd(server: ARGOCD_SERVER, token: argocdToken)
                    
                    argocd.createApplication(appSpecFile, project: ARGOCD_PROJECT)
                    argocd.syncApplication(ARGO_APP_NAME)

                    // withCredentials([string(credentialsId: 'argocd-token', variable: 'ARGOCD_AUTH_TOKEN')]) {
                    //     sh "argocd --grpc-web app create ${ARGO_APP_NAME} --file ${ARGO_APP_MANIFEST}"
                    //     sh "argocd --grpc-web app sync ${ARGO_APP_NAME} --force"
                    }
                }
            }
        }

    }
}


