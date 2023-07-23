locals {
  team_memberships = flatten([
    [
      for team, values in var.parent_teams : [
        for user in values.managers : {
          user = user
          team = team
          role = "manager"
        }
      ] if try(values.managers, null) != null
    ],[
      for team, values in var.parent_teams : [
        for user in values.responders : {
          user = user
          team = team
          role = "responder"
        }
      ] if try(values.responders, null) != null
    ],[
      for team, values in var.sub_teams : [
        for user in values.managers : {
          user = user
          team = team
          role = "manager"
        }
      ] if try(values.managers, null) != null
    ],[
      for team, values in var.sub_teams : [
        for user in values.responders : {
          user = user
          team = team
          role = "responder"
        }
      ] if try(values.responders, null) != null
    ],
  ])
}

resource "pagerduty_team_membership" "membership" {
  for_each = {
    for membership in local.team_memberships : "${membership.user}.${membership.team}" => membership
  }

  user_id = pagerduty_user.user[each.value.user].id
  team_id = merge(pagerduty_team.parent, pagerduty_team.subteam)[each.value.team].id
  role    = each.value.role
}
