provider "aws" {
    region = "us-east-1"
    assume_role {
        role_arn = "arn:aws:iam::376426587433:role/ITInfrastructure-Team-Sandbox"
    }
}

provider "aws" {
    region = "us-east-1"
    assume_role {
      role_arn = "arn:aws:iam::731933753003:role/OrganizationAccountAccessRole"
    }
    alias = "inf_sub"
}

terraform {
  backend "s3" {
      bucket = "2u-terraform"
      region = "us-east-1"
      key = "it/sandbox/r53_demo/r53.tfstate"

  }
}