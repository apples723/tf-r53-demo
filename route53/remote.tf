data  "terraform_remote_state" "web01" {
    backend = "s3"
    config = { 
        bucket = "2u-terraform"
        key = "it/sandbox/r53_demo/web01.tfstate"
        region = "us-east-1"
    }
}
data  "terraform_remote_state" "web03" {
    backend = "s3"
    config = { 
        bucket = "2u-terraform"
        key = "it/sandbox/r53_demo/web03.tfstate"
        region = "us-east-1"
    }
}