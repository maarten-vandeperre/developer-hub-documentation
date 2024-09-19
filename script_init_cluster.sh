#!/bin/bash

fast_waiting_times="no"

# Function definitions
      # Function to check the status of all operators in the specified namespace
      check_operators_status() {
        local namespace=$1
        local statuses

        # Get the status of all operators in the namespace
        statuses=$(oc get csv -n "$namespace" -o jsonpath='{.items[*].status.phase}')

        # Check if any operator is failing
        if echo "$statuses" | grep -q "Failed"; then
          echo "Error: One or more operators are in a failed state."
          exit 1
        fi

        # Check if all operators have succeeded
        if echo "$statuses" | grep -qv "Succeeded"; then
          return 1
        fi

        return 0
      }


# Check if Podman is installed
if ! command_exists podman; then
    echo "Podman is not installed."
    echo "Please install Podman first by following the instructions at: https://podman.io/getting-started/installation"
    exit 1
fi

# Check if Podman is running
if ! podman info >/dev/null 2>&1; then
    echo "Podman is installed but not running."
    echo "Please start Podman before running this script. For example, on some systems you can use:"
    echo "  systemctl start podman"
    echo "Or consult your platform's documentation."
    exit 1
fi

echo "Podman is installed and running."

echo "Do podman log in into registry.redhat.io"
podman login registry.redhat.io

read -p "Which storage provider for static tech docs do you want to use? (aws-s3/minio-s3)? " techdocs_storage_provider
read -p "Did you already generate the secret config maps? (yes/no): " secrets_generated
# Convert the input to lowercase
secrets_generated=$(echo "$secrets_generated" | tr '[:upper:]' '[:lower:]')


./scripts/script_prepare_repository.sh
oc apply -f gitops/namespaces.yaml
oc apply -f gitops/operator-groups.yaml

oc apply -f gitops/tekton/tekton-service-account.yaml

oc apply -f gitops/minio/minio-persistent-volume-claim.yaml

# Check if the secrets are already generated
if [ "$secrets_generated" = "no" ]; then
  echo "start generating the secret config maps"

  # Convert the input to lowercase
  techdocs_storage_provider=$(echo "$techdocs_storage_provider" | tr '[:upper:]' '[:lower:]')

  if [ "$techdocs_storage_provider" = "aws-s3" ]; then
    echo "Executing shell scripts (to configure S3)..."
    ./scripts/script_configure_aws_s3.sh
    ./scripts/script_enable_aws_techdocs_config.sh
    oc apply -f secrets/generated/secret_aws_s3_techdocs.yaml
  elif [ "$techdocs_storage_provider" = "minio-s3" ]; then
    ./scripts/script_enable_minio_techdocs_config.sh
  else
    ./scripts/script_disable_aws_techdocs_config.sh
    ./scripts/script_disable_minio_techdocs_config.sh
    echo "$techdocs_storage_provider not supported." >&2
    exit 1
  fi

  echo "configuring GitHub integration..."
  ./scripts/script_configure_github_integration.sh

  echo "End configurations"
else
  echo "No action needed, regarding the secret config maps."
  if [ "$techdocs_storage_provider" = "aws-s3" ]; then
      echo "Executing shell scripts (to configure S3 secrets)..."
      oc apply -f secrets/generated/secret_aws_s3_techdocs.yaml
  fi
fi

  oc apply -f secrets/generated/secret_github_integration.yaml

echo "Waiting for configurations to apply"
to_sleep=$( [ "$fast_waiting_times" = "yes" ] && echo 10 || echo 300 )
sleep "$to_sleep"

# operators
echo "Install operators"
oc apply -f gitops/keycloak/keycloak-operator.yaml
oc apply -f gitops/developer-hub/00_developer-hub-operator.yaml
oc apply -f gitops/argocd/argocd-operator.yaml
oc apply -f gitops/tekton/tekton-operator.yaml
oc apply -f gitops/3scale/3scale-operator.yaml
oc apply -f gitops/kafka/kafka-operator.yaml
oc apply -f gitops/openshift-ai/openshift-ai-operator.yaml

# minio
echo "Install Minio"
oc apply -f gitops/minio/minio-deployment.yaml
oc apply -f gitops/minio/minio-service.yaml
oc apply -f gitops/minio/minio-route.yaml

#Jenkins
echo "Install Jenkins"
sh scripts/script_install_jenkins.sh

echo "sleep for operators to get ready"
to_sleep=$( [ "$fast_waiting_times" = "yes" ] && echo 120 || echo 300 )
sleep "$to_sleep"

#TODO enable this instead of hard coded sleep
#NAMESPACE="demo-project"
#TIMEOUT=600 # Timeout after 10 minutes (600 seconds)
#SLEEP_INTERVAL=5
#echo "Checking the status of operators in the namespace '$NAMESPACE'..."
#START_TIME=$(date +%s)
#while true; do
#  if check_operators_status "$NAMESPACE"; then
#    echo "All operators have succeeded."
#    exit 0
#  else
#    CURRENT_TIME=$(date +%s)
#    ELAPSED_TIME=$((CURRENT_TIME - START_TIME))
#    if [ "$ELAPSED_TIME" -ge "$TIMEOUT" ]; then
#      echo "Error: Timeout reached. Not all operators have succeeded."
#      exit 1
#    fi
#    echo "Not all operators have succeeded yet. Checking again in $SLEEP_INTERVAL seconds..."
#    sleep $SLEEP_INTERVAL
#  fi
#done


# batch 1 (i.e. databases and pre-configurations)

  # minio
  echo "Configuring Minio default content"
  sh scripts/script_configure_minio.sh

  # keycloak
  echo "Configuring Keycloak database"
  oc apply -f gitops/keycloak/keycloak-postgres.yaml

  # 3scale
  echo "Configuring 3scale API manager prerequisites"
  oc apply -f gitops/3scale/3scale-storage-config.yaml
  oc apply -f gitops/3scale/3scale-storage-credentials.yaml
  sh scripts/script_configure_3scale_docker.sh
  oc apply -f gitops/3scale/3scale-secret-registry-auth.yaml
  # data init/config
  oc apply -f gitops/3scale/3scale-tenant-secret.yaml
  echo "Configuring 3scale API manager"
  oc apply -f gitops/3scale/3scale-api-manager.yaml

  # tekton
  echo "Configuring Tekton PVCs"
  oc apply -f gitops/tekton/tekton-persistence-volume-claim-app-source.yaml
  oc apply -f gitops/tekton/tekton-persistence-volume-claim-gradle-cache.yaml

  # argocd
  echo "Configuring Argo CD instance"
  oc apply -f gitops/argocd/argocd-instance.yaml

  # openshift ai
  echo "Configuring OpenShift AI Data Science Cluster"
  oc apply -f gitops/openshift-ai/openshift-ai-datascience-cluster.yaml

  # developer hub
  echo "Configuring Developer Hub basic instance"
  oc apply -f .helper/31_developer-hub-instance-simple.yaml   # do this first, without config map links to init the database, without migration table lock issues
                                                              # TODO this bug should be solved, should not be required

  echo "Configuring Developer Hub config maps"
  oc apply -f gitops/developer-hub/01_secret.yaml
  oc apply -f gitops/developer-hub/11_app-config-rhdh.yaml
  oc apply -f gitops/developer-hub/21_dynamic-plugins-rhdh.yaml

echo "sleep for batch 1 to get ready"
to_sleep=$( [ "$fast_waiting_times" = "yes" ] && echo 180 || echo 300 )
sleep "$to_sleep"

# batch 2 (i.e. instances)

  # argocd
  echo "Configuring Argo CD - simple hello world"
  oc apply -f gitops/argocd/argocd-application-simple-hello-world.yaml


  #Tekton
  echo "Install Tekton SA"
  sh scripts/script_configure_tekton_integration.sh
  oc apply -f secrets/generated/secret_tekton.yaml

  # tekton
  echo "Configuring Tekton pipelines"
  oc apply -f gitops/tekton/tekton-pipeline-simple-hello-world.yaml

  # keycloak
  echo "Configuring Keycloak instance"
  oc apply -f gitops/keycloak/keycloak-instance.yaml

  # 3scale
  echo "Configuring 3scale tenant"
  oc apply -f gitops/3scale/3scale-demo-organization-tenant.yaml

echo "sleep for batch 2 to get ready"
to_sleep=$( [ "$fast_waiting_times" = "yes" ] && echo 180 || echo 300 )
sleep "$to_sleep"

# batch 3 (i.e. configs)

  # keycloak
  echo "Configuring Keycloak realm"
  oc apply -f gitops/keycloak/keycloak-realm.yaml

  # tekton
  echo "Configuring Tekton pipeline runs"
  oc apply -f gitops/tekton/tekton-pipeline-run-simple-hello-world.yaml

  # 3scale
  echo "Configuring 3scale tenant config"
  oc apply -f gitops/3scale/3scale-backend-api.yaml
  oc apply -f gitops/3scale/3scale-product-product-a.yaml
  oc apply -f gitops/3scale/3scale-activedoc-people-api.yaml
  oc apply -f gitops/3scale/3scale-api-spec-people-api.yaml

echo "sleep for batch 3 to get ready"
to_sleep=$( [ "$fast_waiting_times" = "yes" ] && echo 180 || echo 300 )
sleep "$to_sleep"

# batch 4

  # keycloak
  echo "Configuring Keycloak integration"
  ./scripts/script_configure_keycloak_integration.sh
  # keycloak
  echo "Configuring ArgoCD integration"
  ./scripts/script_configure_argocd_integration.sh

  # keycloak
  oc apply -f secrets/generated/secret_keycloak_rhdh_client.yaml

  # argocd
  oc apply -f secrets/generated/secret_argocd.yaml

  # 3scale
  echo "Configuring 3scale secrets"
  sh scripts/script_configure_3scale_integration.sh
  oc apply -f secrets/generated/secret_3scale_rhdh_client.yaml

  # developer hub
  echo "Configuring Developer Hub"
  oc apply -f gitops/developer-hub/31_developer-hub-instance.yaml

echo
echo "Routes:"
oc get route -n demo-project | grep backstage
echo
echo

echo
echo "Done"
echo
echo
oc get pods -n demo-project -w