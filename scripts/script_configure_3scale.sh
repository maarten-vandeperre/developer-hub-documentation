#!/bin/bash

oc rsync \
      ./sql $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}'):/tmp \
      -n demo-project --include 3scale_data_dump.sql

oc exec $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}') -n demo-project \
        -- mysql \
        -uroot \
        system \
        < /tmp/sql/3scale_data_dump.sql