terraform {
  required_version = "~> 1.5"

  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "~> 2.15"
    }
  }
}

provider "pagerduty" {
  token = var.pagerduty_token
}
