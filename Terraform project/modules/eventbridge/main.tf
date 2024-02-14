resource "aws_cloudwatch_event_rule" "harmonogram" {
  name        = var.nazwa_harmonogramu
  description = var.opis_harmonogramu
  schedule_expression = var.wyrazenie_harmonogramu
}

resource "aws_cloudwatch_event_target" "cel" {
  rule      = aws_cloudwatch_event_rule.harmonogram.name
  target_id = var.cel_id
  arn       = var.cel_arn
}