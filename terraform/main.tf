terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  alias      = "aws_provider"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token      = var.aws_session_token
  region     = var.aws_region
}

resource "aws_s3_bucket" "s3" {
  bucket   = var.aws_s3_bucket_name
  provider = aws.aws_provider

  tags = {
    Name = "Frontend React App"
  }
}

resource "aws_s3_bucket_website_configuration" "s3_website_configuration" {
  bucket   = var.aws_s3_bucket_name
  provider = aws.aws_provider

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_access_block" {
  bucket   = var.aws_s3_bucket_name
  provider = aws.aws_provider

  block_public_acls = false
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket   = var.aws_s3_bucket_name
  provider = aws.aws_provider

  policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "PublicReadGetObject",
              "Effect": "Allow",
              "Principal": "*",
              "Action": "s3:GetObject",
              "Resource": "arn:aws:s3:::${var.aws_s3_bucket_name}/*"
          }
      ]
    }
  EOF
}

