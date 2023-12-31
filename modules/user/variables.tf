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

variable "tag_ids" {
  type    = list(string)
  default = null
}

variable "tag_count" {
  type        = number
  description = "The number of tags to be assigned to the user"
  default     = 0
}
