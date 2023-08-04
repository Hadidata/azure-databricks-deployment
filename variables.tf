variable "region" {
  type        = string
  default     = "canadacentral"
  description = "Azure region for resource deployment"
}

variable "project" {
  type        = string
  default     = "db2023"
  description = "Name of the project"
}

variable "enviroment" {
  type        = string
  default     = "dev"
  description = "name of the enviroment"

  validation {
    condition     = can(regex("dev|uat|prod", var.enviroment))
    error_message = "Error: enviroment can only be dev, uat or prod"
  }
}

variable "kv_scope_name" {
  type        = string
  default     = "abfs_read_write"
  description = "Name of the azure keyvault backes scope"
}