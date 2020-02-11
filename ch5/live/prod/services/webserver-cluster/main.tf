provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source                 = "../../../../modules/services/webserver-cluster"
  cluster_name           = var.cluster_name
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key
  instance_type          = "m4.large"
  min_size               = 2
  max_size               = 10
  enable_autoscaling     = true
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
