resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_fxn/fido.zip"
  function_name = "fido_fetcher"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "fido.lambda_handler"
  runtime       = "python3.9"
}

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "s3:GetObject",
            "s3:GetObject*",
            "s3:List*"     
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "test-attach" {
  name = "test-role-attachment"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = aws_iam_policy.policy.arn
}

data "archive_file" "zip_fido"{
    type = "zip"
    source_dir = "${path.module}/lambda_fxn/"
    output_path = "${path.module}/lambda_fxn/fido.zip"
}

output "terraform_aws_role_output" {
  value = aws_iam_role.iam_for_lambda.name
}