resource "pagerduty_user_contact_method" "phone" {
  count = var.phone_number != null && var.country_code != null ? 1 : 0

  user_id      = pagerduty_user.user.id
  type         = "phone_contact_method"
  country_code = var.country_code
  address      = var.phone_number
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "sms" {
  count = var.sms_number != null && var.country_code != null ? 1 : 0

  user_id      = pagerduty_user.user.id
  type         = "sms_contact_method"
  country_code = var.country_code
  address      = var.sms_number
  label        = "Mobile"
}
