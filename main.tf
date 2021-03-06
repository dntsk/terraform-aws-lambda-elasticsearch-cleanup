module "this" {
  source  = "dntsk/lambda-packager/aws"
  version = "0.1.8"

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

resource "aws_cloudwatch_event_rule" "sun_3am" {
  name                = "${var.name}-event-rule"
  description         = "Run lambda ${var.name} at Sunday 3am"
  schedule_expression = "cron(0 3 ? * SUN *)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.sun_3am.name
  target_id = "cleanup_elasticsearch"
  arn       = module.this.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.sun_3am.arn

  depends_on = [module.this]
}
