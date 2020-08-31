provider "aws" {
region  = "us-east-1"
}

module "s3" {
  source = "../modules/s3"
}

module "acm" {
  source = "../modules/acm"
}

module "cloudfront" {
  source = "../modules/cloudfront"
}

module "dns" {
  source = "../modules/dns"
}

