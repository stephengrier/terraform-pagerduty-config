variable "name" {
  type = string
}

variable "email" {
  type = string
}

variable "base_role" {
  type        = string
  default     = "restricted_access"
  description = "The base role for the user in PagerDuty"
}

variable "job_title" {
  type    = string
  default = null
}

variable "time_zone" {
  type    = string
  default = null
}

variable "phone_number" {
  type    = string
  default = null
}

variable "sms_number" {
  type    = string
  default = null
}

variable "country_code" {
  type    = string
  default = null
}

variable "tag_id" {
  type    = string
  default = null
}

variable "add_tag" {
  type        = number
  description = "Should a tag be assigned to the user"
  default     = 0
}
