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
        
        // stage("git config"){
        //     steps{
        //         script{
        //             sh """
        //                git config user.name vladoz77
        //                git config user.email vladoz77@yandex.com2
        //             """
        //         }
        //     }
        // }
        
        // stage("replace build number"){
        //     steps{
        //         script{
        //             sh"""
        //                cat manifest/app.yaml
        //                sed -i 's+${IMAGE_NAME}.*+${IMAGE_NAME}:${IMAGE_TAG}+g' manifest/app.yaml
        //                cat manifest/app.yaml
        //             """
        //         }
        //     }
        // }

        // stage("git commit"){
        //     steps{
        //         script{
        //             sh """
        //                git add .
        //                git commit -m 'Done by Jenkins Job update manifest: ${IMAGE_TAG}'
        //             """
        //         }
        //     }
        // }
        
        // stage("git push"){
        //     steps{
        //         withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]) {
        //             sh "git push  ${REPO} main"
        //         }
        //     }
        // }

        stage("argocd deploy"){
            environment{
                    ARGO_APP = "argocd-app.yaml"
                    ARGOCD_SERVER = "argocd.dev.local"
                }
            steps{
                script{
                    withCredentials([string(credentialsId: 'jenkins-token', variable: 'ARGOCD_AUTH_TOKEN')]) {
                        sh "ARGOCD_SERVER=${ARGOCD_SERVER} argocd --grpc-web app create --file ${ARGO_APP}"
                        sh "ARGOCD_SERVER=${ARGOCD_SERVER} argocd --grpc-web app sync ${ARGO_APP} --force"
                    }
                }
            }
        }

    }
}


