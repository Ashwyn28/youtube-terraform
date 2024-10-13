variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "The AWS account ID."
  type        = string
}

# variable "environment" {
#   description = "Deployment environment (e.g., prod, dev, staging)."
#   type        = string
# }
