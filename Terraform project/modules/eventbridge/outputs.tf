output "eventbridge_arn" {
    description = "Harmonogram EventBridge ARN"
    value = aws_cloudwatch_event_rule.harmonogram.arn
}