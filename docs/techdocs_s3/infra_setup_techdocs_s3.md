---
layout: default
title: AWS S3 infra setup
---

# AWS S3 infra setup

* Go to AWS console and log in
* Create an S3 bucket, in our example 'redhat-demo-dev-hub-1'
    * Region: eu-west-3 (or otherwise, but be aware that if you change this, you'll need to change configuration later on as well).
    * Add bucket policy (i.e., permissions tab)
```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "PublicReadGetObject",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:GetObject",
			"Resource": "arn:aws:s3:::redhat-demo-dev-hub-1/*"
		}
	]
}
```
* Add new user (IAM)
    * username: redhat-demo
    * Add policy: AmazonS3FullAccess
    * Add policy: AmazonS3ReadOnlyAccess
    * Get/generate the access key ID and secret access key

      ![TechDocs](/assets/images/techdocs/aws_s3_techdocs_user.png)

    * Store the accessKeyId and secretAccessKey locally as it will be required (i.e. or in the init_cluster script
      or directly in the secrets/generated/secret_aws_s3_techdocs.yaml file)