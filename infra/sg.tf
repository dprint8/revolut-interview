resource "aws_security_group" "sg" {
  name        = "dev-security-group"
  description = "Security group for the LB"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
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



resource "aws_security_group" "users_db" {
  name_prefix = "users-security-group-"
}

resource "aws_security_group_rule" "example" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg.id
  security_group_id        = aws_security_group.users_db.id
}
