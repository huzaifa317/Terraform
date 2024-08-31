resource "aws_wafv2_web_acl" "example" {
  name = "example-waf"
  scope = "REGIONAL"
  default_action {
    allow {}
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name = "example-metric"
    sampled_requests_enabled = false
  }
}
resource "aws_wafv2_rule_group" "BlockIsreal" {
  name = "BlockIsreal"
  scope = "REGIONAL"
  capacity = 50
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name = "BlockIsrael"
    sampled_requests_enabled = false
  }
  rule {
    name = "block-isreal"
    priority = 1
    action{
      block {}
    }
    statement {
      geo_match_statement {
        country_codes = ["IL"]
      }
    }
    visibility_config {
      metric_name = "blockisreal"
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled = false
    }
  }
  
}

resource "aws_wafv2_web_acl_association" "example" {
  web_acl_arn = aws_wafv2_web_acl.example.arn
  resource_arn = aws_lb.first_lb.arn
  
}
resource "aws_wafv2_ip_set" "custom-ip-block" {
  name = "Blocked-ips"
  scope = "REGIONAL"
  ip_address_version = "IPV4"
  addresses = ["203.0.113.0/24","192.0.2.0/24"]
  tags = {
    Name = "Blocked-ips"
  }
  
}

resource "aws_wafv2_rule_group" "Blocked-ip" {
  name = "ipBlocked"
  scope = "REGIONAL"
  capacity = 50
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name = "BlockIps"
    sampled_requests_enabled = false
  }
  rule {
    name = "ipsblock"
    priority = 2
    action {
      block {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.custom-ip-block.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "Blocked_ip"
      sampled_requests_enabled = false
    }
  }
}
resource "aws_wafv2_web_acl_association" "example2" {
  web_acl_arn = aws_wafv2_web_acl.example.arn
  resource_arn = aws_lb.first_lb.arn
  
}

