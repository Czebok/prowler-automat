variable "kod_sciezka" {
  description = "Scieżka do kodu funkcji Lambda"
  type        = string
}

variable "paczka_docelowa_sciezka" {
  description = "Scieżka do zapisu paczki zip przekazywanej do funkcji Lambda"
  type        = string
}

variable "nazwa_funkcji" {
  description = "Nazwa funkcji Lambda"
  type        = string
}

variable "lambda_rola_arn" {
  description = "ARN roli przeznaczonej dla funkcji Lambda"
  type        = string
}

variable "lambda_jezyk" {
  description = "Język wraz z wersja wykorzystany do pisania kodu Lambda"
  type        = string
  default = "python3.12"
}

variable "zmienne_srodowiskowe" {
  description = "Zmienne środowiskowe w formie mapy ciągów znaków"
  type        = map(string)
  default = {}
}

variable "lambda_glowna_funkcja" {
  description = "Główna fukcja wewnątrz Lambdy"
  type        = string
}

variable "lambda_max_czas_wykonania" {
  description = "Czas po ktorym Lambda przestanie swojego wykonwyania maksymalnie 15 min w sekundach"
  type        = number
  default = 900
}

variable "identyfikator_uprawnienia_id" {
  description = "Zmienna ta powinna zawierać unikalny identyfikator dla tego uprawnienia"
  type        = string
}

variable "akcja_uprawnienia" {
  description = "Zmienna ta powinna zawierać akcję, którą ma wywołać uprawnienie"
  type        = string
}

variable "uprawniony_do_wywolania" {
  description = "Zmienna ta powinna zawierać głównego wykonawcę uprawnionego do wywołania funkcji"
  type        = string
}

variable "uprawniony_do_wywolania_arn" {
  description = "ARN głównego wykonawcy"
  type        = string
}