provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-up-and-running-state-esb"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

#resource "aws_iam_user" "example" {
#  count = length(var.user_names)
#  name  = var.user_names[count.index]
#}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch_full_access" {
  count      = var.give_neo_cloudwatch_full_access ? 1 : 0
  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch_read_only" {
  count      = var.give_neo_cloudwatch_full_access ? 0 : 1
  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
}
