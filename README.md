[![Logo](https://dntsk.dev/assets/logo_transparent_crop_360.png)](https://dntsk.dev)

[![Maintained](https://img.shields.io/badge/maintained%20by-dntsk.dev-blue.svg)](https://dntsk.dev/) [![Terraform version](https://img.shields.io/badge/terraform-~>%20v0.12.24-33cc33.svg)](https://github.com/hashicorp/terraform/releases) [![GitHub tag](https://img.shields.io/github/tag/dntsk/terraform-aws-lambda-packager.svg)](https://github.com/dntsk/terraform-aws-lambda-packager/tags/) [![MIT license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT) 

# Terraform module with AWS Lambda to cleanup ES

Terraform module which creates and deploy AWS Lambda to cleanup ElasticSearch indexes.

## Supported Terraform versions

* Terraform 0.12. Pin version to `~> v0.1`

## Usage

```hcl
module "lambda_cleanup_elasticsearch" {
  source = "dntsk/lambda-elasticsearch-cleanup/aws"

  name = "es-cleanup"
  host = aws_elasticsearch_domain.elk.endpoint
  index_prefix = "filebeat"

  vpc_security_group_ids = [module.elk_sg.this_security_group_id]
  vpc_subnet_ids = module.vpc.private_subnets
}

```

## License

MIT Licensed. See LICENSE for full details.