locals {
  update = "https://api.github.com/repos/${var.github_owner}/${var.repository_name}"
}

locals {
  create = "https://api.github.com/user/repos"
}

resource "null_resource" "github-personal-repository" {
  triggers {
    key = "${uuid()}"
  }

  provisioner "local-exec" {
    command = <<EOT
    curl ${var.action == "create" ? var.create : var.update} -H "Authorization: token ${var.github_token}" \
    -d '{"name": "${var.repository_name}",
    "description": "${var.repository_description}",
    "homepage": "${var.repository_homepage}",
    "private": "${var.repository_private}",
    "has_issues": "${var.repository_has_issues}",
    "has_projects": "${var.repository_has_projects}",
    "has_wiki": "${var.repository_has_wiki}",
    "auto_init": "${var.repository_auto_init}",
    "gitignore_template": "${var.repository_gitignore_template}",
    "license_template": "${var.repository_license_template}",
    "allow_squash_merge": "${var.repository_allow_squash_merge}",
    "allow_merge_commit": "${var.repository_allow_merge_commit}",
    "allow_rebase_merge": "${var.repository_allow_rebase_merge}"}' \
    ${var.action == "create" ? local.create : local.update}

    curl -i -X PUT -H "Authorization: token ${var.github_token}"  -H "Accept: application/vnd.github.luke-cage-preview+json" \
    -d '{ "required_status_checks": {"strict":${var.required_status_checks_strict},"contexts":[${var.required_status_checks_contexts}]},
    "enforce_admins": ${var.enforce_admins},
    "required_pull_request_reviews":{"dismiss_stale_reviews": true, "required_approving_review_count": ${var.required_approving_review_count}},
    "restrictions":null}' \
    https://api.github.com/repos/${var.github_owner}/${var.repository_name}/branches/master/protection


    curl -i -X PUT -H "Authorization: token ${var.github_token}" -H "Accept: application/vnd.github.mercy-preview+json" \
    -d '{ "names":  ${jsonencode(var.topics)}  }' \
    https://api.github.com/repos/${var.github_owner}/${var.repository_name}/topics


    EOT
  }
}
