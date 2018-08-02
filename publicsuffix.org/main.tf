# Setup provider
# publicsuffix 

provider "aws" {
  region                  = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credentials_file}"
  profile                 = "${var.aws_profile}"
}

# Load configuration files from template

data "template_file" "buildspec" {
  template = "${file("./buildspec.yml")}"

  vars {
    bucket_name       = "${module.static_site.prod_bucket_name}"
    source_repository = "${var.source_repository["https_url"]}"
  }
}

# Create resources

module "static_site" {
  source            = "../tf_modules/s3_website"
  service_name      = "${var.service_name}"
  description       = "${var.description}"
  source_repository = "${var.source_repository}"
  website_domains   = "${var.website_domains}"
  container         = "${var.build_container}"
  buildspec         = "${data.template_file.buildspec.rendered}"
  github_token      = "${var.github_token}"
  acm_certificate   = "${var.acm_certificate}"
  webops_tags       = "${var.webops_tags}"
}

#LAMMMMMMMMMBBBBBBBDDAAAAAAAAA BABY

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda-headers-to-zip" {
  type        = "zip"
  source_file = "./lambda-headers.js"
  output_path = "./lambda-headers.zip"
}

resource "aws_lambda_function" "lambda-headers" {
  filename         = "./lambda-headers.zip"
  source_code_hash = "${data.archive_file.lambda-headers-to-zip.output_base64sha256}"
  function_name    = "lambda-headers"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  description      = "Provides Correct Response Headers for PublicSuffix"
  handler          = "lambda-headers.handler"
  runtime          = "nodejs6.10"
}
