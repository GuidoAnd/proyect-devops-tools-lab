terraform {
  backend "s3" {
    bucket = "ecd-terraform-state-bucket"
    key = "jenkins/terraform.tfstate"
    region = "us-east-1"    
  }
}