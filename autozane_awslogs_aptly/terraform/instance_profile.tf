resource "aws_iam_instance_profile" "aptly_instance_profile" {
  name  = "aptly-instance-profile"
  roles = ["${aws_iam_role.aptly_role.name}"]
}

resource "aws_iam_role" "aptly_role" {
  name = "aptly-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "CloudWatchAccess" {
  name        = "CloudWatchAccess-aptly"
  description = "CloudWatch Access"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
               "cloudwatch:DeleteAlarms",
               "cloudwatch:DescribeAlarmHistory",
               "cloudwatch:DescribeAlarms",
               "cloudwatch:DescribeAlarmsForMetric",
               "cloudwatch:DisableAlarmActions",
               "cloudwatch:EnableAlarmActions",
               "cloudwatch:GetMetricData",
               "cloudwatch:GetMetricStatistics",
               "cloudwatch:ListMetrics",
               "cloudwatch:PutMetricAlarm",
               "cloudwatch:PutMetricData",
               "cloudwatch:SetAlarmState",
               "logs:CreateLogGroup",
               "logs:CreateLogStream",
               "logs:GetLogEvents",
               "logs:PutLogEvents",
               "logs:DescribeLogGroups",
               "logs:DescribeLogStreams",
               "logs:PutRetentionPolicy"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "attach_cloudwatch" {
  name       = "aptly-iam-attachment"
  policy_arn = "${aws_iam_policy.CloudWatchAccess.arn}"
  roles      = ["${aws_iam_role.aptly_role.name}"]
}
