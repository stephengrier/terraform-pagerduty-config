resource "pagerduty_user" "user" {
  for_each = local.users

  name  = each.key
  email = each.value.email
  role  = each.value.base_role
}

locals {
  tags = {
    org_unit_1 = pagerduty_tag.org_unit_1
    org_unit_2 = pagerduty_tag.org_unit_2
  }
}

resource "pagerduty_tag_assignment" "user_tag" {
  for_each = pagerduty_user.user

  tag_id      = local.tags[local.users[each.value.name].tag_name].id
  entity_type = "users"
  entity_id   = each.value.id
}
