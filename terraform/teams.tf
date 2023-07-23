resource "pagerduty_team" "parent" {
  for_each = local.parent_teams

  name  = each.key
  description = each.value.description
}

resource "pagerduty_team" "subteam" {
  for_each = local.sub_teams

  name  = each.key
  description = each.value.description
  parent      = pagerduty_team.parent[each.value.parent].id
}
