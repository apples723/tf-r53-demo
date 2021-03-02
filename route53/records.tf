#creates a A record for web01.demo.infrastructure.2u.com
resource "aws_route53_record" "ue1web01" {
  zone_id = aws_route53_zone.delegated.zone_id #zone id of demo.infrastructure.2u.com
  name    = "web01.demo.infrastructure.2u.com"
  type    = "A"
  ttl     = "30"
  records = [data.terraform_remote_state.web01.outputs.eip] 
}