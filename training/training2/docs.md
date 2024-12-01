* install namespace openshift-gitops-operator
* install the operator group
* oc apply -f gitops/argocd/argocd-operator.yaml and wait for a while
* oc apply -f gitops/argocd/argocd-instance.yaml 
* get admin password: oc get secret argocd-instance-cluster -n demo-project -o template --template='{{index .data "admin.password"}}' | base64 -d ; echo
* oc apply -f gitops/argocd/argocd-application-simple-hello-world.yaml