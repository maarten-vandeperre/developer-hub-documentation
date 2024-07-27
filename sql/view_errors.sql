SELECT entity_id,
       location_key,
       entity_ref,
       errors,
       last_discovery_at AT TIME ZONE 'Europe/Brussels' AS last_discovery_at
FROM refresh_state
-- WHERE last_discovery_at >= NOW() - INTERVAL '15 minutes'
WHERE last_discovery_at AT TIME ZONE 'Europe/Brussels' >= '2024-07-27 12:19:28.943856'
-- WHERE entity_ref = 'system:default/maartens-wonderful-system'
ORDER by last_discovery_at desc
;
-- Last discovery: 2024-07-27 12:13:23.515733
-- ==> only one record per entity_ref, which gets updated. No new record after an update,
-- so keep track of last one to check changes