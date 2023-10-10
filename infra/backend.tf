terraform {
  backend "s3" {
    bucket         = "replace-with-bucket-name"
    key            = "infra/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    kms_key_id     = "replace-with-key-id"
  }
}
