provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}
#we need to create a ZIP file because aws_lambda_function needs the code to be stored in a ZIP file
#in order to upload to AWS.

data "archive_file" "zip_the_python_code" {
    type        = "zip"
    source_file  = "lambda.py"
    output_path = "lambda.zip"
    }

resource "aws_lambda_function" "terraform_lambda_function" {
    filename                       = "lambda.zip"
    function_name                  = "${var.function_name}"
    role                           = aws_iam_role.lambda_role.arn
    handler                        = "${var.handler}"
    runtime                        = "${var.runtime}"

    }

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 3
 
}