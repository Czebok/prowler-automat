#Tworzenie klucza KMS
resource "aws_kms_key" "kms_klucz" {
  description = var.opis
  enable_key_rotation = true
}

#Nadanie kluczowi KMS aliasu
resource "aws_kms_alias" "kms_alias_klucza" {
  name = var.alias
  target_key_id = aws_kms_key.kms_klucz.key_id
}
