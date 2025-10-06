resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.projectName}-db-subnet-group-v1"
  subnet_ids = data.terraform_remote_state.infra.outputs.private_subnet_ids

  tags = {
    Name = "${var.projectName}-db-subnet-group-v1"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.projectName}-rds-sg-v1"
  description = "Allow traffic from the application security group to the PostgreSQL port."
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    description     = "Allow traffic from the application SG to the PostgreSQL port"
    security_groups = [data.terraform_remote_state.infra.outputs.cluster_security_group_id]

    
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.projectName}-rds-sg"
  }
}

resource "aws_db_instance" "db_instance" {
  identifier             = "${var.projectName}-postgres-db-v1"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible    = false
  multi_az               = false
  skip_final_snapshot    = true
  backup_retention_period = 7
  deletion_protection    = false

  tags = {
    Name = "${var.projectName}-postgres-db-v1"
  }
}