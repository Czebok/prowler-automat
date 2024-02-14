#Tworzene zmiennych wejsciowych
variable "podsiec" {
  description = "Nazwa podsieci, w ktorej ma byc stworzone ENI/EC2"
  type = string
}

variable "ami" {
  description = "Nazwa AMI ktore ma byc uzyte do stworzenia instancji EC2"
  type = string
}

variable "typ_instancji" {
  description = "Typ instancji EC2"
  type = string
}

variable "nazwa_profilu_instancji" {
  description = "Profil instancji EC2"
  type = string
}

variable "ebs_typ" {
  description = "Typ dysku EBS"
  type = string
  default = "gp2"
}

variable "ebs_rozmiar" {
  description = "Rozmiar dysku EBS"
  type = number
  default = 40
}

variable "ebs_enkrypcja" {
  description = "Ustawienie enkrypcji dla dysku EBS"
  type = bool
}

variable "tag_nazwy" {
  description = "Nazwa instancji EC2"
  type = string
}

variable "sg_nazwa" {
  description = "Nazwa grupy bezpieczenstwa"
  type = string
}

variable "sg_opis" {
  description = "Opis grupy bezpieczenstwa"
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "sg_in_port_pocz" {
  description = "Port poczatkowy dla ruchu przychodzacego"
  type = number
}

variable "sg_in_port_kon" {
  description = "Port docelowy dla ruchu przychodzacego"
  type = number
}

variable "sg_in_protokol" {
  description = "Protokol dozwolony dla ruchu przychodzacego"
  type = string
}

variable "sg_in_bloki_cidr" {
  description = "Blocki CIDR dozwolone dla ruchu przychodzacego"
  type = list(string)
}

variable "sg_out_port_pocz" {
  description = "Port poczatkowy dla ruchu wychodzącego"
  type = number
}

variable "sg_out_port_kon" {
  description = "Port docelowy dla ruchu wychodzącego"
  type = number
}

variable "sg_out_protokol" {
  description = "Protokol dozwolony dla ruchu wychodzącego"
  type = string
}

variable "sg_out_bloki_cidr" {
  description = "Blocki CIDR dozwolone dla ruchu wychodzacego"
  type = list(string)
}

variable "nazwa_klucza_ssh" {
  description = "Nazwa klucza ssh"
  type = string
}

variable "klucz_ssh" {
  description = "Klucz ssh rsa"
  type = string
}

variable "kms_alias" {
  description = "Alias klucza KMS"
  type = string
}

variable "kms_opis" {
  description = "Opis klucza KMS"
  type = string
}

variable "user_data" {
  description = "Sciezka (w odniesieniu do glownego katalogu) do pliku zawierajacego user data"
  default = ""
}