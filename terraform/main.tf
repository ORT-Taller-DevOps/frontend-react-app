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
  profile    = var.aws_profile
}

resource "aws_s3_bucket" "s3" {
  bucket   = var.aws_s3_bucket_name
  provider = aws.aws_provider

  tags = {
    Name = "Frontend React App"
  }
}

