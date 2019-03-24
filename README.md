# terraform-github-personal-repositories
> Terraform module  to create and manage GitHub personal (Individuals) repositories.


<img width="250" height="180" src=".img/tf_gh.png">


---


- [Table of Content]()
	- [About](#about)
	- [Setup](#setup)
	- [Usage](#usage)
	- [Inputs](#inputs)
	- [Links](#links)
	- [Changelog](#changelog)
	- [Contributing](#contributing)



## About

Terraform is an amazing tool to programmatically manage the entire lifecycle of
any API driven infrastructure and resources, which in many cases we refer to infrastructure as code paradigm. In the pursue of "everything as code" I have stumbled across the need to automate the creation and management of GitHub "personal" repositories. Terraform has already a GitHub provider, but unfortunately at the moment such provider support Organisations and Teams only. There are already
few open issues and a PR (see links below) open for such feature and hopefully will be addressed and integrated in near future. However, I took action and put together and **hackish** Terraform module to
create and manage GitHub personal repositories with few sensible security defaults as:


* "Basic master branch protection"


GitHub Provider issues and open pull requests.

https://github.com/terraform-providers/terraform-provider-github/pull/96

https://github.com/terraform-providers/terraform-provider-github/issues/45


## Setup

1) Create a GitHub personal access token for the command line with `repo, admin:org`  permissions.

https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line

2) Create a terraform.tfvars file.

example:
```
github_owner = "MyGitHubUsername"

github_token = "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"
```

## Usage

terraform file
```
variable "github_owner" {}

variable "github_token" {}

module "repo-1" {
  source                        = "github.com/p0bailey/terraform-github-personal-repositories
"
  github_owner                  = "${var.github_owner}"
  github_token                  = "${var.github_token}"
  repository_name               = "my-new-repository"
  repository_description        = "My new Awesome project."
  repository_private            = "false"
  repository_gitignore_template = "Terraform"
  topics                        = ["terraform", "github"]

  action = "update"
}
```
Run
```
terraform init
terraform plan
terraform apply
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| github\_owner | GitHub Repositories owner | string | n/a | yes |
| github\_token | GitHub Token | string | n/a | yes |
| repository\_name | GitHub Repositories owner | string | n/a | yes |
| action | Whether to create or update a repository. (pass update once create the repository) | string | `"create"` | no |
| branch\_protection | Set a basic protection for Master branch | string | `"basic"` | no |
| create | Curl's method | string | `"POST"` | no |
| enforce\_admins | Required. Enforce all configured restrictions for administrators. Set to true to enforce required status checks for repository administrators. Set to null to disable. | string | `"false"` | no |
| github\_endpoint | GitHub API endpoint | string | `"https://api.github.com"` | no |
| repository\_allow\_merge\_commit | Either true to allow merging pull requests with a merge commit, or false to prevent merging pull requests with merge commits. Default: true | string | `"true"` | no |
| repository\_allow\_rebase\_merge | Either true to allow rebase-merging pull requests, or false to prevent rebase-merging. Default: true | string | `"true"` | no |
| repository\_allow\_squash\_merge | Either true to allow squash-merging pull requests, or false to prevent squash-merging. Default: true | string | `"true"` | no |
| repository\_auto\_init | Pass true to create an initial commit with empty README. Default: false. | string | `"true"` | no |
| repository\_description | A short description of the repository. | string | `"My new repository."` | no |
| repository\_gitignore\_template | Desired language or platform .gitignore template to apply. Use the name of the template without the extension. For example, Haskell. | string | `"Terraform"` | no |
| repository\_has\_issues | Either true to enable issues for this repository or false to disable them. Default: true. | string | `"true"` | no |
| repository\_has\_projects | Either true to enable projects for this repository or false to disable them. Default: true. | string | `"true"` | no |
| repository\_has\_wiki | Either true to enable the wiki for this repository or false to disable it. Default: true. | string | `"true"` | no |
| repository\_homepage | A URL with more information about the repository. | string | `""` | no |
| repository\_license\_template | Choose an open source license template that best suits your needs, and then use the license keyword as the license_template string. For example, mit or mpl-2.0. | string | `"mit"` | no |
| repository\_private | Either true to create a private repository or false to create a public one. Default: false. | string | `"true"` | no |
| required\_approving\_review\_count | Specify the number of reviewers required to approve pull requests. Use a number between 1 and 6. | string | `"1"` | no |
| required\_status\_checks\_contexts | Required. The list of status checks to require in order to merge into this branch | string | `""` | no |
| required\_status\_checks\_strict | Required. Require branches to be up to date before merging. | string | `"true"` | no |
| topics | An array of topics to add to the repository. Pass one or more topics to replace the set of existing topics. Send an empty array ([]) to clear all topics from the repository. | list | `<list>` | no |
| update | Curl's method | string | `"PATCH"` | no |

## Changelog


* 0.0.1
    * First release
* 0.0.2
    * FIX: Basic master branch protection.


## Contributing

1. Fork it (<https://github.com/p0bailey/terraform-github-personal-repositories/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

## Links

https://www.terraform.io/docs/providers/github/index.html

https://www.hashicorp.com/blog/managing-github-with-terraform
