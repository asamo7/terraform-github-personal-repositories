variable "github_owner" {
  description = "GitHub Repositories owner"
}

variable "github_token" {
  description = "GitHub Token"
}

variable "action" {
  description = "Whether to create or update a repository. (pass update once create the repository)"
  default     = "create"
}

variable "create" {
  description = "Curl's method"
  default     = "POST"
}

variable "update" {
  description = "Curl's method"
  default     = "PATCH"
}

variable "repository_name" {
  description = "GitHub Repositories owner"
}

variable "repository_description" {
  description = "A short description of the repository."
  default     = "My new repository."
}

variable "repository_homepage" {
  description = "A URL with more information about the repository."
  default     = ""
}

variable "repository_private" {
  description = "Either true to create a private repository or false to create a public one. Default: false."
  default     = "true"
}

variable "repository_has_issues" {
  description = "Either true to enable issues for this repository or false to disable them. Default: true."
  default     = true
}

variable "repository_has_projects" {
  description = "Either true to enable projects for this repository or false to disable them. Default: true."
  default     = true
}

variable "repository_has_wiki" {
  description = "Either true to enable the wiki for this repository or false to disable it. Default: true."
  default     = true
}

variable "repository_auto_init" {
  description = "Pass true to create an initial commit with empty README. Default: false."
  default     = true
}

variable "repository_gitignore_template" {
  description = "Desired language or platform .gitignore template to apply. Use the name of the template without the extension. For example, Haskell."
  default     = "Terraform"
}

variable "repository_license_template" {
  description = "Choose an open source license template that best suits your needs, and then use the license keyword as the license_template string. For example, mit or mpl-2.0."
  default     = "mit"
}

variable "repository_allow_squash_merge" {
  description = "Either true to allow squash-merging pull requests, or false to prevent squash-merging. Default: true"
  default     = true
}

variable "repository_allow_merge_commit" {
  description = "Either true to allow merging pull requests with a merge commit, or false to prevent merging pull requests with merge commits. Default: true"
  default     = true
}

variable "repository_allow_rebase_merge" {
  description = "Either true to allow rebase-merging pull requests, or false to prevent rebase-merging. Default: true"
  default     = true
}

variable "required_status_checks_strict" {
  description = "Required. Require branches to be up to date before merging."
  default     = "true"
}

variable "required_status_checks_contexts" {
  description = "Required. The list of status checks to require in order to merge into this branch"
  default     = ""
}

variable "enforce_admins" {
  description = "Required. Enforce all configured restrictions for administrators. Set to true to enforce required status checks for repository administrators. Set to null to disable."
  default     = "false"
}

variable "required_approving_review_count" {
  description = "Specify the number of reviewers required to approve pull requests. Use a number between 1 and 6."
  default     = 1
}

variable "topics" {
  description = "An array of topics to add to the repository. Pass one or more topics to replace the set of existing topics. Send an empty array ([]) to clear all topics from the repository."
  default     = []
}
