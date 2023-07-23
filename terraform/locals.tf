locals {
  users_file = "users.yaml"
  teams_file = "teams.yaml"

  users = yamldecode(file("${path.module}/../config/${local.users_file}"))["users"]
  parent_teams = yamldecode(file("${path.module}/../config/${local.teams_file}"))["parent_teams"]
  sub_teams = yamldecode(file("${path.module}/../config/${local.teams_file}"))["sub_teams"]
}
