#Przekazanie do zmiennej wyjściowej ARN klucza KMS
output "s3_bucket_arn" {
  value = aws_s3_bucket.nowy_s3_bucket.arn
}