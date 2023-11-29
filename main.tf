resource "aws_s3_bucket" "main" {
  bucket = "s3-data-guardduty-state"
  acl    = "private"

  tags = {
    Environment = "Dev"
  }
}

module "sns-guardduty-clouwatch" {
  source = "./module/guardduty"
  name-sns = "sns-guardduty-cloudwatch"
  email-notification = "manassehsuccess0@gmail.com"
}