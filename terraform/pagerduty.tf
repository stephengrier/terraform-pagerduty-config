module "pagerduty" {
  source = "./modules/pagerduty"

  users        = local.users
  parent_teams = local.parent_teams
  sub_teams    = local.sub_teams
  tags         = local.tags
  schedules    = local.schedules

  escalation_policies = local.escalation_policies
}
