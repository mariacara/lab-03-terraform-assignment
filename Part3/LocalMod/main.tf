module "webserver" {
  source = "./webserver"
  sg     = module.securitygroup.sg-id
}

module "securitygroup" {
  source = "./securitygroup"
}
