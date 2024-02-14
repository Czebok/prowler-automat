variable "nazwa_harmonogramu" {
  description = "Nazwa harmonogramu EventBridge"
  type = string
}

variable "opis_harmonogramu" {
  description = "Opis harmonogramu EventBridge"
  type = string
}

variable "wyrazenie_harmonogramu" {
  description = "Wyrażenie CRON dla harmonogramu EventBridge"
  type = string
}

variable "cel_id" {
  description = "ID zdarzenia dla celu"
  type = string
}

variable "cel_arn" {
  description = "ARN celu"
  type = string
}
