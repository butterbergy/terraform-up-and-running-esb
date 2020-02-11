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
