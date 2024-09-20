---
layout: default
title: Debug Developer Hub
---

# Debug Developer Hub

## Check logs
* Developer Hub instance log:  
Operators > Installed Operators > Red Hat Developer Hub Operator > Red Hat Developer Hub > select instance > check events / error messages
* Developer Hub pod log:  
Deployments > Developer Hub deployment > pods > select pod > check logs

## Check database

Not all error messages are popping up in the console log of the developer hub pods. In case you want to
view them or in case you want to see when a configuration got reloaded by developer hub, you can make use
of the underlying database.

In order to do so, you'll first need to enable port-forwarding to the postgres database:
```shell
oc port-forward $(oc get pod -n demo-project | grep backstage-psql | awk '{print $1}') 5432:5432 -n demo-project
```

Then you will need to fetch the root user and its password to connect to the database:
```shell
oc get secret backstage-psql-secret-developer-hub -n demo-project  -o template --template='{{.data.POSTGRES_USER}}' | base64 -d ; echo
oc get secret backstage-psql-secret-developer-hub -n demo-project  -o template --template='{{.data.POSTGRESQL_ADMIN_PASSWORD}}' | base64 -d ; echo
```

The database to be connected to, will be "backstage_plugin_catalog". If you're using IntelliJ,
it will look like this:
![](https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/dev-hub-postgres-creation.png "")

Now that we have a database connection, let's see how to request the possible errors and the
reloading timestamps for the integrations (i.e., I use it as well during integration development to
validate when an update is processed).

You can run following query (or execute the [view logs script](sql/view_errors.sql)):
```sql
SELECT entity_id,
       location_key,
       entity_ref,
       errors,
       last_discovery_at AT TIME ZONE 'Europe/Brussels' AS last_discovery_at
FROM refresh_state
WHERE 1=1 -- dummy where clause to enable the "AND" clauses later on and play with commenting them out
-- AND last_discovery_at >= NOW() - INTERVAL '15 minutes'
AND last_discovery_at AT TIME ZONE 'Europe/Brussels' >= '2024-07-27 12:19:28.943856'
-- AND entity_ref = 'system:default/maartens-wonderful-system'
ORDER by last_discovery_at desc
;
-- Last discovery: 2024-07-27 12:13:23.515733
-- ==> only one record per entity_ref, which gets updated. No new record after an update,
-- so keep track of last one to check changes
```

Output will look like this:
![](images/dev-hub-postgres-follow-up.png "")

If you want to experiment with it yourself, you can uncomment the line with _"#    - AI/ML #TODO enable this line if you want to try to debug for errors"_
within the catalog entities file [configurations/catalog-entities/systems/maartens-wonderful-system.yaml](configurations/catalog-entities/systems/maartens-wonderful-system.yaml).

You then should have the following error:
![](images/dev-hub-postgres-debug-errors.png "")

Full error message:

```text
Policy check failed for system:default/maartens-wonderful-system; 
caused by Error: \"tags.0\" is not valid; expected a string that is sequences of [a-z0-9+#] 
separated by [-], at most 63 characters in total but found \"AI/ML\". 
To learn more about catalog file format, visit: https://github.com/backstage/backstage/blob/master/docs/architecture-decisions/adr002-default-catalog-file-format.md
```