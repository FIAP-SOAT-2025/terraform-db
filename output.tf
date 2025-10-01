output "db_instance_address" {
  description = "O endereço (endpoint) da instância RDS."
  value       = aws_db_instance.db_instance.address
}

output "db_instance_port" {
  description = "A porta de conexão da instância RDS."
  value       = aws_db_instance.db_instance.port
}