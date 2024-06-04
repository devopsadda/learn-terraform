terraform {
  backend "s3" {
    bucket         = "learn2024-terraform-tfstates"
    key            = "demo-app/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "learn2024-dynamodb-tbl"
  }
}
