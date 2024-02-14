module "prowler" {
  source = "./modules/prowler"
  podsiec = module.siec_vpc.aws_subnet_id
  vpc_id = module.siec_vpc.aws_vpc_id
}