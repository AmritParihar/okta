# =====================================================
# SAARI OKTA DETAILS — Koi ID nahi dalni
# Sab kuch automatically fetch hoga
# =====================================================

# --------------------------------------------------
# 1. USERS — Saare users (active, suspended, locked)
# --------------------------------------------------
data "okta_users" "active" {
  search {
    name       = "status"
    value      = "ACTIVE"
    comparison = "eq"
  }
}

data "okta_users" "suspended" {
  search {
    name       = "status"
    value      = "SUSPENDED"
    comparison = "eq"
  }
}

data "okta_users" "deprovisioned" {
  search {
    name       = "status"
    value      = "DEPROVISIONED"
    comparison = "eq"
  }
}

data "okta_users" "locked_out" {
  search {
    name       = "status"
    value      = "LOCKED_OUT"
    comparison = "eq"
  }
}

data "okta_users" "password_expired" {
  search {
    name       = "status"
    value      = "PASSWORD_EXPIRED"
    comparison = "eq"
  }
}

# --------------------------------------------------
# 2. GROUPS — Saare groups automatically
# --------------------------------------------------
data "okta_groups" "all" {}

data "okta_groups" "okta_managed" {
  type = "OKTA_GROUP"
}

data "okta_groups" "app_groups" {
  type = "APP_GROUP"
}

data "okta_groups" "built_in" {
  type = "BUILT_IN"
}

# --------------------------------------------------
# 3. APPLICATIONS — Saari apps (active + inactive)
# --------------------------------------------------
data "okta_apps" "all_active" {
  active_only = true
}

data "okta_apps" "all_including_inactive" {
  active_only = false
}

# --------------------------------------------------
# 4. AUTHORIZATION SERVERS — Default auth server
# --------------------------------------------------
data "okta_auth_server" "default" {
  name = "default"
}

data "okta_auth_server_scopes" "default" {
  auth_server_id = data.okta_auth_server.default.id
}

data "okta_auth_server_claims" "default" {
  auth_server_id = data.okta_auth_server.default.id
}

# --------------------------------------------------
# 5. POLICIES — Sab default policies auto-fetch
# --------------------------------------------------
data "okta_policy" "sign_on" {
  name = "Default Policy"
  type = "OKTA_SIGN_ON"
}

data "okta_policy" "password" {
  name = "Default Policy"
  type = "PASSWORD"
}

data "okta_policy" "mfa_enroll" {
  name = "Default Policy"
  type = "MFA_ENROLL"
}

data "okta_policy" "idp_discovery" {
  name = "Idp Discovery Policy"
  type = "IDP_DISCOVERY"
}

# --------------------------------------------------
# 6. TRUSTED ORIGINS
# --------------------------------------------------
data "okta_trusted_origins" "all" {}

# --------------------------------------------------
# 7. BRANDS & THEMES
# --------------------------------------------------
data "okta_brands" "all" {}

# --------------------------------------------------
# 8. BEHAVIORS
# --------------------------------------------------
data "okta_behaviors" "all" {}

# --------------------------------------------------
# 9. ORG METADATA
# --------------------------------------------------
data "okta_org_metadata" "current" {}