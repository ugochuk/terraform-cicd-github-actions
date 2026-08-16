variable "location" {
  description = "Azure region for the demonstration resources."
  type        = string
  default     = "eastus2"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "prefix" {
  description = "Short resource naming prefix."
  type        = string
  default     = "rugo"
}

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
