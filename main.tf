locals {
  update                  = "${var.github_endpoint}/repos/${var.github_owner}/${var.repository_name}"
  create                  = "${var.github_endpoint}/user/repos"
  basic_branch_protection = "null"

  #TODO advanced protection
  advanced_branch_protection = "null"
}

resource "null_resource" "one" {
  triggers = {
    key = "${uuid()}"
  }

  provisioner "local-exec" {
    command = <<EOT
    curl ${var.action == "create" ? var.create : var.update} -H "Authorization: token ${var.github_token}" \
    -d '{
      "name":               "${var.repository_name}",
      "description":        "${var.repository_description}",
      "homepage":           "${var.repository_homepage}",
      "private":            "${var.repository_private}",
      "has_issues":         "${var.repository_has_issues}",
      "has_projects":       "${var.repository_has_projects}",
      "has_wiki":           "${var.repository_has_wiki}",
      "auto_init":          "${var.repository_auto_init}",
      "gitignore_template": "${var.repository_gitignore_template}",
      "license_template":   "${var.repository_license_template}",
      "allow_squash_merge": "${var.repository_allow_squash_merge}",
      "allow_merge_commit": "${var.repository_allow_merge_commit}",
      "allow_rebase_merge": "${var.repository_allow_rebase_merge}"
    }' \
    ${var.action == "create" ? local.create : local.update}

    curl -i -X PUT -H "Authorization: token ${var.github_token}" -H "Accept: application/vnd.github.mercy-preview+json" \
    -d '{ "names":  ${jsonencode(var.topics)}  }' \
    https://api.github.com/repos/${var.github_owner}/${var.repository_name}/topics

    curl -i -X PUT -H "Authorization: token ${var.github_token}"  -H "Accept: application/vnd.github.luke-cage-preview+json" \
    -d '{ "required_status_checks":${var.branch_protection == "basic" ? local.basic_branch_protection : local.advanced_branch_protection},
    "enforce_admins":${var.branch_protection == "basic" ? local.basic_branch_protection :  local.advanced_branch_protection},
    "required_pull_request_reviews":${var.branch_protection == "basic" ? local.basic_branch_protection :  local.advanced_branch_protection},
    "restrictions":null}' \
    https://api.github.com/repos/${var.github_owner}/${var.repository_name}/branches/master/protection


    EOT
  }
}
