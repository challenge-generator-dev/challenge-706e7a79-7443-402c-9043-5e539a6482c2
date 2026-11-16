# Variables específicas para el entorno de producción
# Superficie de práctica: el estudiante definirá las variables necesarias

variable "env_name" {
  description = "Nombre del entorno"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_instance_class" {
  description = "Clase de instancia de base de datos RDS"
  type        = string
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  description = "Almacenamiento asignado para RDS en GB"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "orders_db"
}

variable "db_username" {
  description = "Usuario administrador de la base de datos"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Contraseña del usuario administrador"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.medium"
}

variable "instance_count" {
  description = "Cantidad de instancias"
  type        = number
  default     = 3
}

variable "ami_id" {
  description = "ID de la AMI para las instancias"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "key_name" {
  description = "Nombre del par de claves SSH"
  type        = string
  default     = "prod-orders-key"
}

variable "sqs_queue_name" {
  description = "Nombre de la cola SQS"
  type        = string
  default     = "prod-orders-queue"
}

variable "sns_topic_name" {
  description = "Nombre del tema SNS"
  type        = string
  default     = "prod-orders-topic"
}

# TODO(reto): Definir las variables específicas para el entorno de producción
# Sugerencias:
# - Variables para configuraciones de alta disponibilidad
# - Variables para escalado y tolerancia a fallos
# - Considerar requisitos de cumplimiento y seguridad adicionales