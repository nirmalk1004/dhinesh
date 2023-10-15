variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "aws_region_names" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "public_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "s3_name" {
  default     = "rails-web-app-d"
}

variable "ecr_repo_name" {
  default     = "rails-app"
}
