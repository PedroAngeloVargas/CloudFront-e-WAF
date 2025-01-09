resource "aws_wafv2_web_acl" "waf" {
  name        = "meu-waf"
  scope       = var.scope
  description = "waf-para-proteger-minha-aplicacao"
  default_action {
    allow {}
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf"
    sampled_requests_enabled   = true
  }

  dynamic "rule" {
    for_each = [
      "BadBot",
      "crawler",
      "spammer",
      "scraper",
      "python-requests",
      "curl",
      "wget",
      "bot",
      "harvest",
      "scan",
      "monitor",
      "attack",
      "bruteforce"
    ]
    content {
      name = "block-${rule.value}"
      priority = index([
        "BadBot",
        "crawler",
        "spammer",
        "scraper",
        "python-requests",
        "curl",
        "wget",
        "bot",
        "harvest",
        "scan",
        "monitor",
        "attack",
        "bruteforce"
      ], rule.value)
      action {
        block {}
      }
      statement {
        byte_match_statement {
          search_string = rule.value
          field_to_match {
            single_header {
              name = "user-agent"
            }
          }
          positional_constraint = "CONTAINS"
          text_transformation {
            priority = 0
            type     = "NONE"
          }
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "block-${rule.value}"
        sampled_requests_enabled   = true
      }
    }
  }
}
