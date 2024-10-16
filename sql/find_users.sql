SELECT *
FROM (
         SELECT
             left(right(_kind, length(_kind) - 1), length(_kind) - 2) as kind,
             left(right(_namespace, length(_namespace) - 1), length(_namespace) - 2) as namespace,
             left(right(_name, length(_name) - 1), length(_name) - 2) as name,
             left(right(_managed_by_location, length(_managed_by_location) - 1), length(_managed_by_location) - 2) as managed_by_location,
             left(right(_managed_by_origin_location, length(_managed_by_origin_location) - 1), length(_managed_by_origin_location) - 2) as managed_by_origin_location,
             left(right(_source_location, length(_source_location) - 1), length(_source_location) - 2) as source_location,
             *
         FROM (
                  SELECT
                      *,
                      CAST(final_entity::json#>'{kind}' as TEXT) as _kind,
                      CAST(final_entity::json#>'{metadata,name}' as TEXT)  as _name,
                      CAST(final_entity::json#>'{metadata,namespace}' as TEXT)  as _namespace,
                      CAST(final_entity::json#>'{metadata,annotations,backstage.io/managed-by-location}' as TEXT)  as _managed_by_location,
                      CAST(final_entity::json#>'{metadata,annotations,backstage.io/managed-by-origin-location}' as TEXT)  as _managed_by_origin_location,
                      CAST(final_entity::json#>'{metadata,annotations,backstage.io/source-location}' as TEXT)  as _source_location
                  FROM final_entities
              ) as temp1
     ) as temp2
WHERE 1=1 -- dummy where clause to enable the "AND" clauses later on and play with commenting them out
--   AND kind is not null AND kind = 'User'
;