get token 
    secret: pipeline-token-xxxxx
    value: token



oc create serviceaccount backstage-sa -n my-namespace


oc adm policy add-role-to-user view -z pipeline -n demo-project

oc create token pipeline -n demo-project