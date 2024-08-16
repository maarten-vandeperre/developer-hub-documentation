https://github.com/3scale/3scale-operator/blob/3scale-2.9-stable-prod/doc/tenant-reference.md

https://docs.redhat.com/en/documentation/red_hat_3scale_api_management/2.9/html/operating_3scale/provision-threescale-services-via-operator#limitations-capabilities

oc get pod -n demo-project | grep mysql | grep Running
oc port-forward $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}') 3306:3306 -n demo-project

oc exec $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}') \
        -- mysql \
        -u $(oc get secret system-database -n demo-project -o template --template='{{index .data "DB_USER"}}' | base64 -d ; echo) \
        -p$(oc get secret system-database -n demo-project -o template --template='{{index .data "DB_PASSWORD"}}' | base64 -d ; echo) \
        system \
        < ./sql/3scale_data_dump.sql


oc exec $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}') -n demo-project \
        -- mysqldump \
        -u root \
        system \
        > ./sql/3scale_data_dump.sql

user: 3scale-user
user: 3scale-user@demo-organization.com
password: 3scale

admin portal: https://demo-organization-admin.apps.cluster-qqr42.qqr42.sandbox592.opentlc.com