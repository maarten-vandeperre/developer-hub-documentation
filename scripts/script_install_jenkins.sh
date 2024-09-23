# !/bin/bash
#based upon: https://github.com/MoOyeg/rhdh-infra-sample/blob/main/jenkins/deploy/deploy-script.sh
JENKINS_NAMESPACE=demo-project
NAMESPACE_DEV=demo-project
APP_NAME=demo-app

#oc apply -f gitops/jenkins/jenkins-ephemeral-deployment.yaml
oc process -f gitops/jenkins/jenkins-ephemeral-deployment.yaml | oc apply -f - -n ${JENKINS_NAMESPACE}
oc policy add-role-to-user edit system:serviceaccount:$JENKINS_NAMESPACE:jenkins -n $NAMESPACE_DEV
oc policy add-role-to-user edit system:serviceaccount:$JENKINS_NAMESPACE:default -n $NAMESPACE_DEV

export JENKINS_BASE_IMAGE=registry.redhat.io/ocp-tools-4/jenkins-rhel8@sha256:4fde63beca6a90263f16abe7509fe584de8e2646f5e9f99ee3580427530c9a01
export PYTHON_DOCKERFILE=$(cat gitops/jenkins/jenkins-installation-containerfile | envsubst )
oc new-build --strategy=docker -D="$PYTHON_DOCKERFILE" --name=python-jenkins -n $JENKINS_NAMESPACE
echo """
apiVersion: build.openshift.io/v1
kind: BuildConfig
metadata:
  name: "$APP_NAME-pipeline"
  namespace: $JENKINS_NAMESPACE
spec:
  source:
    git:
      ref: main
      uri: 'https://github.com/maarten-vandeperre/jenkins-demo.git'
    type: Git
  strategy:
    type: "JenkinsPipeline"
    jenkinsPipelineStrategy:
      jenkinsfilePath: Jenkinsfile
""" | oc create -f -

oc set env bc/$APP_NAME-pipeline -n $JENKINS_NAMESPACE \
    --env=JENKINS_NAMESPACE=$JENKINS_NAMESPACE \
    --env=REPO="https://github.com/maarten-vandeperre/jenkins-demo.git" \
    --env=DEV_PROJECT=$NAMESPACE_DEV --env=APP_NAME=$APP_NAME \
    --env=BRANCH=main

echo -e "Will wait for Sample App Jenkins Agent Base Image to be Built, Can take up to 6 mins\n"
buildno=$(oc get bc/python-jenkins -n ${JENKINS_NAMESPACE} -o jsonpath='{.status.lastVersion}')
oc wait --for=jsonpath='{.status.phase}'="Complete" Build/python-jenkins-${buildno} --allow-missing-template-keys=true --timeout=420s -n ${JENKINS_NAMESPACE};
oc start-build $APP_NAME-pipeline -n ${JENKINS_NAMESPACE}
