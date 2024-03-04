# Create MariDB Subnet
resource "aws_db_subnet_group" "Mariadb_private" {
    name = "Mariadb_private"
    subnet_ids = [ aws_subnet.private_subnet-1.id, aws_subnet.private_subnet-2.id ]
    description = "mariadb subnet"
}

# RDS parameter
resource "aws_db_parameter_group" "mariabd_parameter" {
  name = "mariadb_parameter"
  family = "mariadb10.4"
  description = "mariadb parameter"

  parameter {
    name = "max_allowed_packet"
    value = "16777216"
  }
}

# Create mariadb Instance

resource "aws_db_instance" "maridb_instace" {
  allocated_storage = 20
  engine = "mariadb"
  engine_version = "10.4.8"
  instance_class = "db.t2.micro"
  identifier = "mariadb"
  username = "root"
  password = "mariadb123"
  db_subnet_group_name = aws_db_subnet_group.Mariadb_private.name
  parameter_group_name = aws_db_parameter_group.mariabd_parameter.name
  multi_az = "false"
  vpc_security_group_ids = [aws_security_group.allow_mariadb.id]
  storage_type = "gp2"
  backup_retention_period = 30
  availability_zone = aws_subnet.private_subnet-1.availability_zone
  skip_final_snapshot = true

  tags = {
    name = "mariadb_instance"
  }
}