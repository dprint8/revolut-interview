resource "aws_db_instance" "users" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = "myuser"
  password               = "" #do not commit this
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = false
  vpc_security_group_ids = [aws_security_group.users_db.id]
}
