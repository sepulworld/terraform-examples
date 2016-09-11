resource "aws_s3_bucket" "s3_bucket" {
  bucket = "autozane_example_bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name        = "autozane.com"
    Environment = "Development"
  }
}

data "aws_iam_policy_document" "autozane_s3" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "",
        "home/",
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/home/",
      "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/home/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "autozane_s3_policy" {
  bucket = "${aws_s3_bucket.s3_bucket.id}"
  policy = "${data.aws_iam_policy_document.autozane_s3.json}"
}
