variable "users" {
  description = "A map of PagerDuty users"
  type = map(object({
    email        = string,
    phone_number = optional(string),
    sms_number   = optional(string),
    country_code = optional(string),
    base_role    = optional(string, "restricted_access"),
    job_title    = optional(string),
    time_zone    = optional(string),
    tag_names    = optional(list(string)),
  }))
}

variable "parent_teams" {
  description = "A map of top-level PagerDuty teams"
  type = map(object({
    description = string,
    managers    = optional(list(string)),
    responders  = optional(list(string))
  }))
}

variable "sub_teams" {
  description = "A map of PagerDuty teams that are sub teams of a parent"
  type = map(object({
    description = string,
    parent      = string,
    managers    = optional(list(string)),
    responders  = optional(list(string))
  }))
}

variable "tags" {
  description = "A map of tags to create that can be attached to other resources"
  type = map(object({
    label = string
  }))
}

variable "schedules" {
  type = map(object({
    time_zone   = string,
    description = optional(string),
    overflow    = optional(bool),
    teams       = optional(list(string)),
    layers = list(object({
      name                         = string,
      start                        = string,
      rotation_virtual_start       = string,
      rotation_turn_length_seconds = string,
      users                        = list(string),
      restrictions = optional(list(object({
        type              = string,
        start_time_of_day = string,
        duration_seconds  = string,
        start_day_of_week = number
      })))
    }))
  }))
}

variable "escalation_policies" {
  type = map(object({
    teams       = optional(list(string)),
    description = optional(string),
    num_loops   = optional(number),
    rules = list(object({
      escalation_delay_in_minutes = number,
      targets = list(object({
        type        = optional(string),
        target_name = string
      }))
    }))
  }))
}
