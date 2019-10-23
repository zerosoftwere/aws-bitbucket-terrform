resource "aws_elastic_beanstalk_application" "quotes_application" {
  name        = "quotes-application"
  description = "demo-bean-stalk-application"
}

resource "aws_elastic_beanstalk_environment" "quotes_application_dev_environment" {
  name                = "development"
  application         = "${aws_elastic_beanstalk_application.quotes_application.name}"
  solution_stack_name = "${var.SOLUTION_STACK_NAME}"
  cname_prefix        = "xero-quotes-application"

  tags {
    Name = "quotes-application"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${aws_vpc.beanstack_vpc.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.beanstack_subnet.id}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${aws_security_group.beanstalk_security_group.id}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${aws_key_pair.sshkey.key_name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = "postgres"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = "password"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = "myhosthere"
  }
}

data "aws_elastic_beanstalk_hosted_zone" "current" {}

output "endpoint_url" {
  value = "${aws_elastic_beanstalk_environment.quotes_application_dev_environment.endpoint_url}"
}
