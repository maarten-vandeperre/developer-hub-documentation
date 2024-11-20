---
layout: default
title: ArgoCD infra setup
---

# ArgoCD infra setup
Argo CD is a declarative, GitOps-based continuous delivery (CD) tool for Kubernetes. It ensures that the desired state of applications,
as defined in Git repositories, is automatically synchronized with the actual state of the Kubernetes clusters.
Argo CD provides real-time monitoring, automated rollbacks, and drift detection, making it ideal for managing complex,
multi-cluster Kubernetes environments. Its intuitive UI and robust API enable teams to manage deployments efficiently and ensure consistent, repeatable processes.



Running Argo CD on OpenShift is beneficial because OpenShift’s Kubernetes foundation aligns with Argo CD’s GitOps model.
OpenShift's built-in security, including role-based access control (RBAC) and policy management, enhances the security of Argo CD deployments.
Additionally, OpenShift’s support for scalable, containerized workloads makes it easier to manage the lifecycle of applications, ensuring that
Argo CD can effectively handle the automation of continuous delivery pipelines in production environments.



In this section we will install ArgoCD on OpenShift.

## Installation
In order to install and configure ArgoCD on OpenShift you will need to execute the following steps, as you can find back in the default
[script_init_cluster.sh](https://github.com/maarten-vandeperre/developer-hub-documentation/blob/main/script_init_cluster.sh) script:
* Install the operator:
  * oc apply -f gitops/argocd/argocd-operator.yaml
* Start an instance:
  * oc apply -f gitops/argocd/argocd-instance.yaml
* Configure and apply the secret
  * sh scripts/script_configure_argocd_integration.sh
  * oc apply -f secrets/generated/secret_argocd.yaml
* Create an ArgoCD managed application
  * oc apply -f gitops/argocd/argocd-application-simple-hello-world.yaml

You then should be able to see ArgoCD and the ArgoCD application in OpenShift & ArgoCD:
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/argocd_1.png" class="large">
_Or, as in my case, when I configured ArgoCD, there went something wrong, so I have to navigate to ArgoCD through routes > ArgoCD route._

credentials:
* username: admin
* password: defined in secretes/generated/secret_argocd.yaml, when you executed the script script_configure_argocd_integration.

<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/argocd_2.png" class="large">

**!!! Important:** Check that the label is set in the ArgoCD configuration (i.e., within gitops/argocd/argocd-application-simple-hello-world.yaml)
(for me, simple-hello-world-service-a), as you will need it in the Developer Hub configuration:
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/argocd_3.png" class="large">