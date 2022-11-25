variable "site" {
  default = "wirelust"
}

variable "environment" {
  default = "production"
}

variable "domain_name" {
  type        = string
  default     = "wirelust.com"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default     = "wirelust.com"
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}