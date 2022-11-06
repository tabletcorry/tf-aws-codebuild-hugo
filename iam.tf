resource "aws_iam_role" "codebuild" {
  name_prefix = var.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_s3_bucket" "target" {
  bucket = var.s3_deploy_target
}

data "aws_cloudfront_distribution" "target" {
  id = var.cloudfront_deploy_target
}

resource "aws_iam_role_policy" "codebuild" {
  role = aws_iam_role.codebuild.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:List*",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "${aws_s3_bucket.cache.arn}",
        "${aws_s3_bucket.cache.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:List*",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "${data.aws_s3_bucket.target.arn}",
        "${data.aws_s3_bucket.target.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
                "cloudfront:GetDistribution",
                "cloudfront:CreateInvalidation"
      ],
      "Resource": [
        "${data.aws_cloudfront_distribution.target.arn}"
      ]
    }
  ]
}
POLICY
}