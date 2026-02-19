terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
  }
  backend "s3" {
    bucket = "wanderlust-state-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "wanderlust-state-table"
    
  }
}