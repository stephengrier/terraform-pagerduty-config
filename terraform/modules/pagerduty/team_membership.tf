resource "pagerduty_team_membership" "membership" {
  for_each = {
    for membership in local.team_memberships : "${membership.user}.${membership.team}" => membership
  }

  user_id = module.user[each.value.user].id
  team_id = merge(pagerduty_team.parent, pagerduty_team.subteam)[each.value.team].id
  role    = each.value.role
}
