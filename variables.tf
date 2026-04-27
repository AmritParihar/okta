variable "okta_org_name" {
  description = "Okta org subdomain e.g. dev-123456"
  type        = string
}

variable "okta_base_url" {
  description = "okta.com or oktapreview.com"
  type        = string
  default     = "okta.com"
}

variable "okta_api_token" {
  description = "Okta API Token (Admin Console > Security > API > Tokens)"
  type        = string
  sensitive   = true
}
