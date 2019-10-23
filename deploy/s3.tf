resource "aws_s3_bucket" "xero_quotes_application" {
  bucket = "xero-quotes-application"

  tags {
    Name        = "xero-quotes-application - beanstalk-vpc"
    Environment = "development"
  }
}
