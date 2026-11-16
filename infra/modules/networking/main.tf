# Módulo de networking para el servicio de órdenes
# TODO(reto): Define la VPC, subredes públicas y privadas, y tablas de ruteo.
# Requisitos:
# - VPC con CIDR 10.0.0.0/16
# - 2 subredes públicas en AZs distintas con CIDR 10.0.1.0/24 y 10.0.2.0/24
# - 2 subredes privadas en AZs distintas con CIDR 10.0.3.0/24 y 10.0.4.0/24
# - Internet Gateway para las subredes públicas
# - NAT Gateway en cada subred pública para las subredes privadas
# - Tablas de ruteo para subredes públicas y privadas

# TODO(reto): implementa este bloque
# resource "aws_vpc" "main" {
# }

# TODO(reto): Definir subredes públicas y privadas
# TODO(reto): Definir Internet Gateway
# TODO(reto): Definir NAT Gateways
# TODO(reto): Definir tablas de ruteo