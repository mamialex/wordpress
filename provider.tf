provider "aws" {
    region = "eu-west-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "tf-state-alexandra-wordpress"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}