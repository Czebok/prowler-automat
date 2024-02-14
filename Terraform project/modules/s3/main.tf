#Tworzenie bucketu S3
resource "aws_s3_bucket" "nowy_s3_bucket" {
  bucket = var.nazwa

  tags = {
    Name = var.nazwa
  }
}

module "kms_s3" {
  source = "../kms"
  alias = var.alias
  opis = var.opis
}

#Włączenie enkrypcji dla bucketu S3
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_enkrypcja" {
  bucket = aws_s3_bucket.nowy_s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = module.kms_s3.kms_klucz_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

#Włączenie kontroli wercji dla bucketu S3
resource "aws_s3_bucket_versioning" "s3_bucket_wersjonowanie" {
  bucket = aws_s3_bucket.nowy_s3_bucket.id
  versioning_configuration {
    status = var.wersjonowanie_status
  }
}