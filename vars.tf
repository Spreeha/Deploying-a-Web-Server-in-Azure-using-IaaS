variable "prefix" {
  description = "The prefix which should be used for all resources in this deployment"
  default     = "myproj"
}

variable "location" {
  description = "The azure region in which all resources in this deployment should be created."
  default     = "southindia"
}

variable "number_of_vms" {
  description = "Number of VMs to provision"
  type        = number
  default     = 3
}

variable "admin_username" {
  description = "The admin username for the VMs"
  default     = "AzureUser"
}

variable "admin_password" {
  description = "The admin password for the VMs"
  default     = "Shell@123456"
}

variable "address_space" {
  description = "VNET address space"
  default     = "10.4.0.0/16"
}

variable "subnet" {
  description = "Subnet address space"
  default     = "10.4.0.0/24"
}

variable "environment" {
  description = "Environment tag, e.g. prod, dev"
  default     = "dev"
}

variable "project" {
  description = "Project tag"
  default     = "udacity"
}

variable "owner" {
  description = "Owner tag"
  default     = "Spreeha Dutta"
}

variable "image" {
  description = "The VM image to deploy"
  default     = "myPackerImage"
}