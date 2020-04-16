resource "aws_iam_policy" "OLBCloudwatch" {
  name        = "OLB_CloudWatch"
  path        = "/"
  description = "Policy for OLB to allow access to cloudwatch"

  policy = file("IAM Policies/OLB_Cloudwatch.txt")
}

resource "aws_iam_policy" "OLBInstanceAdmin" {
  name        = "OLB_Instance_Admin"
  path        = "/"
  description = "Policy for OLB to allow access to Ec2"

  policy = file("IAM Policies/OLB_Instance_Admin.txt")
}

resource "aws_iam_policy" "OLBR53" {
  name        = "OLB_Route53"
  path        = "/"
  description = "Policy for OLB to allow access to Route 53"

  policy = file("IAM Policies/OLB_Route53.txt")
}

resource "aws_iam_policy" "OLBS3" {
  name        = "OLB_S3"
  path        = "/"
  description = "Policy for OLB to allow access to S3"

  policy = file("IAM Policies/OLB_S3.txt") 
}



resource "aws_iam_role" "OLBServer" {
  name = "OLB_Server"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}


resource "aws_iam_role_policy_attachment" "OLBCloudwatchAttach" {
  role       =aws_iam_role.OLBServer.name
  policy_arn = aws_iam_policy.OLBCloudwatch.arn
}
resource "aws_iam_role_policy_attachment" "OLBInstanceAdminAttach" {
  role       = aws_iam_role.OLBServer.name
  policy_arn = aws_iam_policy.OLBInstanceAdmin.arn
}
resource "aws_iam_role_policy_attachment" "OLBR53Attach" {
  role       = aws_iam_role.OLBServer.name
  policy_arn = aws_iam_policy.OLBR53.arn
}
resource "aws_iam_role_policy_attachment" "S3Attach" {
  role       = aws_iam_role.OLBServer.name
  policy_arn = aws_iam_policy.OLBS3.arn
}


resource "aws_iam_policy_attachment" "AmazonEC2RoleforSSM" {
  name = "AmazonEC2RoleforSSM"
  roles = [ aws_iam_role.OLBServer.name ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}
resource "aws_iam_policy_attachment" "AmazonEC2ReadOnlyAccess" {
  name = "AmazonEC2ReadOnlyAccess"
  roles = [ aws_iam_role.OLBServer.name ]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
resource "aws_iam_policy_attachment" "AmazonSSMReadOnlyAccess" {
  name = "AmazonSSMReadOnlyAccess"
  roles = [ aws_iam_role.OLBServer.name ]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}


resource "aws_iam_instance_profile" "OLB_Server" {
  name = "OLB_Server"
  role = aws_iam_role.OLBServer.name
}