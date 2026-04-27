# Okta Full Assessment — Terraform
## Koi ID nahi dalni — Sab automatically fetch hoga!

---

## Sirf 4 Steps:

### Step 1 — API Token banao
```
Okta Admin Console →
Security → API → Tokens →
"Create Token" → Copy karo
```

### Step 2 — terraform.tfvars banao
```hcl
okta_org_name  = "dev-123456"
okta_base_url  = "okta.com"
okta_api_token = "00XXXXXXXXXX"
```

### Step 3 — Initialize
```bash
terraform init
```

### Step 4 — Saari details fetch karo
```bash
terraform apply -refresh-only
```

### Step 5 — JSON Report export karo
```bash
terraform output -json > okta_report.json
```

---

## Kya kya milega (bina kisi ID ke):

| Category        | Details                                                    |
|-----------------|------------------------------------------------------------|
| Users           | Active, Suspended, Deprovisioned, Locked, Password Expired |
| Groups          | Saare groups — name, type, description                     |
| Applications    | Active + Inactive — saari apps                             | 
| Auth Servers    | Saare servers + scopes + claims                            |
| Policies        | Sign-On, Password, MFA, IDP Discovery                      |
| Trusted Origins | CORS + Redirect origins                                    |
| Custom Domains  | Saare domains                                              |
| Brands/Themes   | UI customizations                                          |
| Behaviors       | Anomaly detection rules                                    |
| Org Metadata    | Org ID, pipeline info                                      |
|------------------------------------------------------------------------------|

---

## Individual output dekhna ho to:
```bash
terraform output ASSESSMENT_REPORT          # Master summary
terraform output all_groups_detail          # Saare groups
terraform output all_active_apps_detail     # Saari apps
terraform output -json > report.json        # Full JSON report
```
