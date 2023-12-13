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
        
        stage("replace build number"){
            steps{
                script{
                    sh """
                        git config user.name vladoz77
                        git config user.email vladoz77@yandex.com

                        cat manifest/app.yaml
                        sed -i 's+${IMAGE_NAME}.*+${IMAGE_NAME}:${IMAGE_TAG}+g' manifest/app.yaml
                        cat manifest/app.yaml

                        git add .
                        git commit -m 'Done by Jenkins Job update manifest: ${IMAGE_TAG}'
                    """
                    withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]){
                        sh "git push  ${REPO} main"
                    }
                }
            }
        }
        

        stage("argocd deploy"){
            environment{
                    ARGO_APP_MANIFEST = "argocd-app.yaml"
                    ARGO_APP_NAME = "cicd-docker"
                }
            steps{
                script{
                    withCredentials([string(credentialsId: 'argocd-token', variable: 'ARGOCD_AUTH_TOKEN')]) {
                        sh(script: ''' #!/bin/bash
                                               
                        argocd app get ${ARGO_APP_NAME} > /dev/null 2>&1
                        
                        if [ ${?} -eq 0 ]
                        then
                            echo App ${ARGO_APP_NAME} is created
                        else
                            argocd app create ${ARGO_APP_NAME} --file ${ARGO_APP_MANIFEST} --grpc-web
                            sleep 5
                        fi
                        
                        argocd app sync ${ARGO_APP_NAME}  --grpc-web
                        argocd app wait ${ARGO_APP_NAME} --timeout 600 --grpc-web
                        '''
                        '''.stripIndent())
                    }
                }
            }
        }
    }
}

