variable "aws_region" {
  description = "The AWS region where resources will be created."
  default     = "us-west-2"
}

variable "availability_zones" {
  description = "A list of availability zones in the specified region."
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}
