variable "account_id" {
    description = "Deployment AWS account id"
}

variable "region" {
  description = "Deployment AWS region"
}

variable "tags" {
  description = "Tags applied to all taggable resources by the provider"
  type        = map(string) 
}
