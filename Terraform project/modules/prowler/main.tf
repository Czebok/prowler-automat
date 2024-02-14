##### Segment odpowiadający za uprawnienia maszyny EC2 #####
data "aws_iam_policy_document" "polityka_asumpcji_roli_prowler_ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

module "ec2_prowler_rola" {
  source = "../iam/iamrole"
  rola_nazwa = "EC2-prowler-rola"
  polityka_asumpcji_roli = data.aws_iam_policy_document.polityka_asumpcji_roli_prowler_ec2.json
  polityki_aws = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/SecurityAudit", "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
  }

module "polityka_asumpcja_zewnetrzne_konto" {
  source = "../iam/inlinepolicy"
  id_roli = module.ec2_prowler_rola.id_roli
  dedykowana_polityka_nazwa = "Prowler-assumpcja-zewnetrzne-konto"
  polityka_tresc = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:iam::211125615902:role/prowler-rola"
          ]
      },
    ]
  })
}

module "polityka_zapisu_s3" {
  source = "../iam/inlinepolicy"
  id_roli = module.ec2_prowler_rola.id_roli
  dedykowana_polityka_nazwa = "Prowler-zapisu-s3"
  polityka_tresc = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:putObjectAcl",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:AbrotMultipartUpload"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::s3-wyniki-prowler/*",
          ]
      },
      {
            "Effect": "Allow",
            "Action": [
                "kms:GenerateDataKey",
            ],
            "Resource": "arn:aws:kms:eu-central-1:730335567445:key/0718073a-5e9f-40dc-b400-4dabd2230f1f"
      }
    ]
  })
}

module "profil_instancji_prowler" {
  source = "../iam/instanceprofile"
  profil_nazwa = "EC2-prowler-profil"
  nazwa_roli = module.ec2_prowler_rola.nazwa_roli
}

##### Segment odpowiadający za utworzenie instancji w odpowiedniej konfiguracji #####
module "ec2_prowler" {
  source = "../ec2/instance"
  vpc_id = var.vpc_id
  podsiec = var.podsiec

  user_data = "./scripts/prowler.sh"

  tag_nazwy = "EC2_Prowler"
  ami = "ami-0faab6bdbac9486fb"
  typ_instancji = "t2.micro"
  nazwa_klucza_ssh = "ssh-prowler"
  klucz_ssh = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFi8t1EOiCDz2KY3sqooT+NQAJ5MViyfbVcZXjggIUnukfoQhH+i6q/iwKKWnWEmS7jI5/pGUP4bOI4PV8eWWdtfAdUbgMfjH72f/a3ZTOqXYYOySmDfIhpud8j8RvQFT518+H0MkfyjYXc995tp8FEd6EQPRHCuhGPDaLF5H+GpTrgHPK6GDqA4mw5NJ3c/z5Jj7AD+50Lshu8rUIesc37CSV01YIX4ilXYeYgZG8me6slljJ0/KGR6E1LtbyDGiNcLoUTUY/bybrMnL7gLx525CDN/2K3fswhyvdEZvOwKuKqeLltC6R/9uB4Lr0SkM3+Qj2LF0Up/2YaT9jpwWke/0gevdpDvBHKB47xPFgXy9pEAG5MmlB8I2wLvdbXQ7DMg718sAwsrx/slay1FhIuLcNd9SKbjSBHxAHnR1QLgdB9YNWB547SAlKUrTiNXRh5dE0bGY3lfv77jXIt9Nc9Mxm98TfDRt7sbJEUcbLx2X0dBd5mjWXcH5iRZrn28M= bartlomiejcebo@MacBook-Pro-Bartomiej.local"
  nazwa_profilu_instancji = module.profil_instancji_prowler.profil_instancji_nazwa

  kms_alias = "alias/kms_prowler"
  kms_opis = "Klucz KMS do szyfrowania dysku instancji Prowler"
  ebs_enkrypcja = true
  
  sg_nazwa = "Prowler pozwol na SSH"
  sg_opis = "Umozliwia polaczenie SSH z domowego adresu IP"
  sg_in_port_pocz = 22
  sg_in_port_kon = 22
  sg_in_protokol = "tcp"
  sg_in_bloki_cidr = ["91.215.237.185/32"]

  sg_out_port_pocz = 0
  sg_out_port_kon = 0
  sg_out_protokol = "-1" # -1 oznacza wszystkie protokoly
  sg_out_bloki_cidr = ["0.0.0.0/0"]
}

##### Segment odpowiadający za stworzenie bucketu do przechowywania wyników skanów narzędzia Prowler #####
module "s3_wyniki_prowler" {
  source = "../s3"
  nazwa = "s3-wyniki-prowler"
  alias = "alias/kms_s3_prowler"
  opis = "Klucz KMS dla bucketu S3 z wynikami z narzedzia Prowler"
}

##### Segment odpowiadający za uprawnienia funkcji Lambda #####
data "aws_iam_policy_document" "assumpcja_roli_lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

module "lambda_prowler_rola"{
  source = "../iam/iamrole"
  rola_nazwa = "Lambda-prowler-rola"
  polityka_asumpcji_roli = data.aws_iam_policy_document.assumpcja_roli_lambda.json
  polityki_aws = [
  "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
  "arn:aws:iam::aws:policy/AmazonSSMFullAccess", 
  "arn:aws:iam::aws:policy/AWSLambdaExecute"
  ]
}

module "Lambda_harmonogram_start" {
  source = "../eventbridge"
  nazwa_harmonogramu = "UruchomInstancjeProwlerCRON"
  opis_harmonogramu = "Uruchomienie instancji prowler na podstawie grafiku eventbridge"
  wyrazenie_harmonogramu = "cron(0 8 1 * ? *)"
  cel_arn = module.ProwlerStart.lambda_arn
  cel_id = "InvokeLambdaFunction"
}


module "Lambda_harmonogram_stop" {
  source = "../eventbridge"
  nazwa_harmonogramu = "ZastopujInstancjeProwlerCRON"
  opis_harmonogramu = "Zastopowanie instancji prowler na podstawie grafiku eventbridge"
  wyrazenie_harmonogramu = "cron(10 16 1 * ? *)"  #cron(Minutes Hours Day-of-month Month Day-of-week Year)
  cel_arn = module.ProwlerStop.lambda_arn
  cel_id = "InvokeLambdaFunction"
}

module "ProwlerStart"{
  source = "../lambda"
  paczka_docelowa_sciezka = "./lambda_code/ProwlerStart.zip"
  kod_sciezka = "./lambda_code/ProwlerStart.py"
  lambda_rola_arn = module.lambda_prowler_rola.arn_roli
  nazwa_funkcji = "ProwlerStart"
  lambda_glowna_funkcja = "ProwlerStart.lambda_handler"
  akcja_uprawnienia = "lambda:InvokeFunction"
  uprawniony_do_wywolania = "events.amazonaws.com"
  uprawniony_do_wywolania_arn = module.Lambda_harmonogram_start.eventbridge_arn
  identyfikator_uprawnienia_id = "AllowExecutionFromCloudWatch"

}

module "ProwlerStop"{
  source = "../lambda"
  paczka_docelowa_sciezka = "./lambda_code/ProwlerStop.zip"
  kod_sciezka = "./lambda_code/ProwlerStop.py"
  lambda_rola_arn = module.lambda_prowler_rola.arn_roli
  nazwa_funkcji = "ProwlerStop"
  lambda_glowna_funkcja = "ProwlerStop.lambda_handler"
  akcja_uprawnienia = "lambda:InvokeFunction"
  uprawniony_do_wywolania = "events.amazonaws.com"
  uprawniony_do_wywolania_arn = module.Lambda_harmonogram_stop.eventbridge_arn
  identyfikator_uprawnienia_id = "AllowExecutionFromCloudWatch"
}

module "prowler_lambda_allow_ec2_start_stop" {
  source = "../iam/inlinepolicy"
  id_roli = module.lambda_prowler_rola.id_roli
  dedykowana_polityka_nazwa = "prowler-lambda-ec2-start-stop"
  polityka_tresc = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Start*",
                "ec2:Stop*"
            ],
            "Resource": "arn:aws:ec2:eu-central-1:730335567445:instance/i-04b63d16c560b6ddc"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:CreateGrant",
            ],
            "Resource": "arn:aws:kms:eu-central-1:730335567445:key/8fbcf013-e070-4998-a5c4-15c2979e9c60"
        }
    ]
})
}


