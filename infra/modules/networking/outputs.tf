# Outputs del módulo de networking
# TODO(reto): Exporta los IDs de VPC y subredes para ser usados por otros módulos

output "vpc_id" {
  description = "ID de la VPC"
  value = null # TODO(reto): aws_vpc.main.id
}

# TODO(reto): Exportar IDs de subredes públicas y privadas