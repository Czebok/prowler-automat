output "lambda_arn" {
    description = "ARN funkcji Lambda"
    value = aws_lambda_function.funkcja_lambda.arn
}