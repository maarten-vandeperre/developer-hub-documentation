https://backstage.io/docs/features/software-templates/builtin-actions/
https://backstage.io/docs/features/software-templates/

https://backstage-developer-hub-demo-project.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com/create/actions

https://github.com/backstage/software-templates/blob/main/scaffolder-templates/create-react-app/template.yaml

create personal access token for GitHub


Token scopes
When creating a personal access token on GitHub, you must select scopes to define the level of access for the token. The scopes required vary depending on your use of the integration:

Reading software components:
    repo
Reading organization data:
    read:org
    read:user
    user:email
Publishing software templates:    <==
    repo
    workflow (if templates include GitHub workflows)