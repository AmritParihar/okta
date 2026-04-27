# =====================================================
# OUTPUTS — Sab kuch automatically print hoga
# Run: terraform output -json > report.json
# =====================================================

# --------------------------------------------------
# ORG INFO
# --------------------------------------------------
output "org_info" {
  description = "Okta Org basic metadata"
  value = {
    org_id   = data.okta_org_metadata.current.id
    pipeline = data.okta_org_metadata.current.pipeline
    settings = data.okta_org_metadata.current.settings
  }
}

# --------------------------------------------------
# USERS SUMMARY
# --------------------------------------------------
output "users_summary" {
  description = "Users count by status"
  value = {
    active           = length(data.okta_users.active.users)
    suspended        = length(data.okta_users.suspended.users)
    deprovisioned    = length(data.okta_users.deprovisioned.users)
    locked_out       = length(data.okta_users.locked_out.users)
    password_expired = length(data.okta_users.password_expired.users)
    total = (
      length(data.okta_users.active.users) +
      length(data.okta_users.suspended.users) +
      length(data.okta_users.deprovisioned.users) +
      length(data.okta_users.locked_out.users) +
      length(data.okta_users.password_expired.users)
    )
  }
}

output "active_users_detail" {
  description = "All active users — full detail"
  sensitive   = true
  value = [for u in data.okta_users.active.users : {
    id                = u.id
    login             = u.login
    email             = u.email
    first_name        = u.first_name
    last_name         = u.last_name
    status            = u.status
    admin_roles       = u.admin_roles
    group_memberships = u.group_memberships
  }]
}

output "suspended_users_detail" {
  description = "All suspended users"
  sensitive   = true
  value = [for u in data.okta_users.suspended.users : {
    id         = u.id
    login      = u.login
    email      = u.email
    first_name = u.first_name
    last_name  = u.last_name
    status     = u.status
  }]
}

output "deprovisioned_users_detail" {
  description = "All deprovisioned users"
  sensitive   = true
  value = [for u in data.okta_users.deprovisioned.users : {
    id     = u.id
    login  = u.login
    email  = u.email
    status = u.status
  }]
}

output "locked_out_users_detail" {
  description = "All locked out users"
  sensitive   = true
  value = [for u in data.okta_users.locked_out.users : {
    id    = u.id
    login = u.login
    email = u.email
  }]
}

# --------------------------------------------------
# GROUPS
# --------------------------------------------------
output "groups_summary" {
  description = "Groups count by type"
  value = {
    total       = length(data.okta_groups.all.groups)
    okta_groups = length(data.okta_groups.okta_managed.groups)
    app_groups  = length(data.okta_groups.app_groups.groups)
    built_in    = length(data.okta_groups.built_in.groups)
  }
}

output "all_groups_detail" {
  description = "All groups with full details"
  value = [for g in data.okta_groups.all.groups : {
    id          = g.id
    name        = g.name
    description = g.description
    type        = g.type
  }]
}

# --------------------------------------------------
# APPLICATIONS
# --------------------------------------------------
output "apps_summary" {
  description = "Applications count"
  value = {
    active_apps = length(data.okta_apps.all_active.apps)
    total_apps  = length(data.okta_apps.all_including_inactive.apps)
    inactive    = length(data.okta_apps.all_including_inactive.apps) - length(data.okta_apps.all_active.apps)
  }
}

output "all_active_apps_detail" {
  description = "All active applications"
  value = [for app in data.okta_apps.all_active.apps : {
    id     = app.id
    label  = app.label
    status = app.status
  }]
}

output "all_apps_including_inactive" {
  description = "ALL apps including inactive"
  value = [for app in data.okta_apps.all_including_inactive.apps : {
    id     = app.id
    label  = app.label
    status = app.status
  }]
}

# --------------------------------------------------
# AUTHORIZATION SERVERS
# --------------------------------------------------
output "default_auth_server" {
  description = "Default authorization server"
  value = {
    id       = data.okta_auth_server.default.id
    name     = data.okta_auth_server.default.name
    issuer   = data.okta_auth_server.default.issuer
    status   = data.okta_auth_server.default.status
    audiences = data.okta_auth_server.default.audiences
  }
}

output "default_auth_server_scopes" {
  description = "Default auth server — all scopes"
  value = [for scope in data.okta_auth_server_scopes.default.scopes : {
    id          = scope.id
    name        = scope.name
    description = scope.description
    default     = scope.default
    system      = scope.system
  }]
}

output "default_auth_server_claims" {
  description = "Default auth server — all claims"
  value = [for claim in data.okta_auth_server_claims.default.claims : {
    id         = claim.id
    name       = claim.name
    value      = claim.value
    claim_type = claim.claim_type
    status     = claim.status
  }]
}

# --------------------------------------------------
# POLICIES
# --------------------------------------------------
output "all_policies_detail" {
  description = "All default policies"
  value = {
    sign_on_policy = {
      id     = data.okta_policy.sign_on.id
      name   = data.okta_policy.sign_on.name
      status = data.okta_policy.sign_on.status
      type   = data.okta_policy.sign_on.type
    }
    password_policy = {
      id     = data.okta_policy.password.id
      name   = data.okta_policy.password.name
      status = data.okta_policy.password.status
    }
    mfa_enrollment_policy = {
      id     = data.okta_policy.mfa_enroll.id
      name   = data.okta_policy.mfa_enroll.name
      status = data.okta_policy.mfa_enroll.status
    }
    idp_discovery_policy = {
      id     = data.okta_policy.idp_discovery.id
      name   = data.okta_policy.idp_discovery.name
      status = data.okta_policy.idp_discovery.status
    }
  }
}

# --------------------------------------------------
# TRUSTED ORIGINS
# --------------------------------------------------
output "all_trusted_origins" {
  description = "All trusted origins (CORS / Redirect)"
  value       = data.okta_trusted_origins.all.trusted_origins
}

# --------------------------------------------------
# BRANDS
# --------------------------------------------------
output "all_brands" {
  description = "All UI brands/themes"
  value       = data.okta_brands.all.brands
}

# --------------------------------------------------
# BEHAVIORS
# --------------------------------------------------
output "all_behaviors" {
  description = "All defined behaviors (anomaly detection etc.)"
  value       = data.okta_behaviors.all.behaviors
}

# --------------------------------------------------
# MASTER ASSESSMENT REPORT
# --------------------------------------------------
output "ASSESSMENT_REPORT" {
  description = "Complete Okta Assessment — Master Summary"
  value = {
    org = {
      id       = data.okta_org_metadata.current.id
      pipeline = data.okta_org_metadata.current.pipeline
    }
    users = {
      active           = length(data.okta_users.active.users)
      suspended        = length(data.okta_users.suspended.users)
      deprovisioned    = length(data.okta_users.deprovisioned.users)
      locked_out       = length(data.okta_users.locked_out.users)
      password_expired = length(data.okta_users.password_expired.users)
      TOTAL = (
        length(data.okta_users.active.users) +
        length(data.okta_users.suspended.users) +
        length(data.okta_users.deprovisioned.users) +
        length(data.okta_users.locked_out.users) +
        length(data.okta_users.password_expired.users)
      )
    }
    groups = {
      total       = length(data.okta_groups.all.groups)
      okta_groups = length(data.okta_groups.okta_managed.groups)
      app_groups  = length(data.okta_groups.app_groups.groups)
    }
    applications = {
      active = length(data.okta_apps.all_active.apps)
      total  = length(data.okta_apps.all_including_inactive.apps)
    }
    auth_server = {
      name   = data.okta_auth_server.default.name
      status = data.okta_auth_server.default.status
    }
    trusted_origins = {
      total = length(data.okta_trusted_origins.all.trusted_origins)
    }
    behaviors = {
      total = length(data.okta_behaviors.all.behaviors)
    }
  }
}
