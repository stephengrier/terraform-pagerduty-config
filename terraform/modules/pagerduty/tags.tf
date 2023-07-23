resource "pagerduty_tag" "tag" {
  for_each = var.tags

  label = each.value.label
}
