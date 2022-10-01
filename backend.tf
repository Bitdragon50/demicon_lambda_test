terraform {
  backend "s3" {
    bucket = "tf-state-bucket-6542"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

