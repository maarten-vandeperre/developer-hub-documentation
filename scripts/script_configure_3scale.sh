#!/bin/bash

oc exec $(oc get pod -n demo-project | grep mysql | grep Running | awk '{print $1}') -n demo-project \
        -- mysql \
        -u root \
        system \
        < ./sql/3scale_data_dump.sql