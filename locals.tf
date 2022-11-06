locals {
  module_tags = {
    module          = "tf-aws-codebuild-hugo"
    module_var_name = var.name
  }
  tags = merge(local.module_tags, var.tags)
}