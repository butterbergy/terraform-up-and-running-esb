provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source                 = "../../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "(YOUR_BUCKET_NAME)"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
  instance_type          = "m4.large"
  min_size               = 2
  max_size               = 10
  enable_autoscaling     = true
  enable_new_user_data   = false
  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-up-and-running-state-esb"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
