# Managing R53 with Terraform

This repo holds three TF modules: 
1. WEB01 - Deploys a Ubunutu EC2 instance and installs Apache
2. VPC - Creates a VPC and the SG rules to allow inbound HTTP and SSH for the purpose of this demonstration
3. Route53 - Creates a R53 Hosted Zone for demo.infrastructure.2u.com and add an A record for the webserver


