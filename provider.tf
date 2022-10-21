provider "aws" {
    region = "eu-west-2"
    access_key = ""
    secret_key = ""
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}