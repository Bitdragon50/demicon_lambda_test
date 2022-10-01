terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"      
    }

    archive = {
      source = "hashicorp/archive"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}


provider "archive" {
  # Configuration options
}