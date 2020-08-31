#### =========================================
#### Static website backed by an S3 bucket in AWS.
#### By using Terraform
#### =========================================

We will create a website and serve the static contents using AWS S3 in a much simpler way. 

Explanation of the Infrastructure diagram

1. All the static files would be present in s3 bucket

2. Cloudfront would act as CDN and serve the contents of the s3 bucket using https

3. Certificate Manager will provide the SSL certificates to Cloudfront and manages (renews in expiration) for us

4. Route53 manages all our DNS records and sets A record to point to Cloudfront distribution

5. Domain Registrars will point the domain name to AWS Nameservers

![diagram](https://user-images.githubusercontent.com/68518124/91770285-c53d3a00-eb95-11ea-8a89-9d9c7e7a3832.png)

