variable "name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "s3_deploy_target" {
  type = string
}

variable "cloudfront_deploy_target" {
  type = string
}