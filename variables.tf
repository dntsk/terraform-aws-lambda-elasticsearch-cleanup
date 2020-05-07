variable "keep_days" {
  type        = string
  description = "How many indexes to keep"
  default     = 365
}

variable "host" {
  type        = string
  description = "ElasticSearch hostname"
}

variable "index_prefix" {
  type        = string
  description = "ElasticSearch indices prefix to cleanup"
}

variable "name" {
  type        = string
  description = "Name of Lambda function"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security groups ids to deploy to VPC"
  default     = []
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "Subnets ids to deploy to VPC"
  default     = []
}
