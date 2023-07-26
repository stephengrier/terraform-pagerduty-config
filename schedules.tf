resource "pagerduty_schedule" "schedule" {
  for_each = var.schedules

  name        = each.key
  time_zone   = each.value.time_zone
  description = each.value.description
  overflow    = each.value.overflow

  dynamic "layer" {
    for_each = each.value.layers
    content {
      name                         = layer.value.name
      start                        = layer.value.start
      rotation_virtual_start       = layer.value.rotation_virtual_start
      rotation_turn_length_seconds = layer.value.rotation_turn_length_seconds
      users                        = [for user in layer.value.users : module.user[user].id]

      dynamic "restriction" {
        for_each = layer.value.restrictions
        content {
          type              = restriction.value.type
          start_day_of_week = restriction.value.start_day_of_week
          start_time_of_day = restriction.value.start_time_of_day
          duration_seconds  = restriction.value.duration_seconds
        }
      }
    }
  }

  teams = [for team in each.value.teams : merge(pagerduty_team.parent, pagerduty_team.subteam)[team].id]
}
