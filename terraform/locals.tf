locals {
  users_file = "users.yaml"
  teams_file = "teams.yaml"
  tags_file  = "tags.yaml"

  users = yamldecode(file("${path.module}/../config/${local.users_file}"))["users"]
  parent_teams = yamldecode(file("${path.module}/../config/${local.teams_file}"))["parent_teams"]
  sub_teams = yamldecode(file("${path.module}/../config/${local.teams_file}"))["sub_teams"]
  tags         = yamldecode(file("${path.module}/../config/${local.tags_file}"))["tags"]
  schedules    = yamldecode(file("${path.module}/../config/schedules.yaml"))["schedules"]
  escalation_policies = yamldecode(file("${path.module}/../config/escalation_policies.yaml"))["escalation_policies"]
}
