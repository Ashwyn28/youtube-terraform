resource "aws_lambda_function" "fastapi_lambda" {
  function_name = "fastapi_lambda_docker"
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  image_uri     = "542248535090.dkr.ecr.us-east-1.amazonaws.com/audio-fastapi-app:v27"

  architectures = ["arm64"]

  timeout     = 15  # Adjust as needed
  memory_size = 256 # Adjust as needed

  # Environment variables (optional)
  # environment {
  #   variables = {
  #     VAR_NAME = "value"
  #   }
  # }
}
