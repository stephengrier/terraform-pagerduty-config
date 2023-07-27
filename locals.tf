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
      ], [
      for team, values in var.parent_teams : [
        for user in values.responders : {
          user = user
          team = team
          role = "responder"
        }
      ] if try(values.responders, null) != null
      ], [
      for team, values in var.sub_teams : [
        for user in values.managers : {
          user = user
          team = team
          role = "manager"
        }
      ] if try(values.managers, null) != null
      ], [
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
