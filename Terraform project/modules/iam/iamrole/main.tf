resource "aws_iam_role" "rola" {
  name               = var.rola_nazwa
  assume_role_policy = var.polityka_asumpcji_roli
  managed_policy_arns = var.polityki_aws
}