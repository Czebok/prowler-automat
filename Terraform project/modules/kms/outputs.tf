#Przekazanie do zmiennej wyjściowej ARN klucza KMS
output "kms_klucz_arn" {
  description = "ARN klucza KMS"
  value = aws_kms_key.kms_klucz.arn
}