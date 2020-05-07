module "lambda_cleanup_elasticsearch" {
  source = "../"

  name = "es-cleanup"
  host = aws_elasticsearch_domain.elk.endpoint
  index_prefix = "filebeat"

  vpc_security_group_ids = [module.elk_sg.this_security_group_id]
  vpc_subnet_ids = module.vpc.private_subnets
}
