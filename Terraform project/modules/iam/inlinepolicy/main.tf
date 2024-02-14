resource "aws_iam_role_policy" "polityka_dedykowana" {
  name = var.dedykowana_polityka_nazwa
  role = var.id_roli

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = var.polityka_tresc
}