# Módulo de base de datos para el servicio de órdenes
# TODO(reto): Define la base de datos RDS
# Requisitos:
# - Instancia RDS PostgreSQL (db.t3.medium) en subredes privadas
# - Multi-AZ para alta disponibilidad
# - Storage de 100GB con gp3
# - Backup retention de 7 días
# - Security Group para permitir tráfico solo desde las instancias EC2

# TODO(reto): implementa este bloque
# resource "aws_db_subnet_group" "orders" {
# }

# TODO(reto): Definir instancia RDS PostgreSQL
# TODO(reto): Definir Security Group para RDS