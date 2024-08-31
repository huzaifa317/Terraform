resource "aws_flow_log" "main_vpc-logs" {
  iam_role_arn = aws_iam_role.cloudwatch-vpc-role.arn
  log_destination = aws_cloudwatch_log_group.vpc-log-group.arn
  traffic_type = "ALL"
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_vpc_flow-logs"
  }
  
}

resource "aws_cloudwatch_log_group" "vpc-log-group" {
  name = "vpc-flowlogs-logroup"
  retention_in_days = 3
  tags = {
    Name = "vpc-flowlogs-logroup"
  }
  
}

resource "aws_iam_role" "cloudwatch-vpc-role" {
  name = "cloudwatch-vpc-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "vpc-flow-logs-role"
  }
  
}

resource "aws_iam_policy" "custom-policy" {
  name = "custom-vpc-flow-logs-policy"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        Resource = "*"
      }
    ]
  })
  
}
resource "aws_iam_role_policy_attachment" "custom-attach" {
     role = aws_iam_role.cloudwatch-vpc-role.name
     policy_arn = aws_iam_policy.custom-policy.arn
}