---
layout: default
title: Infra setup: jenkins
---

# Infra setup: Jenkins
Jenkins is a popular open-source automation server that helps automate various stages of the software development lifecycle, including building, 
testing, and deploying applications. It supports numerous plugins, enabling integration with a wide range of tools, making it highly customizable for 
continuous integration (CI) and continuous delivery (CD) workflows. Jenkins allows teams to streamline development processes, ensuring faster releases with 
improved code quality.    
  
  
Running Jenkins on OpenShift is beneficial because OpenShift provides a scalable, containerized environment, allowing Jenkins to run as a container. 
OpenShift also manages resource allocation, auto-scaling, and high availability, which ensures that Jenkins can handle fluctuating workloads efficiently. 
Additionally, OpenShift’s security features, such as built-in role-based access control (RBAC), enhance the security of Jenkins pipelines in enterprise 
environments.    



In this section we will install Jenkins on OpenShift.

## Installation
To install Jenkins on OpenShift, you won't need too much documentation, as I only did it via scripting, not manually 
(i.e., a good engineer needs to be lazy, so they say...). in order to do so, you can run [scripts/script_install_jenkins.sh](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/scripts/script_install_jenkins.sh).
  
You then should be able to log in to jenkins on url:
```shell
oc get route -n demo-project | grep jenkins | awk '{print $2}'
```

For me, it is: jenkins-demo-project.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com.  

And you can use the following credentials:
* username: admin
* password: rhdh
  
When logging in, you should see one job in the job list:
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/jenkins_1.png" class="large">  
  
With one or multiple job runs:
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/jenkins_2.png" class="large">  

**!!! important:** Note the name "demo-project/demo-app-pipeline" as you will need it in the Developer Hub configuration afterwards.
