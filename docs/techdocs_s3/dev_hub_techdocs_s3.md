---
layout: default
title: Tech Docs Configuration - AWS S3 (source)
---

# Tech Docs Configuration - AWS S3 (source)

* Make sure that S3 is set up as described in [AWS S3 tech docs (static content) configuration](https://maarten-vandeperre.github.io/developer-hub-documentation/techdocs_s3/infra_setup_techdocs_s3.html)
    * IAM user created that can read and write in S3
    * Bucket 'redhat-demo-dev-hub-1' in region 'eu-west-3'.
* Make sure that the aws client (i.e., cli) is installed and that you logged in with the created user (i.e., run 'aws configure' command).
* Now we'll need to enable the tech docs plugin by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
    plugins:
      - package: ./dynamic-plugins/dist/backstage-plugin-techdocs-backend-dynamic
        disabled: false
        pluginConfig: {}
    ```
* When the dynamic plugin is enabled, we'll need to configure our developer hub instance to read from the correct bucket.
  For that, we have to apply the following yaml to the Developer Hub Config on anchor_02:
    ```yaml
    techdocs:
      builder: external
      generator:
        runIn: local
      publisher:
        type: 'awsS3'
        awsS3:
          bucketName: redhat-demo-dev-hub-1
          credentials:
            accessKeyId: <...>
            secretAccessKey: <...>
          region: eu-west-3
          s3ForcePathStyle: true
          sse: 'AES256'
    ```
* As documentation should not be rendered on the fly (according to the [recommended deployment model](https://backstage.io/docs/features/techdocs/architecture/)),
  we need to make sure that information is fetched by the tech docs plugin (upfront),
  by applying the following yaml to the dynamic plugins configuration (on anchor_03):
```yaml
catalog:
  providers:
   awsS3:
     default: # identifies your dataset / provider independent of config changes
       bucketName: redhat-demo-dev-hub-1
       #prefix: prefix/ # optional
       region: eu-west-3 # optional, uses the default region otherwise
       schedule: # same options as in TaskScheduleDefinition
         # supports cron, ISO duration, "human duration" as used in code
         #frequency: { minutes: 30 }
         frequency: { minutes: 1 }
         # supports ISO duration, "human duration" as used in code
         timeout: { minutes: 3 }
         initialDelay: { seconds: 15 }
```
* Now that we have our config set up, it's time to add/publish our documentation in S3.
  (You can describe the following process in e.g., GitHub actions as well):
    * Create a GIT repository in which you will store your static documentation (over here, a mimic of a GIT repository: [configurations/techdocs/static-content](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/techdocs/static-content)).
    * Static (source) content is available in the [configurations/techdocs/static-content](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/techdocs/static-content/aws-s3/docs) folder.
      Important to note is that these should be **markdown files**.
    * Install [techdocs-cli](https://backstage.io/docs/features/techdocs/cli/)
    * Go to the root of your documentation repository ([configurations/techdocs/static-content](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/techdocs/static-content/aws-s3/docs))
    * Generate the content to be showed in Developer Hub:
      ```shell
      techdocs-cli generate --no-docker --verbose
      ```
      Or run it from the root of this repository:
      ```shell
      techdocs-cli generate --source-dir ./configurations/techdocs/static-content --output-dir ./configurations/techdocs/static-content/aws-s3/site --no-docker --verbose
      ```
    * A folder 'configurations/techdocs/static-content/aws-s3/site' should be created now.
    * Validate that you have an active AWS session by running the following command:
      _(redhat-demo-dev-hub-1)_ should be part of the list.
      ```shell
      aws s3 ls
      ```
    * Publish the static content to the S3 bucket by executing the following command:
      **!! be aware:** If you change the component name (i.e., maartens-first-documentation), make sure that you change it as well
      in catalog-info.yaml and mkdocs.yaml configuration files within the documentation repository, as they are linked to each other by name.
      ```shell
      techdocs-cli publish --publisher-type awsS3 \
            --storage-name redhat-demo-dev-hub-1 \
            --entity default/Component/maartens-first-documentation \
            --directory configurations/techdocs/static-content/aws-s3/site \
            --awsS3sse AES256
      ```
* We now have the configuration and the static content set up. We now only need to add it as a component in Developer Hub:
    * Open Developer Hub.
    * Click "create":
      ![TechDocs]({{site.url}}/assets/images/techdocs/techdocs_add_component.png)
    * Add the URL of the catalog-info.yaml in the URL section (i.e., for me it is [https://github.com/maarten-vandeperre/developer-hub-documentation/blob/main/configurations/techdocs/static-content/aws-s3/catalog-info.yaml](https://github.com/maarten-vandeperre/developer-hub-documentation/blob/main/configurations/techdocs/static-content/aws-s3/catalog-info.yaml)).
    * Click on 'Analyze' and 'Create'.
    * Now go to "Docs" menu item and you should be able to see your documentation:
      ![TechDocs]({{site.url}}/assets/images/techdocs/techdocs_maartens_first_documentation.png)