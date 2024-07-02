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
  profile = "default"
  region  = "us-east-1"
}

variable "S3_UUID" {
  type = string
}

resource "aws_s3_bucket" "s3" {
  bucket = var.S3_UUID 

  tags = {
    Name = "Frontend React App"
  }
}

