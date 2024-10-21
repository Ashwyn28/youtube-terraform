resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "fastapi_api"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = [
      "https://orbbits.io",
      "https://audio-youtube.orbbits.io",
      "http://localhost:3000",
    ]
    allow_methods     = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers     = ["Content-Type", "Authorization", "X-Requested-With", "Accept", "Origin"]
    allow_credentials = true
  }

}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.api_gateway.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.fastapi_lambda.arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "proxy_route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fastapi_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}
