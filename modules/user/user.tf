resource "pagerduty_user" "user" {
  name      = var.name
  email     = var.email
  role      = var.base_role
  job_title = var.job_title
  time_zone = var.time_zone
}

resource "pagerduty_tag_assignment" "user_tag" {
  count = var.tag_count

  tag_id      = var.tag_ids[count.index]
  entity_type = "users"
  entity_id   = pagerduty_user.user.id
}
