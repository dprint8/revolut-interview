resource "aws_security_group" "alb_sg" {
  name        = "elb-security-group"
  description = "Security group for the LB"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "api_sg" {
  name        = "api-security-group"
  description = "Security group for the API app"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = aws_security_group.alb_sg.id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "users_db" {
  name        = "users-db-security-group"
  description = "Security group for the users database"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.api_sg.id

  }

  egress {
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    source_security_group_id = aws_security_group.api_sg.id
  }
}
