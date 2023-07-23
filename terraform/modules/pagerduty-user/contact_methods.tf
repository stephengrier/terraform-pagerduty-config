resource "pagerduty_user_contact_method" "phone" {
  user_id      = "${pagerduty_user.user.id}"
  type         = "phone_contact_method"
  country_code = "+1"
  address      = "${var.mobile}"
  label        = "Mobile"
}

resource "pagerduty_user_contact_method" "sms" {
  user_id      = "${pagerduty_user.user.id}"
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "${var.mobile}"
  label        = "Mobile"
}
