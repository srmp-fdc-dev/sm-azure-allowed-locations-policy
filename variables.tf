variable "policy_definition_category" {
  type        = string
  description = "The category to use for all Policy Definitions"
  default     = "General"
}
variable "subscription_id" {
 type   = string
 description  = "The value of the subscription for assigning the policy"
}
variable "tenant_id" {
    type = string
    description = "Azure Tenant ID"
}
variable "client_id" {
    type = string
    description = "Azure AD Application ID"
}
variable "client_secret" {
    type = string
    sensitive = true
    description = "Azure AD Application Secret"
}
variable "location" {
 type  = list(string)
 description = "List of allowed Locations"
}
variable "assign_name" {
 type  = string
 description = "Name of the Assignment"
 default = "Allowed Locations"
}
variable "name" {
    type        = string
    description = "Name of the Policy Definition"
    default     = "Allowed Locations"
}
