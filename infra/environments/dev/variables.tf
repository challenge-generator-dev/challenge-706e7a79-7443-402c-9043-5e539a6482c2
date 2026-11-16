# Variables específicas para el entorno de desarrollo
# Superficie de práctica: el estudiante definirá las variables necesarias

variable "env_name" {
  description = "Nombre del entorno"
  type        = string
  default     = "dev"
}

# TODO(reto): Definir las variables específicas para el entorno de desarrollo
# Sugerencias:
# - Variables para ajustar recursos según el entorno (tamaños de instancia, etc.)
# - Variables de configuración específicas de desarrollo
# - Considerar diferencias en disponibilidad y redundancia vs producción