variable "projectName" {
  description = "The name of the project"
  default     = "tc3-g38-lanchonete"
}

variable "db_user" {
  description = "O nome de usuário para o banco de dados RDS."
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "A senha para o usuário do banco de dados RDS."
  type        = string
  sensitive   = true
}

variable "access_token" {
  description = "O Access Token para integração com APIs externas."
  type        = string
  sensitive   = true
}


variable "db_name" {
  description = "O nome do banco de dados inicial a ser criado na instância RDS."
  type        = string
}
