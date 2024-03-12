module "levelup-vpc" {
    source = "../vpc"
    
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

#Define Subnet Group for RDS Service

resource "aws_db_subnet_group" "levelup_db_subnet" {
    name = "${var.ENVIRONMENT}-db-subnet"
    subnet_ids = [
      "${var.vpc_private_subnet-1}",
      "${var.vpc_private_subnet-2}",
    ]
}

# Define Security Group for RDS

resource "aws_security_group" "db_security_group" {
  vpc_id = var.vpc_id
  ingress {
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    cidr_blocks = ["${var.RDS_CIDR}"]
  
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "levelup-rds" {
   identifier = "${var.ENVIRONMENT}-levelup-rds"
   allocated_storage = var.LEVELUP_RDS_ALLOCATED_STORAGE
   storage_type = "gp2"
   engine = var.RDS_ENGINE
   engine_version = var.RDS_ENGINE_VERSION
   instance_class = var.DB_INSTANCE_CLASS
   backup_retention_period = var.BACKUP 
   publicly_accessible = var.PUBLIC 
   username = var.USER 
   password = var.PASSWD
   vpc_security_group_ids = [aws_security_group.db_security_group.id]
   db_subnet_group_name = aws_db_subnet_group.levelup_db_subnet.name
   multi_az = false

}

output "rds_endpoint" {
  value = aws_db_instance.levelup-rds.endpoint
}

