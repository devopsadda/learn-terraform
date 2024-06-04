# learn-terraform
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
