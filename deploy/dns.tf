data "aws_route53_zone" "xero_net" {
  name = "xerosoft.net"
}

resource "aws_route53_record" "quotes" {
  zone_id = "${data.aws_route53_zone.xero_net.id}"
  name    = "quotes.xerosoft.net"
  type    = "A"

  alias {
    name                   = "${aws_elastic_beanstalk_environment.quotes_application_dev_environment.cname}"
    evaluate_target_health = false
    zone_id                = "${data.aws_elastic_beanstalk_hosted_zone.current.id}"
  }
}
