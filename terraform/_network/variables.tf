variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR for VPC and will calculated automaticaly to several private & public subnet"
  validation {
    condition     = endswith(var.cidr_block, "/16")
    error_message = "the CIDR subnet should be /16"
  }
}

variable "resource_name" {
  type = string
}

variable "region" {
  type = string
}
