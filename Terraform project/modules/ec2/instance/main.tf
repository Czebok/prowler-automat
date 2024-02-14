#Stworzenie grupy bezpieczenstwa dla instancji
module "zwzwol_ssh" {
  source = "../securitygroups"
  nazwa = var.sg_nazwa
  opis = var.sg_opis
  vpc_id = var.vpc_id
  
  in_port_pocz = var.sg_in_port_pocz
  in_port_kon = var.sg_in_port_kon
  in_protokol = var.sg_in_protokol
  in_bloki_cidr = var.sg_in_bloki_cidr #["91.215.237.185/32"]

  out_port_pocz = var.sg_out_port_pocz
  out_port_kon = var.sg_out_port_kon
  out_protokol = var.sg_out_protokol # -1 oznacza wszystkie protokoly
  out_bloki_cidr = var.sg_out_bloki_cidr
}

#Stworzenie ENI
resource "aws_network_interface" "network_interface" {
 subnet_id       = var.podsiec
 security_groups = [module.zwzwol_ssh.id_grupy_bezpieczenstwa]
}

#Dodanie klucza publcznnego RSA w celu użycia go do łączenia się z maszyną EC2
resource "aws_key_pair" "prowler_rsa" {
  key_name   = var.nazwa_klucza_ssh
  public_key = var.klucz_ssh
}

module "kms_ebs" {
  source = "../../kms"
  alias = var.kms_alias
  opis = var.kms_opis
}

#Właściwe utworzenie maszyny EC2
resource "aws_instance" "ec2_intance" {
 ami           = var.ami
 instance_type = var.typ_instancji
 key_name      = aws_key_pair.prowler_rsa.key_name
 user_data     = file(var.user_data)
# user_data_replace_on_change = true
 
iam_instance_profile = var.nazwa_profilu_instancji
metadata_options {
   http_tokens = "required"
}
 network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
 }
 root_block_device {
    volume_type   = var.ebs_typ
    volume_size   = var.ebs_rozmiar
    encrypted     = var.ebs_enkrypcja
    kms_key_id   = module.kms_ebs.kms_klucz_arn
 }
 tags = {
    Name = var.tag_nazwy
 }
}
