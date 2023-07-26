resource "pagerduty_escalation_policy" "policy" {
  for_each = var.escalation_policies

  name        = each.key
  description = each.value.description
  num_loops   = each.value.num_loops
  teams       = [for team in each.value.teams : merge(pagerduty_team.parent, pagerduty_team.subteam)[team].id]

  dynamic "rule" {
    for_each = each.value.rules
    content {
      escalation_delay_in_minutes = rule.value.escalation_delay_in_minutes
      dynamic "target" {
        for_each = rule.value.targets
        content {
          type = target.value.type
          id   = target.value.type == "schedule_reference" ? pagerduty_schedule.schedule[target.value.target_name].id : module.user[target.value.target_name].id
        }
      }
    }
  }
}
