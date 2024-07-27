oc get pod -n demo-project | grep backstage-psql | awk '{print $1}'
oc port-forward $(oc get pod -n demo-project | grep backstage-psql | awk '{print $1}') 5432:5432 -n demo-project
db user (root): postgres
oc get secret backstage-psql-secret-developer-hub -n demo-project  -o template --template='{{.data.POSTGRES_USER}}' | base64 -d ; echo
db user pwd:
oc get secret backstage-psql-secret-developer-hub -n demo-project  -o template --template='{{.data.POSTGRESQL_ADMIN_PASSWORD}}' | base64 -d ; echo
database name:
backstage_plugin_catalog



InputError message:

Policy check failed for system:default/maartens-wonderful-system; 
caused by Error: \"tags.0\" is not valid; expected a string that is sequences of [a-z0-9+#] 
separated by [-], at most 63 characters in total but found \"AI/ML\". 
To learn more about catalog file format, visit: https://github.com/backstage/backstage/blob/master/docs/architecture-decisions/adr002-default-catalog-file-format.md
