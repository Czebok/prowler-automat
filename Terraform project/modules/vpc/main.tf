resource "aws_vpc" "siec" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_nazwa
  }
}

resource "aws_internet_gateway" "brama" {
  vpc_id = aws_vpc.siec.id

  tags = {
    Name = var.igw_nazwa
  }
}

resource "aws_subnet" "publiczna" {
  vpc_id     = aws_vpc.siec.id
  cidr_block = var.podsiec_cidr
  availability_zone = var.az

  map_public_ip_on_launch = true

  tags = {
    Name = var.podsiec_nazwa
  }
}

resource "aws_route_table" "tablica_przekierowan_publiczna" {
  vpc_id = aws_vpc.siec.id

  route {
    cidr_block = var.tablica_cidr 
    gateway_id = aws_internet_gateway.brama.id
  }

  tags = {
    Name = "Trasa przekierowan dla podsieci publicznych"
  }
}

resource "aws_route_table_association" "asocjacja_publiczna" {
  subnet_id      = aws_subnet.publiczna.id
  route_table_id = aws_route_table.tablica_przekierowan_publiczna.id
}