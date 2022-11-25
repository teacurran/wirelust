locals {
  bucket_name = "${var.bucket_name}-${var.environment}"
}

resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${local.bucket_name}"

  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.bucket
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.bucket
  redirect_all_requests_to {
    protocol = "https"
    host_name = "${var.domain_name}"
  }
}

resource "aws_s3_bucket_cors_configuration" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.bucket

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_bucket" {
  bucket = local.bucket_name

  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "root_bucket" {
  bucket = aws_s3_bucket.root_bucket.bucket
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "root_bucket" {
  bucket = aws_s3_bucket.www_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

data "aws_iam_policy_document" "www_bucket" {
  statement {
    sid = "${var.site}-${var.environment}-policy"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::www.${local.bucket_name}/*"
    ]
    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }
  }
}

resource "aws_s3_bucket_policy" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = data.aws_iam_policy_document.www_bucket.json
}


data "aws_iam_policy_document" "root_bucket" {
  statement {
    sid = "${var.site}-${var.environment}-policy"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_name}/*"
    ]
    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }
  }
}

resource "aws_s3_bucket_policy" "root_bucket" {
  bucket = aws_s3_bucket.root_bucket.id
  policy = data.aws_iam_policy_document.root_bucket.json
}

# beta

resource "aws_s3_bucket" "beta_bucket" {
  bucket = "beta.${var.bucket_name}"

  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "beta_bucket" {
  bucket = aws_s3_bucket.beta_bucket.bucket
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "beta_bucket" {
  bucket = aws_s3_bucket.beta_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_cors_configuration" "beta_bucket" {
  bucket = aws_s3_bucket.beta_bucket.bucket

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://beta.${var.domain_name}"]
    max_age_seconds = 3000
  }
}

data "aws_iam_policy_document" "beta_bucket" {
  statement {
    sid = "${var.site}-beta-policy"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::beta.${var.bucket_name}/*"
    ]
    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }
  }
}

resource "aws_s3_bucket_policy" "beta_bucket" {
  bucket = aws_s3_bucket.beta_bucket.bucket
  policy = data.aws_iam_policy_document.beta_bucket.json
}

