
resource "aws_iam_role" "ec2-read-only-role" {
  name = "ec2-read-only-role"  # Replace with the desired name for the IAM role

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ec2-readonly-policy" {
  name        = "read-only-policy"  # Replace with the desired name for the policy
  description = "Policy with read-only access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances", 
         "ec2:DescribeImages",
         "ec2:DescribeTags"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2-policy-attach" {
  role       = aws_iam_role.ec2-read-only-role.name
  policy_arn = aws_iam_policy.ec2-readonly-policy.arn
}

resource "aws_iam_instance_profile" "ec2-readonly" {
  name = "ec2-instance-profile"  # Replace with the desired name for the instance profile
  role = aws_iam_role.ec2-read-only-role.name
}
