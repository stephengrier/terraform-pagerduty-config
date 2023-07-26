module "user" {
  source   = "./modules/user"
  for_each = var.users

  name      = each.key
  email     = each.value.email
  base_role = each.value.base_role
  job_title = each.value.job_title
  time_zone = each.value.time_zone
  add_tag   = each.value.tag_name != null ? 1 : 0
  tag_id    = pagerduty_tag.tag[each.value.tag_name].id

  phone_number = each.value.phone_number
  sms_number   = each.value.sms_number
  country_code = each.value.country_code
}
