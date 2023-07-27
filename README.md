# PagerDuty terraform module

This is a terraform module for configuring resources in a
[PagerDuty](https://www.pagerduty.com/) account. PagerDuty is a SaaS incident
management platform. This module will provision users, teams, team membership,
schedules and escalation policies.

## How to use this module

This module is intended to take its inputs from YAML files decoded into
terraform objects using `yamldecode` as follows.

Create a list of PagerDuty users to be created in a YAML file:

```yaml
---
users:
  'Bob Smith':
    email: 'bob@example.com'
    base_role: restricted_access
    country_code: '+44'
    sms_number: '7123456789'
    phone_number: '7123456789'

  'Gail Force':
    email: 'gail@example.com'
    base_role: observer
    country_code: '+44'
    sms_number: '7987654321'
    phone_number: '7987654321'
```

Use `yamldecode` to decode your YAML into a terraform object and instantiate this
module:

```hcl
locals {
  users = yamldecode(file("${path.module}/config/users.yaml"))["users"]
}

module "pagerduty" {
  source = "git::https://github.com/stephengrier/terraform-pagerduty-config.git"
  users  = local.users
}
```

It is also possible to create PagerDuty teams, team membership, schedules and
escalation policies in this way. For a more complete example, see the [examples
directory](https://github.com/stephengrier/terraform-pagerduty-config/tree/main/examples).

## License

This code is released under the Apache 2.0 License. Please see the
[LICENSE](https://github.com/stephengrier/terraform-pagerduty-config/blob/main/LICENSE)
file for details.

