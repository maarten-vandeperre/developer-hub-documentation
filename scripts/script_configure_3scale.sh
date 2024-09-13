#!/bin/bash

#oc rsync \
#      ./sql $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}'):/tmp \
#      -n demo-project --include 3scale_data_dump.sql
#
#oc exec $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}') -n demo-project \
#        -- mysql \
#        -uroot \
#        system \
#        < /tmp/sql/3scale_data_dump.sql

IMAGE=registry.redhat.io/3scale-amp2/toolbox-rhel8@sha256:dc7936364f5e83652f3b26604f2a9930e9f69841402b134c3799ca0d7862ea05
TENANT=demo-organization
ADMIN_BASE_URL=$(oc get route | grep 3scale | grep 3scale-admin.apps| awk '{print $2}')
MASTER_BASE_URL=$(oc get route | grep 3scale | grep master.apps| awk '{print $2}')

#TENANT_ADMIN_PWD=$(oc get secret system-seed -n demo-project --template={{.data.ADMIN_PASSWORD}} | base64 -d; echo);
#echo "3scale TENANT_ADMIN_PWD: $TENANT_ADMIN_PWD"
TENANT_ADMIN_ACCESS_TOKEN=$(oc get secret system-seed -n demo-project --template={{.data.ADMIN_ACCESS_TOKEN}} | base64 -d; echo);
echo "3scale TENANT_ADMIN_ACCESS_TOKEN: $TENANT_ADMIN_ACCESS_TOKEN"
MASTER_ACCESS_TOKEN=$(oc get secret system-seed -n demo-project --template={{.data.ADMIN_ACCESS_TOKEN}} | base64 -d; echo);
echo "3scale MASTER_ACCESS_TOKEN: $MASTER_ACCESS_TOKEN"

# https://catalog.redhat.com/software/containers/3scale-amp2/toolbox-rhel8/60ddc3173a73378722213e7e
#podman pull --platform=linux/amd64 $IMAGE

#podman rm toolbox-original
#
#podman run --platform=linux/amd64 --name=toolbox-original \
#      $IMAGE 3scale account --help
#

#alias 3scale="podman run $IMAGE 3scale"
#podman run --platform=linux/amd64 --name=toolbox-original \
#      $IMAGE 3scale remote \
#      add $TENANT -k \
#      https://$TENANT_ADMIN_ACCESS_TOKEN@3scale-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com
#
#podman commit toolbox-original toolbox
#alias 3scale="podman run --platform=linux/amd64 toolbox 3scale -k"
#
#echo "remote list:"
#3scale remote list









curl -X POST "https://$MASTER_BASE_URL/admin/api/signup.json" -o ./tmp/signup.json \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "access_token=$MASTER_ACCESS_TOKEN" \
#    -d "access_token=$TENANT_ADMIN_ACCESS_TOKEN" \
    -d "org_name=demo-organization" \
    -d "username=demo-organization_run_3" \
    -d "email=maarten.vandeperre_run_3@redhat.com" \
    -d "password=averysecurepassword"

account_id="$(jq -r .account.id ./tmp/signup.json)"
admin_portal="$(jq -r '.account.links[] | select(.rel == "self") | .href' ./tmp/signup.json)"
echo "Created account has id $account_id"
echo "Created account has admin portal $admin_portal"

#curl -skf -X POST "$ADMIN_PORTAL/admin/api/accounts/$account_id/applications.json" \
#     -o /tmp/app.json \
#     --data-urlencode "access_token=$TOKEN" \
#     --data-urlencode "plan_id=$APPLICATION_PLAN_ID" \
#     --data-urlencode "name=test app" \
#     --data-urlencode "description=used for tests"
#
#apikey="$(jq -r .application.user_key /tmp/app.json)"
#echo "Created application has api key $apikey"