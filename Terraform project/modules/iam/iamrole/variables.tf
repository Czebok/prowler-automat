variable "rola_nazwa" {
  description = "Nazwa roli"
  type = string
}

variable "polityka_asumpcji_roli" {
  description = "Nazwa roli"
  type = string
}

variable "polityki_aws" {
  description = "ARN'y polityk zarzadzanych przez AWS ktore maja byc dolaczone do roli"
  type = list(string)
  default = [ ]
}