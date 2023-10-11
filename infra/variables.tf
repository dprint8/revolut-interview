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

variable "app_version" {
  description = "The version tag off the app"
  type        = number
}

variable "availability_zones" {
  description = "List of AZs for subnets"
  type        = list(string)
}
