#!/bin/bash
#https://docs.openshift.com/container-platform/4.16/cicd/jenkins/images-other-jenkins.html

JENKINS_USER="admin"
JENKINS_PASSWORD="rhdh"

oc new-app -e JENKINS_PASSWORD=rhdh ocp-tools-4/jenkins-rhel8

# Create a secret to store the Jenkins admin password
oc create secret generic jenkins-secret \
    --from-literal=JENKINS_USER=$JENKINS_USER \
    --from-literal=JENKINS_PASSWORD=$JENKINS_PASSWORD

# Deploy Jenkins using the OpenShift template
oc new-app jenkins-ephemeral \
  -p MEMORY_LIMIT=2Gi \
  -p DISABLE_ADMINISTRATIVE_MONITORS=true

# Wait for the Jenkins DeploymentConfig to be created
sleep 10

# Set the environment variables in the Jenkins DeploymentConfig
oc set env dc/jenkins --from=secret/jenkins-secret

# Expose the Jenkins service to create a route
oc expose svc/jenkins

# Get the Jenkins URL
JENKINS_URL=$(oc get route jenkins -o jsonpath='{.spec.host}')

echo "Jenkins is now accessible at: http://$JENKINS_URL"
echo "Admin username: $JENKINS_USER"
echo "Admin password: $JENKINS_PASSWORD"
