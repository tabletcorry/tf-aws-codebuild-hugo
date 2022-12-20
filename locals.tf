locals {
  module_tags = {
    module          = "tf-aws-codebuild-hugo"
    module_var_name = var.name
  }
  tags = merge(var.tags, local.module_tags)
}