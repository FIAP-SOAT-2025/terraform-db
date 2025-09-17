output "db_service_name" {
  description = "Nome do service do PostgreSQL"
  value       = "postgres-db-service"
}

output "db_service_port" {
  description = "Porta do service do PostgreSQL"
  value       = 5432
}

output "db_namespace" {
  description = "Namespace do banco de dados"
  value       = "lanchonete-db"
}