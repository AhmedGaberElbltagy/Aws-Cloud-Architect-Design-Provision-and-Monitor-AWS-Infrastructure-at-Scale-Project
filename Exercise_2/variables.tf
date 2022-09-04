variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "runtime" {
  type = string
  default = "python3.8"
}

variable "function_name" {
  type = string
  default = "lambda_function"
}
variable "handler" {
  type = string
  default = "lambda.lambda_handler"
}
