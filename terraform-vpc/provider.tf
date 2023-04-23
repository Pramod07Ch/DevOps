provider "aws" {
    region  =   "us-east-1"
}

# Values with in the backend config are supplied from the environment specific
terraform {
  backend "s3" {}
}