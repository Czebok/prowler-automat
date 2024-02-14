module "s3_tf" {
  source = "../s3"
  nazwa = "bucket-terraform-stan"
  wersjonowanie_status = "Disabled"
  alias = "alias/kms_tf"
  opis = "Klucz KMS do bucketu przechowujacego stan srodowiska"
}