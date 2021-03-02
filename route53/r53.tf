#creates a r53 hosted zone for the "delegated domain" of the AWS account
#in the case of this demo it's "demo.infrastructure.2u.com"
#in production it's infrastructure.2u.com(or a sub domain prod/dev)
resource "aws_route53_zone" "delegated" {
  name = var.delegated_domain

  tags = {
    Name = "demo.infrastructure.2u.com"
    description = "creates deligated stub zone for demo subdomain"
  }
}

#creates a NS record in the host zone of the tld in a different account
#in this case it creates NS recoreds for demo.infrastructure.2u.com pointing to the NS records our delegated domain zone
#in production it creates NS records in the 2u.com zone in the main-account for infrastructure.2u.com
#having ns records in the tld zone allows managment of subdomains in a hosted zone in the same or different aws account

resource "aws_route53_record" "delegated_zone_ns" {
  provider = aws.inf_sub #uses sub account where the hosted zone for infrastructure.2u.com is

  zone_id = var.inf_twou_zone_id
  name    = var.delegated_domain
  type    = "NS"
  ttl     = "30"

  records = [
    aws_route53_zone.delegated.name_servers[0],
    aws_route53_zone.delegated.name_servers[1],
    aws_route53_zone.delegated.name_servers[2],
    aws_route53_zone.delegated.name_servers[3],
  ]
}
