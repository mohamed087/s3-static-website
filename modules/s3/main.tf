# ==================
# S3 Bucket with HTML files
# ==================
resource "aws_s3_bucket" "www" {
  // Our bucket's name is going to be the same as our site's domain name.
  bucket = "${var.www_domain_name}"
  // Because we want our site to be available on the internet, we set this so
  // anyone can read this bucket.
  acl    = "public-read"
  // We also need to create a policy that allows anyone to view the content.
  // This is basically duplicating what we did in the ACL but it's required by
  // AWS. This post: http://amzn.to/2Fa04ul explains why.
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.www_domain_name}/*"]
    }
  ]
}
POLICY

  // S3 understands what it means to host a website.
  website {
    // Here we tell S3 what to use when a request comes in to the root
    // ex. https://www.mys3staticwebsite.tk/
    index_document = "index.html"
    // The page to serve up if a request results in an error or a non-existing
    // page.
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = "${aws_s3_bucket.www.bucket}"
  key          = "index.html"
  source       = "../../html/index.html"
  content_type = "text/html"
  etag         = "${md5(file("../../html/index.html"))}"
  acl          = "public-read"
}

resource "aws_s3_bucket_object" "error" {
  bucket       = "${aws_s3_bucket.www.bucket}"
  key          = "error.html"
  source       = "../../html/error.html"
  content_type = "text/html"
  etag         = "${md5(file("../../html/error.html"))}"
  acl          = "public-read"
}