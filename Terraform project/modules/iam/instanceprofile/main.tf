resource "aws_iam_instance_profile" "profil_instancji" {
  name = var.profil_nazwa
  role = var.nazwa_roli 
}