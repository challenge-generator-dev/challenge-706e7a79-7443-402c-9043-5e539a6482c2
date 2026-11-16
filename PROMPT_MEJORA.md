# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/modules/networking/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/networking/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/compute/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/compute/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/messaging/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/messaging/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/messaging init -backend=false && terraform -chdir=modules/networking init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/messaging validate && terraform -chdir=modules/networking validate` — componente `infra` (practice).
2. `cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package` — componente `api` (chapter, support).

### Contratos entre componentes

- `api` expone http (api: http://localhost:8080):
  - `POST /api/orders`
  - `GET /api/orders/{id}`
  - `PUT /api/orders/{id}`
  - `DELETE /api/orders/{id}`

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `api/src/main/java/com/orderservice/application/OrderService.java` — `UpdateOrderRequest.getItems`: Se invoca `getItems` sobre `UpdateOrderRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/application/OrderService.java` — `UpdateOrderRequest.getCustomerId`: Se invoca `getCustomerId` sobre `UpdateOrderRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/messaging init -backend=false && terraform -chdir=modules/networking init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/messaging validate && terraform -chdir=modules/networking validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform, Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Aprovisionar infraestructura AWS para el servicio de ordenes con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configurar el entorno de Terraform — objetivo: Establecer el entorno de Terraform para comenzar a aprovisionar la infraestructura. — entregable (NO resolver): Entorno de Terraform configurado y listo para aprovisionar la infraestructura.
- Fase 2: Definir los recursos de la infraestructura — objetivo: Definir los recursos de la infraestructura AWS necesarios para el servicio de ordenes. — entregable (NO resolver): Archivos de Terraform que definen los recursos de la infraestructura AWS.
- Fase 3: Aprovisionar y versionar la infraestructura — objetivo: Aprovisionar la infraestructura definida y versionarla utilizando Git. — entregable (NO resolver): Infraestructura AWS aprovisionada y versionada en un repositorio Git.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/README.md ===
# Terraform AWS Infrastructure

## Project Structure

```
.
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── database/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── messaging/
│       ├── main.tf
│       └── outputs.tf
├── versions.tf
├── providers.tf
└── README.md
```

## Prerequisites

1. **Terraform**: Install Terraform CLI (v1.5+ recommended)
   ```bash
   brew install terraform  # macOS
   choco install terraform # Windows
   ```

2. **AWS CLI**: Configure AWS credentials
   ```bash
   aws configure
   ```
   Ensure your IAM user has sufficient permissions to create the resources defined in the modules.

3. **AWS Provider**: This project uses AWS Provider v5.x

## Setup Instructions

### Initialize Terraform
```bash
cd environments/dev
terraform init
```

### Plan Infrastructure
```bash
terraform plan
```

### Apply Infrastructure
```bash
terraform apply
```

### Destroy Infrastructure
```bash
terraform destroy
```

## Modules Overview

### Networking
- VPC with CIDR block
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Route tables

### Compute
- EC2 instances
- Auto Scaling Groups
- Load Balancers
- Security Groups

### Database
- RDS instances
- DynamoDB tables
- ElastiCache clusters

### Messaging
- SQS queues
- SNS topics
- EventBridge rules

## Environment Configuration

Each environment (dev/prod) has its own:
- `main.tf`: Root module configuration
- `variables.tf`: Input variables
- `outputs.tf`: Output values
- `terraform.tfvars`: Environment-specific values (dev only)

## Validation

After applying, verify resources were created:
```bash
terraform output
aws ec2 describe-vpcs
aws rds describe-db-instances
```

## Best Practices

1. Never commit `terraform.tfvars` with sensitive data
2. Use remote state backend for team collaboration
3. Tag all resources for cost tracking
4. Review changes with `terraform plan` before applying

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# AWS Credentials and General Configuration
aws_region = "us-east-1"
aws_profile = "default"

# Networking Module Variables
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]

# Compute Module Variables
instance_type = "t3.micro"
key_name = "dev-keypair"
min_size = 1
max_size = 2
desired_capacity = 1

# Database Module Variables
db_instance_class = "db.t3.micro"
db_name = "devdb"
db_username = "admin"
db_password = "securepassword123" # In production, use secrets manager
allocated_storage = 20

# Messaging Module Variables
queue_name = "dev-events-queue"
topic_name = "dev-events-topic"

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/modules/networking/main.tf ===
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

// === ARCHIVO: infra/modules/networking/outputs.tf ===
# Outputs del módulo de networking
# TODO(reto): Exporta los IDs de VPC y subredes para ser usados por otros módulos

output "vpc_id" {
  description = "ID de la VPC"
  value = null # TODO(reto): aws_vpc.main.id
}

# TODO(reto): Exportar IDs de subredes públicas y privadas

// === ARCHIVO: infra/modules/compute/main.tf ===
# Módulo de compute para el servicio de órdenes
# TODO(reto): Define instancias EC2, Auto Scaling Groups y Load Balancers
# Requisitos:
# - Auto Scaling Group con 2 instancias EC2 (t3.medium) en subredes privadas
# - Load Balancer Application en subredes públicas
# - Security Groups para permitir tráfico HTTP/HTTPS y SSH (solo desde IPs específicas)
# - Launch Template con AMI Amazon Linux 2023 y user data para configuración inicial

# TODO(reto): Definir Launch Template
# TODO(reto): Definir Auto Scaling Group
# TODO(reto): Definir Load Balancer
# TODO(reto): Definir Security Groups

// === ARCHIVO: infra/modules/compute/outputs.tf ===
# Outputs del módulo de compute
# TODO(reto): Exporta los IDs de las instancias y el DNS del Load Balancer

# TODO(reto): Exportar DNS del Load Balancer

// === ARCHIVO: infra/modules/database/main.tf ===
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

// === ARCHIVO: infra/modules/database/outputs.tf ===
# Outputs del módulo de base de datos
# TODO(reto): Exporta el endpoint de la base de datos RDS

# TODO(reto): Exportar endpoint de RDS

// === ARCHIVO: infra/modules/messaging/main.tf ===
# Stub: Implementar recursos de mensajería (SQS/SNS)
# El estudiante debe definir:
# - Colas SQS para procesamiento de órdenes
# - Temas SNS para notificaciones
# - Suscripciones entre SQS y SNS
# - Políticas de dead-letter queue
# - Configuración de FIFO si aplica

# TODO(reto): Implementar aws_sqs_queue para órdenes
resource "aws_sqs_queue" "orders" {
}

# TODO(reto): Implementar cola dead-letter
resource "aws_sqs_queue" "orders_dlq" {
  # name = "dev-orders-dlq"
}

# TODO(reto): Implementar tema SNS para notificaciones de órdenes
resource "aws_sns_topic" "orders" {
  # name = "dev-orders-topic"
}

# TODO(reto): Implementar suscripción SQS -> SNS
# TODO(reto): implementa este bloque
# resource "aws_sns_topic_subscription" "orders_sqs" {
# }

// === ARCHIVO: infra/modules/messaging/outputs.tf ===
# Stub: Exports de recursos de mensajería
# El estudiante debe exportar:
# - URL de la cola de órdenes
# - URL de la cola dead-letter
# - ARN del tema SNS
# - ARN de la suscripción

# TODO(reto): Exportar URL de cola de órdenes
output "orders_queue_url" {
  value       = aws_sqs_queue.orders.url
  description = "URL de la cola de órdenes"
}

# TODO(reto): Exportar URL de cola dead-letter
output "orders_dlq_url" {
  value       = aws_sqs_queue.orders_dlq.url
  description = "URL de la cola dead-letter para mensajes fallidos"
}

# TODO(reto): Exportar ARN del tema SNS
output "orders_topic_arn" {
  value       = aws_sns_topic.orders.arn
  description = "ARN del tema SNS para notificaciones de órdenes"
}

# TODO(reto): Exportar ARN de suscripción
output "orders_subscription_arn" {
  value = null # TODO(reto): aws_sns_topic_subscription.orders_sqs.arn
  description = "ARN de la suscripción SNS a SQS"
}

// === ARCHIVO: infra/environments/dev/main.tf ===
# Stub: Configuración del entorno de desarrollo
# El estudiante debe:
# - Referenciar módulos de networking, compute, database, messaging
# - Usar variables del archivo variables.tf
# - Configurar tags específicos del entorno
# - Integrar todos los módulos del proyecto

# Consumir outputs de módulos existentes
# reference: modules/networking/outputs.tf
# reference: modules/compute/outputs.tf
# reference: modules/database/outputs.tf

# TODO(reto): Instanciar módulo de networking

# TODO(reto): Instanciar módulo de compute

# TODO(reto): Instanciar módulo de database

# TODO(reto): Instanciar módulo de messaging

# TODO(reto): Configurar outputs del entorno




// === ARCHIVO: infra/environments/prod/main.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  backend "s3" {
    bucket = "terraform-state-prod-orders"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

module "networking" {
  source = "../../modules/networking"
}

module "database" {
  source = "../../modules/database"
}

module "compute" {
  source = "../../modules/compute"
}

module "messaging" {
  source = "../../modules/messaging"
}

# TODO(reto): implementa este bloque
# resource "aws_s3_bucket" "orders_state" {
# }

# TODO(reto): implementa este bloque
# resource "aws_s3_bucket_versioning" "orders_state" {
# }

# TODO(reto): implementa este bloque
# resource "aws_cloudwatch_log_group" "orders_service" {
# }

# TODO(reto): implementa este bloque
# resource "aws_kms_key" "orders_encryption" {
# }

# TODO(reto): implementa este bloque
# resource "aws_kms_alias" "orders_encryption" {
# }

# TODO(reto): implementa este bloque
# resource "aws_security_group" "alb" {
# }

# TODO(reto): implementa este bloque
# resource "aws_lb" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_lb_target_group" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_lb_listener" "orders_https" {
# }

# TODO(reto): implementa este bloque
# resource "aws_ecs_cluster" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_ecs_task_definition" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_ecs_service" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_security_group" "ecs_tasks" {
# }

# TODO(reto): implementa este bloque
# resource "aws_appautoscaling_target" "ecs" {
# }

# TODO(reto): implementa este bloque
# resource "aws_appautoscaling_policy" "orders_cpu" {
# }

# TODO(reto): implementa este bloque
# resource "aws_appautoscaling_policy" "orders_memory" {
# }

# TODO(reto): implementa este bloque
# resource "aws_dynamodb_table" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_sns_topic_subscription" "orders_updates" {
# }

# TODO(reto): implementa este bloque
# resource "aws_sqs_queue_policy" "orders_dlq" {
# }

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value = null # TODO(reto): aws_ecs_cluster.orders.name
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value = null # TODO(reto): aws_ecs_service.orders.name
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value = null # TODO(reto): aws_dynamodb_table.orders.name
}

output "kms_key_arn" {
  description = "ARN de la clave KMS"
  value = null # TODO(reto): aws_kms_key.orders_encryption.arn
}

// === ARCHIVO: infra/environments/dev/variables.tf ===
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

// === ARCHIVO: infra/environments/prod/variables.tf ===
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

// === ARCHIVO: infra/environments/dev/outputs.tf ===
# Outputs específicos del entorno de desarrollo
# Superficie de práctica: el estudiante definirá los outputs necesarios

# TODO(reto): Exportar los outputs relevantes para el entorno de desarrollo
# El estudiante debe consumir los outputs de los módulos:
# - module.compute.instance_ids
# - module.compute.alb_dns_name
# - module.database.rds_endpoint
#
# Considerar qué información necesitan otros componentes o equipos
# sobre la infraestructura desplegada en desarrollo

// === ARCHIVO: infra/environments/prod/outputs.tf ===
# Outputs del entorno de producción
# Superficie de práctica: el estudiante debe implementar los outputs requeridos

output "vpc_id" {
  description = "ID de la VPC de producción"
  value       = module.networking.vpc_id
}

output "orders_queue_url" {
  description = "URL de la cola SQS de órdenes"
  value       = module.messaging.orders_queue_url
}

output "orders_dlq_url" {
  description = "URL de la cola SQS de letras muertas"
  value       = module.messaging.orders_dlq_url
}

output "orders_topic_arn" {
  description = "ARN del tema SNS de órdenes"
  value       = module.messaging.orders_topic_arn
}

output "service_url" {
  description = "URL pública del servicio de órdenes"
  value       = "http://${module.messaging.orders_queue_url}"
}

// === ARCHIVO: api/pom.xml ===
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.4.13</version>
        <relativePath/>
    </parent>

    <groupId>com.example</groupId>
    <artifactId>reto</artifactId>
    <version>1.0.0</version>
    <name>reto</name>

    <properties>
        <java.version>21</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-sns</artifactId>
            <version>1.12.797</version>
        </dependency>
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-sqs</artifactId>
            <version>1.12.797</version>
        </dependency>
        <dependency>
            <groupId>io.awspring.cloud</groupId>
            <artifactId>spring-cloud-aws-starter</artifactId>
            <version>3.4.2</version>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-aws-messaging</artifactId>
            <version>2.2.6.RELEASE</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>

// === ARCHIVO: api/src/main/java/com/orderservice/domain/Order.java ===
package com.orderservice.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    private String id;

    @NotNull
    private String customerId;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "order_id")
    private List<OrderItem> items;

    @NotNull
    private String status;

    @Positive
    private double totalAmount;

    private LocalDateTime createdAt;

    public Order() {
        this.id = UUID.randomUUID().toString();
        this.createdAt = LocalDateTime.now();
    }

    public Order(String customerId, List<OrderItem> items, String status, double totalAmount) {
        this.id = UUID.randomUUID().toString();
        this.customerId = customerId;
        this.items = items;
        this.status = status;
        this.totalAmount = totalAmount;
        this.createdAt = LocalDateTime.now();
    }

    public String getId() {
        return id;
    }

    public String getCustomerId() {
        return customerId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public String getStatus() {
        return status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void calculateTotalAmount() {
        this.totalAmount = items.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
    }

    @Entity
    @Table(name = "order_items")
    public static class OrderItem {
        @Id
        private String id;

        @NotNull
        private String productId;

        @Positive
        private int quantity;

        @Positive
        private double price;

        public OrderItem() {
            this.id = UUID.randomUUID().toString();
        }

        public OrderItem(String productId, int quantity, double price) {
            this.id = UUID.randomUUID().toString();
            this.productId = productId;
            this.quantity = quantity;
            this.price = price;
        }

        public String getId() {
            return id;
        }

        public String getProductId() {
            return productId;
        }

        public int getQuantity() {
            return quantity;
        }

        public double getPrice() {
            return price;
        }
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/domain/OrderRepository.java ===
package com.orderservice.domain;

import java.util.Optional;

public interface OrderRepository {
    Order save(Order order);
    Optional<Order> findById(String id);
    void deleteById(String id);
}

// === ARCHIVO: api/src/main/java/com/orderservice/application/OrderService.java ===
package com.orderservice.application;

import com.orderservice.domain.Order;
import com.orderservice.domain.OrderRepository;
import jakarta.validation.Valid;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class OrderService {
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public Order createOrder(@Valid CreateOrderRequest request) {
        List<Order.OrderItem> items = request.getItems().stream()
                .map(item -> new Order.OrderItem(item.getProductId(), item.getQuantity(), item.getPrice()))
                .collect(Collectors.toList());

        Order order = new Order(request.getCustomerId(), items, "CREATED", 0.0);
        order.calculateTotalAmount();
        return orderRepository.save(order);
    }

    public Order getOrder(String id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new OrderNotFoundException("Order not found with id: " + id));
    }

    public Order updateOrder(String id, @Valid UpdateOrderRequest request) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new OrderNotFoundException("Order not found with id: " + id));

        order.setStatus(request.getStatus());
        return orderRepository.save(order);
    }

    public void deleteOrder(String id) {
        if (!orderRepository.findById(id).isPresent()) {
            throw new OrderNotFoundException("Order not found with id: " + id);
        }
        orderRepository.deleteById(id);
    }
}

class OrderNotFoundException extends RuntimeException {
    public OrderNotFoundException(String message) {
        super(message);
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/OrderJpaRepository.java ===
package com.orderservice.infrastructure;

import com.orderservice.domain.Order;
import com.orderservice.domain.OrderRepository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface OrderJpaRepository extends JpaRepository<Order, String>, OrderRepository {
    @Override
    default Order save(Order order) {
        return saveAndFlush(order);
    }

    @Override
    default Optional<Order> findById(String id) {
        return findById(id);
    }

    @Override
    default void deleteById(String id) {
        deleteById(id);
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/AwsConfig.java ===
package com.orderservice.infrastructure;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.AmazonSNSClientBuilder;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;

@Configuration
public class AwsConfig {

    @Bean
    public AmazonSQS amazonSQS() {
        return AmazonSQSClientBuilder.standard()
                .withEndpointConfiguration(
                        new AwsClientBuilder.EndpointConfiguration(
                                System.getenv("AWS_SQS_ENDPOINT"),
                                System.getenv("AWS_REGION")
                        )
                )
                .withCredentials(
                        new AWSStaticCredentialsProvider(
                                new BasicAWSCredentials(
                                        System.getenv("AWS_ACCESS_KEY_ID"),
                                        System.getenv("AWS_SECRET_ACCESS_KEY")
                                )
                        )
                )
                .build();
    }

    @Bean
    public AmazonSNS amazonSNS() {
        return AmazonSNSClientBuilder.standard()
                .withEndpointConfiguration(
                        new AwsClientBuilder.EndpointConfiguration(
                                System.getenv("AWS_SNS_ENDPOINT"),
                                System.getenv("AWS_REGION")
                        )
                )
                .withCredentials(
                        new AWSStaticCredentialsProvider(
                                new BasicAWSCredentials(
                                        System.getenv("AWS_ACCESS_KEY_ID"),
                                        System.getenv("AWS_SECRET_ACCESS_KEY")
                                )
                        )
                )
                .build();
    }
}

// === ARCHIVO: api/src/main/resources/application.yml ===
spring:
  application:
    name: order-service
  datasource:
    url: ${DB_URL:jdbc:postgresql://localhost:5432/ordersdb}
    username: ${DB_USERNAME:postgres}
    password: ${DB_PASSWORD:postgres}
    driver-class-name: org.postgresql.Driver
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
  security:
    user:
      name: ${SECURITY_USER:admin}
      password: ${SECURITY_PASSWORD:admin123}

aws:
  region: ${AWS_REGION:us-east-1}
  sns:
    topic-arn: ${SNS_TOPIC_ARN:}
  sqs:
    queue-url: ${SQS_QUEUE_URL:}

server:
  port: ${SERVER_PORT:8080}

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: always
  metrics:
    export:
      prometheus:
        enabled: true

logging:
  level:
    com.orderservice: INFO
    org.springframework.web: INFO
    org.hibernate.SQL: WARN
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
    file: "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n"

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/SnsOrderPublisher.java ===
package com.orderservice.infrastructure;

import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.orderservice.domain.Order;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class SnsOrderPublisher {

    private static final Logger logger = LoggerFactory.getLogger(SnsOrderPublisher.class);
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    private final AmazonSNS amazonSNS;
    private final ObjectMapper objectMapper;
    private final String topicArn;

    public SnsOrderPublisher(
            AwsConfig awsConfig,
            ObjectMapper objectMapper,
            @Value("${aws.sns.topic-arn:}") String topicArn) {
        this.amazonSNS = awsConfig.amazonSNS();
        this.objectMapper = objectMapper;
        this.topicArn = topicArn;
    }

    public void publishOrderCreated(Order order) {
        if (topicArn == null || topicArn.isBlank()) {
            logger.warn("SNS topic ARN no configurado, omitiendo publicación de orden creada: {}", order.getId());
            return;
        }

        try {
            Map<String, Object> message = buildOrderMessage(order, "ORDER_CREATED");
            String jsonMessage = objectMapper.writeValueAsString(message);

            PublishRequest request = new PublishRequest()
                    .withTopicArn(topicArn)
                    .withSubject("Nueva orden creada")
                    .withMessage(jsonMessage)
                    .withMessageGroupId(order.getCustomerId());

            PublishResult result = amazonSNS.publish(request);
            logger.info("Orden {} publicada en SNS con mensaje ID: {}", order.getId(), result.getMessageId());
        } catch (JsonProcessingException e) {
            logger.error("Error al serializar mensaje de orden {}: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden en SNS", e);
        } catch (Exception e) {
            logger.error("Error al publicar orden {} en SNS: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden en SNS", e);
        }
    }

    public void publishOrderUpdated(Order order) {
        if (topicArn == null || topicArn.isBlank()) {
            logger.warn("SNS topic ARN no configurado, omitiendo publicación de orden actualizada: {}", order.getId());
            return;
        }

        try {
            Map<String, Object> message = buildOrderMessage(order, "ORDER_UPDATED");
            String jsonMessage = objectMapper.writeValueAsString(message);

            PublishRequest request = new PublishRequest()
                    .withTopicArn(topicArn)
                    .withSubject("Orden actualizada")
                    .withMessage(jsonMessage)
                    .withMessageGroupId(order.getCustomerId());

            PublishResult result = amazonSNS.publish(request);
            logger.info("Orden {} actualizada publicada en SNS con mensaje ID: {}", order.getId(), result.getMessageId());
        } catch (JsonProcessingException e) {
            logger.error("Error al serializar mensaje de orden actualizada {}: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden actualizada en SNS", e);
        } catch (Exception e) {
            logger.error("Error al publicar orden actualizada {} en SNS: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden actualizada en SNS", e);
        }
    }

    public void publishOrderDeleted(String orderId, String customerId) {
        if (topicArn == null || topicArn.isBlank()) {
            logger.warn("SNS topic ARN no configurado, omitiendo publicación de orden eliminada: {}", orderId);
            return;
        }

        try {
            Map<String, Object> message = new HashMap<>();
            message.put("eventType", "ORDER_DELETED");
            message.put("orderId", orderId);
            message.put("customerId", customerId);
            message.put("timestamp", LocalDateTime.now().format(FORMATTER));

            String jsonMessage = objectMapper.writeValueAsString(message);

            PublishRequest request = new PublishRequest()
                    .withTopicArn(topicArn)
                    .withSubject("Orden eliminada")
                    .withMessage(jsonMessage)
                    .withMessageGroupId(customerId);

            PublishResult result = amazonSNS.publish(request);
            logger.info("Orden {} eliminada publicada en SNS con mensaje ID: {}", orderId, result.getMessageId());
        } catch (JsonProcessingException e) {
            logger.error("Error al serializar mensaje de orden eliminada {}: {}", orderId, e.getMessage());
            throw new RuntimeException("Error al publicar orden eliminada en SNS", e);
        } catch (Exception e) {
            logger.error("Error al publicar orden eliminada {} en SNS: {}", orderId, e.getMessage());
            throw new RuntimeException("Error al publicar orden eliminada en SNS", e);
        }
    }

    private Map<String, Object> buildOrderMessage(Order order, String eventType) {
        Map<String, Object> message = new HashMap<>();
        message.put("eventType", eventType);
        message.put("orderId", order.getId());
        message.put("customerId", order.getCustomerId());
        message.put("status", order.getStatus());
        message.put("totalAmount", order.getTotalAmount());
        message.put("createdAt", order.getCreatedAt() != null ? order.getCreatedAt().format(FORMATTER) : null);
        message.put("timestamp", LocalDateTime.now().format(FORMATTER));

        if (order.getItems() != null) {
            List<Map<String, Object>> itemsList = order.getItems().stream()
                    .map(item -> {
                        Map<String, Object> itemMap = new HashMap<>();
                        itemMap.put("productId", item.getProductId());
                        itemMap.put("quantity", item.getQuantity());
                        itemMap.put("price", item.getPrice());
                        return itemMap;
                    })
                    .toList();
            message.put("items", itemsList);
        }

        return message;
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/Application.java ===
package com.orderservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@ComponentScan(basePackages = {
    "com.orderservice.domain",
    "com.orderservice.application",
    "com.orderservice.infrastructure",
    "com.orderservice.api"
})
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/**")
                        .allowedOrigins("*")
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                        .allowedHeaders("*")
                        .maxAge(3600);
            }
        };
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/application/CreateOrderRequest.java ===
package com.orderservice.application;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;

import java.util.List;

public class CreateOrderRequest {
    @NotBlank(message = "Customer ID is required")
    private String customerId;

    @NotEmpty(message = "Items list cannot be empty")
    @Valid
    private List<OrderItemRequest> items;

    @NotBlank(message = "Payment method is required")
    private String paymentMethod;

    public CreateOrderRequest() {
    }

    public CreateOrderRequest(String customerId, List<OrderItemRequest> items, String paymentMethod) {
        this.customerId = customerId;
        this.items = items;
        this.paymentMethod = paymentMethod;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public List<OrderItemRequest> getItems() {
        return items;
    }

    public void setItems(List<OrderItemRequest> items) {
        this.items = items;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/application/UpdateOrderRequest.java ===
package com.orderservice.application;

import jakarta.validation.constraints.NotBlank;

public class UpdateOrderRequest {
    @NotBlank(message = "Status is required")
    private String status;

    public UpdateOrderRequest() {
    }

    public UpdateOrderRequest(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/application/OrderItemRequest.java ===
package com.orderservice.application;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public class OrderItemRequest {
    @NotBlank(message = "Product ID is required")
    private String productId;

    @NotNull(message = "Quantity is required")
    @Positive(message = "Quantity must be positive")
    private Integer quantity;

    @NotNull(message = "Price is required")
    @Positive(message = "Price must be positive")
    private Double price;

    public OrderItemRequest() {
    }

    public OrderItemRequest(String productId, Integer quantity, Double price) {
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
```
