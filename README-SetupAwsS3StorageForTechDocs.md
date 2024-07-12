# AWS S3 Setup For Tech Docs
## Setup
* Go to AWS console and log in
* Create an S3 bucket, in our example 'redhat-demo-dev-hub-1'
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
  * 