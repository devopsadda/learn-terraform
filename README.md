# Learn and Build using Terraform
## Learning notes - Concepts 

### Authentication and Authorization
- Authentication is the process of verifying who a user is.
- Authorization is the process of verifying what access they have.

#### Different way you can use credentials for AWS Provider
```terraform
provider "aws" {
    region      = "***********************"
    access_key  = "***********************"
    secret_key  = "***********************"
}
```

terraform init: Go ahead and download appropriate plugin associated with the provider.

terraform plan: It will show you what it will create/destroy based on the code written in terraform file. It will not create any resource … to create a resource you need to perform terraform apply.

terraform apply: 

terraform refresh: it will check the latest state of the infrastructure and update the state file accordingly.
You shouldn't typically need to use this command, because terraform automatically performs the same refreshing actions as part of creating a plan in both the terraform plan and terraform apply commands.

terraform destroy: terraform destroy allows us to destroy all the resource

## Hands On Labs
## POC Solutions/Projects
## Interview QA


# Follow the Steps to Provision the AWS Infrastructure for the Atlassian Suite

## Create an S3 Bucket in u region to store the terraform state files and Artifacts.
```shell
aws s3api create-bucket --bucket learn2024-terraform-tfstates --region=us-east-1

```

## Create an Dynamo DB table for State Locking
```shell
aws dynamodb create-table --table-name learn2024-dynamodb-tbl --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region us-east-1
```

## Execute Below Terraform commands to init, plan and apply 
```shell
terraform -chdir=./environments/dev init
terraform -chdir=./environments/dev plan
terraform -chdir=./environments/dev apply
```
