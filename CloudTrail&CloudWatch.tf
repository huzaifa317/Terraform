resource "aws_iam_role" "CloudWatch_role_for_CloudTrail" {
  name = "CloudWatch_logs_role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })


 tags = {
  Name = "Cloudwatch_logs_role"
 }

}



resource "aws_iam_role_policy" "cloudwatch-role-policy-attach" {
  name = "CloudWatch_Logs_Policy"
  role = aws_iam_role.CloudWatch_role_for_CloudTrail.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AWSCloudTrailCreateLogStream2014110",
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream"
        ],
        Resource = [
          "arn:aws:logs:us-east-1:010438509155:log-group:CloudTraillogroup2:log-stream:010438509155_CloudTrail_us-east-1*"
        ]
      },
      {
        Sid = "AWSCloudTrailPutLogEvents20141101",
        Effect = "Allow",
        Action = [
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:us-east-1:010438509155:log-group:CloudTraillogroup2:log-stream:010438509155_CloudTrail_us-east-1*"
        ]
      }
    ]
  })

  
}
resource "aws_cloudwatch_log_group" "log-trail2" {
  name = "CloudTraillogroup2"
  
  
}

resource "aws_cloudtrail" "log_trail" {
  depends_on=[aws_s3_bucket_policy.example]
  
  name = "management-events"
  s3_bucket_name = aws_s3_bucket.CloudTrail_Bucket.id
  s3_key_prefix  = "prefix"
  cloud_watch_logs_role_arn = aws_iam_role.CloudWatch_role_for_CloudTrail.arn
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.log-trail2.arn}:*"
}

resource "aws_s3_bucket" "CloudTrail_Bucket" {
  bucket        = "my-unique-cloudtrail-bucket-2024"
  force_destroy = true
   
  tags = {
    Name        = "unique-bucket"
    
  }
}
data "aws_iam_policy_document" "example" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.CloudTrail_Bucket.arn]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/management-events"]
    }
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.CloudTrail_Bucket.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/management-events"]
    }
  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.CloudTrail_Bucket.id
  policy = data.aws_iam_policy_document.example.json
}
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}



resource "aws_cloudwatch_log_metric_filter" "TerminateInstances" {
  name           = "ec2-instances-terminate"
  pattern        = "TerminateInstances"
  log_group_name = aws_cloudwatch_log_group.log-trail2.name

  metric_transformation {
    name      = "LogMetrics"
    namespace = "Custom_trail_ns"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "Termination Count"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        =  1
  metric_name               =  aws_cloudwatch_log_metric_filter.TerminateInstances.name
  namespace                 =  aws_cloudwatch_log_metric_filter.TerminateInstances.metric_transformation[0].namespace
  period                    = 300
  statistic                 = "Sum"
  threshold                 =  1
  alarm_description         = "This metric create alarm if ec2 is terminated"
  alarm_actions            =  [ aws_sns_topic.ec2_termination_topic.arn ]
  ok_actions = [aws_sns_topic.ec2_termination_topic.arn  ]

}
resource "aws_sns_topic" "ec2_termination_topic" {
  name = "ec2_termination_topic"
}
resource "aws_sns_topic_subscription" "ec2_termination_subscription" {
  topic_arn = aws_sns_topic.ec2_termination_topic.arn
  protocol  = "email"
  endpoint  = "huzaifasair5@gmail.com"
}


data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        010438509155,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.ec2_termination_topic.arn,
    ]

    sid = "__default_statement_ID"
  }
}