# Create token for jenkins role in argocd
ARGOCD_AUTH_TOKEN=$(argocd proj role create-token apps2deploy jenkins-deploy --token-only)
