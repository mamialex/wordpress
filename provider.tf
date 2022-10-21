provider "aws" {
    region = "eu-west-2"
    access_key = "AKIA3YXER6ABHE7B62S3"
    secret_key = "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"
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}