variable "nazwa" {
  description = "Nazwa grupy bezpieczenstwa"
  type = string
}

variable "opis" {
  description = "Opis grupy bezpieczenstwa"
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "in_port_pocz" {
  description = "Port poczatkowy dla ruchu przychodzacego"
  type = number
}

variable "in_port_kon" {
  description = "Port docelowy dla ruchu przychodzacego"
  type = number
}

variable "in_protokol" {
  description = "Protokol dozwolony dla ruchu przychodzacego"
  type = string
}

variable "in_bloki_cidr" {
  description = "Blocki CIDR dozwolone dla ruchu przychodzacego"
  type = list(string)
}

variable "out_port_pocz" {
  description = "Port poczatkowy dla ruchu wychodzącego"
  type = number
}

variable "out_port_kon" {
  description = "Port docelowy dla ruchu wychodzącego"
  type = number
}

variable "out_protokol" {
  description = "Protokol dozwolony dla ruchu wychodzącego"
  type = string
}

variable "out_bloki_cidr" {
  description = "Blocki CIDR dozwolone dla ruchu wychodzacego"
  type = list(string)
}