terraform {
  backend "s3" {
    #bucket name here is hardcoded - we should try to create s3 bucket automatically by cloud formation and then try to find it eg by tag in terraform
    bucket = "tbase-terra-lock-bucket-initial-landing-zone-aws"
    region  = "eu-west-2"
    dynamodb_table = "terraform-lock"
    key = "terraform/dev/terraform_dev.tfstate"
    encrypt = true
  }
}
