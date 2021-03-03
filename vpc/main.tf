#Tell terraform what cloud provider we are using. 
provider "aws" {
  region              = "us-west-2"
  #tells terraform we want to use the sandbox account
  assume_role {
    role_arn = "arn:aws:iam::376426587433:role/ITInfrastructure-Team-Sandbox"
  }
}
#configures terraform specific settings
terraform {
  #tells terraform we want to keep our statefile in S3
  backend "s3" {
    bucket = "2u-terraform"
    region = "us-east-1"
    key    = "it/sandbox/r53_demo/vpc.tfstate"
  }
}
