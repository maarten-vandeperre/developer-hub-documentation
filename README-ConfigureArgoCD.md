oc get secret argocd-instance-cluster -n demo-project -o template --template='{{index .data "admin.password"}}' | base64 -d ; echo

no default empty config on dynamic plugin
disable TLS on global level


https://argocd-instance-server-demo-project.apps.cluster-djr6p.djr6p.sandbox1644.opentlc.com/api/v1/session
https://argocd-instance-server-demo-project.apps.cluster-djr6p.djr6p.sandbox1644.opentlc.com/api/v1/settings
https://github.com/argoproj/argo-cd/blob/master/assets/swagger.json



rht-gitops.com/demo-project=simple-hello-world-service-a