---
layout: default
title: Dev hub integration: Tekton
---

# Dev hub integration: Tekton

* Make sure that Jenkins is set up as described in [Jenkins Installation Guide](https://maarten-vandeperre.github.io/developer-hub-documentation/jenkins/infra_setup_jenkins.html)
    * Get admin organization of the tenant you want to connect: https://demo-organization-maarten-admin.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com
    * Username: admin
    * Password: rhdh
    * Job name: demo-project/demo-app-pipeline
* Now we are going to configure the Jenkins integration
  within Developer Hub. In order to do so,
  we need to:
  * Enable the dynamic plugin for Jenkins by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
      plugins:
        - package: ./dynamic-plugins/dist/backstage-plugin-jenkins-backend-dynamic
          # documentation: https://www.npmjs.com/package/@backstage-community/plugin-jenkins-backend
          disabled: false
        - package: ./dynamic-plugins/dist/backstage-plugin-jenkins
          disabled: false
    ```
  * Apply the following yaml to the Developer Hub config (on anchor_03):
    ```yaml
    jenkins:
      instances:
        - name: default-jenkins
          baseUrl: https://jenkins-demo-project.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com/
          username: admin
          apiKey: rhdh
    ```
  * Now that the Jenkins plugin is active, you'll need to link it to a component. throughout this example, we will use the component defined over here:
  [https://github.com/maarten-vandeperre/dev-hub-test-demo](https://github.com/maarten-vandeperre/dev-hub-test-demo), the 
  [catalog-info.yaml](https://github.com/maarten-vandeperre/dev-hub-test-demo/blob/master/catalog-info.yaml)
  more in particular.
  In that catalog-info file, you will need to add the following annotations:
    * jenkins.io/job-full-name: default-jenkins:demo-project/demo-project-demo-app-pipeline
      * jenkins.io/job-full-name: the annotation name to activate the Jenkins plugin for this component.
      * default-jenkins: the name of the Jenkins instace you defined in the Developer Hub app config
      * demo-project/demo-project-demo-app-pipeline: build name, which can be taken from the build detail URL:  
      <img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/jenkins_3.png" class="large">  

_If you now go to the CI tab on the component detail, you'll be able to see jenkins details:._
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/jenkins_4.png" class="large">
