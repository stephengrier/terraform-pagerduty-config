resource "pagerduty_team" "parent" {
  for_each = var.parent_teams

  name  = each.key
  description = each.value.description
}

resource "pagerduty_team" "subteam" {
  for_each = var.sub_teams

  name  = each.key
  description = each.value.description
  parent      = pagerduty_team.parent[each.value.parent].id
}
