#Tworzenie zmiennych wejściowych
variable "nazwa" {
  description = "Nazwa bucketu S3"
  type = string
}

variable "wersjonowanie_status" {
  description = "Status wersjonowania wersji obiektów w buckecie S3"
  type = string
  default = "Enabled"
}

variable "alias" {
  description = "Alias klucza KMS"
  type = string
}

variable "opis" {
  description = "Opis klucza KMS"
  type = string
}