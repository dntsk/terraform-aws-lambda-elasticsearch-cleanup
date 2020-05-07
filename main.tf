module "this" {
  source  = "dntsk/lambda-packager/aws"
  version = "0.1.5"

  source_dir = "${path.module}/lambda"
  filename   = "lambda.py"
  handler    = "lambda.handler"

  name = var.name

  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids         = var.vpc_subnet_ids

  environment_variables = {
    KEEP     = var.keep_days
    ENDPOINT = var.host
    INDEX    = var.index_prefix
  }
}
