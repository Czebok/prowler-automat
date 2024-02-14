data "archive_file" "lambda_kod" {
  type        = "zip"
  source_file = var.kod_sciezka
  output_path = var.paczka_docelowa_sciezka
}

resource "aws_lambda_function" "funkcja_lambda" {
  filename      = var.paczka_docelowa_sciezka
  function_name = var.nazwa_funkcji
  role          = var.lambda_rola_arn
  handler = var.lambda_glowna_funkcja
  timeout = var.lambda_max_czas_wykonania

  source_code_hash = data.archive_file.lambda_kod.output_base64sha256

  runtime = var.lambda_jezyk

  environment {
    variables = var.zmienne_srodowiskowe
  }
}

resource "aws_lambda_permission" "pozwol_na_uruchomienie" {
  statement_id  = var.identyfikator_uprawnienia_id
  action        = var.akcja_uprawnienia
  function_name = aws_lambda_function.funkcja_lambda.function_name 
  principal     = var.uprawniony_do_wywolania
  source_arn    = var.uprawniony_do_wywolania_arn
}