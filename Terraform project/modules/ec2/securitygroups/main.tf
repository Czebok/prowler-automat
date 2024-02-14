#Tworzenie grupy security
resource "aws_security_group" "grupa_bezpieczenstwa" {
  name        = var.nazwa
  description = var.opis
  vpc_id = var.vpc_id
  ingress {
    from_port   = var.in_port_pocz
    to_port     = var.in_port_kon
    protocol    = var.in_protokol
    cidr_blocks = var.in_bloki_cidr
  }
  egress {
    from_port       = var.out_port_pocz
    to_port         = var.out_port_kon
    protocol        = var.out_protokol
    cidr_blocks     = var.out_bloki_cidr
  }
}