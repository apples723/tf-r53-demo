module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77"

  name = "r53-demo-vpc"
  cidr = "192.168.10.0/24"  
  azs = ["us-west-2a"]
  public_subnets  = ["192.168.10.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
      "Enviornment" = "Sandbox"
  }
}

resource "aws_security_group" "webserver" {
  name        = "ssh_http"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = module.vpc.vpc_id
ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
output "vpc_id" {
    value = module.vpc.vpc_id
  
}
output "public_subnet" {
    value = module.vpc.public_subnets
}
output "http_ssh_sg" {
    value = aws_security_group.webserver.id
}
