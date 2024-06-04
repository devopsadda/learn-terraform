resource "aws_iam_role" "doa_iam_s3_access_for_ec2" {
  name = "cp_b00_s3_access"

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
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}
resource "aws_iam_role_policy" "doa_s3_access_policy" {
  name = "s3_access_limited"
  role = aws_iam_role.doa_iam_s3_access_for_ec2.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListAllMyBuckets",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect : "Allow"
        Resource = ["arn:aws:s3:::mtanvir-react-app-artifactsv", "arn:aws:s3:::mtanvir-react-app-artifactsv/*"]
      }
    ]
  })
}
resource "aws_iam_instance_profile" "doa_instance_profile" {
  name = "doa-instnace-profile"
  role = aws_iam_role.doa_iam_s3_access_for_ec2.name
}
