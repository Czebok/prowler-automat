variable "vpc_cidr" {
  description = "Blok CIDR dla VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_nazwa" {
  description = "Nazwa VPC"
  type = string
  default = "Glowne_VPC"
}

variable "igw_nazwa" {
  description = "Nazwa bramy sieciowej"
  type = string
  default = "Brama_sieciowa"
}

variable "podsiec_cidr" {
  description = "Blok CIDR dla podsieci publicznej"
  type = string
  default = "10.0.1.0/24"
}

variable "az" {
  description = "Strefa dostepnosci, w ktorej ma byc utworzona podsiec"
  type = string
  default = "eu-central-1a"
}

variable "podsiec_nazwa" {
  description = "Nazwa podsieci"
  type = string
  default = "Podsiec_publiczna"
}

variable "tablica_cidr" {
  description = "Blok CIDR dla ktorego obowiazuje tablica przekierowan"
  type = string
  default = "0.0.0.0/0"
}
