variable "users" {
  description = "A map of PagerDuty users"
  type        = map(object({
    email        = string,
    phone_number = optional(string),
    sms_number   = optional(string),
    base_role    = optional(string, "limited_user"),
    job_title    = optional(string),
    time_zone    = optional(string),
    tag_name     = optional(string),
  }))
}

variable "parent_teams" {
  description = "A map of top-level PagerDuty teams"
  type        = map(object({
    description = string,
    managers    = optional(list(string)),
    responders  = optional(list(string))
  }))
}

variable "sub_teams" {
  description = "A map of PagerDuty teams that are sub teams of a parent"
  type        = map(object({
    description = string,
    parent      = string,
    managers    = optional(list(string)),
    responders  = optional(list(string))
  }))
}
