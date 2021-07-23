
#aws ec2 describe-subnets --no-paginate --filters "Name=default-for-az,Values=true" | egrep "(VpcId)|(SubnetId)"
resource "aws_security_group" "server-sg" {
  name   = "WebServerSecurityGroup"
  vpc_id = "vpc-b82e93c5"
  tags = {
    "Name" = "TF_WebServerSecurityGroup"
  }
  ingress {
    from_port       = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
    to_port         = 80
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 22
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = -1 
    to_port     = 0 #or u can write 3306
  }
}
resource "aws_security_group" "alb-sg" {
  name   = "ALBSecurityGroup"
  vpc_id = "vpc-b82e93c5"
  tags = {
    "Name" = "TF_ALBSecurityGroup"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = -1
    to_port     = 0
  }
}
resource "aws_security_group" "db-sg" {
  name   = "RDSSecurityGroup"
  vpc_id = "vpc-b82e93c5"
  tags = {
    "Name" = "TF_RDSSecurityGroup"
  }
  ingress {
    security_groups = [aws_security_group.server-sg.id]
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = -1
    to_port     = 0
  }
}