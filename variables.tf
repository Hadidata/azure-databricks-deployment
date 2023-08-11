variable "region" {
  type        = string
  default     = "canadacentral"
  description = "Azure region for resource deployment"
}

variable "project" {
  type        = string
  description = "Name of the project"
}

variable "enviroment" {
  type        = string
  description = "name of the enviroment"

  validation {
    condition     = can(regex("sandbox|dev|uat|prod", var.enviroment))
    error_message = "Error: enviroment can only be dev, uat or prod"
  }
}

variable "databricks_sku" {
  type        = string
  description = "Databricks workspace sku"
  validation {
    condition     = can(regex("premium|standard|trial", var.databricks_sku))
    error_message = "Error: sku can only be standard, premium or trial"
  }
}

variable "kv_scope_name" {
  type        = string
  default     = "abfs_read_write"
  description = "Name of the azure keyvault backes scope"
}