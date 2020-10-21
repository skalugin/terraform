variable "vcd_org_user" {
  default     = "admin"
  description = "vCD Tenant User"
}

variable "vcd_org_password" {
  default     = "OYX^GLuw3!Dr"
  description = "vCD Tenant Password"
}

variable "vcd_org_org" {
  default     = "sktest"
  description = "vCD Tenant Org"
}

variable "vcd_org_url" {
  default     = "https://dcloud.ru/api"
  description = "vCD Tenant URL"
}

variable "vcd_org_vdc" {
  default     = "sktest_udm"
  description = "vCD Tenant VDC"
}

variable "vcd_org_max_retry_timeout" {
  description = "Retry Timeout"
  default     = "240"
}

variable "vcd_org_allow_unverified_ssl" {
  description = "vCD allow unverified SSL"
  default     = "true"
}

variable "vcd_org_edge_name" {
  description = "vCD edge name"
  default     = "def_edge"
}

variable "vcd_org_catalog" {
  description = "vCD Catalog Name"
  default = "catalog_name"
}

variable "template_vm" {
  description = "template vm"
  default = "Ubuntu18.04"
}
