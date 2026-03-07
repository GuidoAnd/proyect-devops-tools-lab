terraform {
  backend "s3" {
    bucket = "ecd-terraform-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"    
  }
}