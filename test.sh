#!/usr/bin/bash

ARGO_APP_MANIFEST="argocd-app.yaml"
ARGO_APP_NAME="cicd-docker"

# argocd app get ${ARGO_APP_NAME} > /dev/null 2>&1
                        
if [ "argocd app get ${ARGO_APP_NAME} > /dev/null 2>&1"  ]
then
  echo App ${ARGO_APP_NAME} is created
else
  argocd app create ${ARGO_APP_NAME} --file ${ARGO_APP_MANIFEST} --grpc-web
fi

argocd app sync ${ARGO_APP_NAME} --force --grpc-web