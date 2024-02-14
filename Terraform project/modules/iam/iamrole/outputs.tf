output "id_roli" {
  description = "ID roli"
  value = aws_iam_role.rola.id
}

output "nazwa_roli" {
  description = "Nazwa roli"
  value = aws_iam_role.rola.name
}

output "arn_roli" {
  description = "ARN roli"
  value = aws_iam_role.rola.arn
}