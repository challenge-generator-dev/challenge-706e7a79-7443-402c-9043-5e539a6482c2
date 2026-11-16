# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Aprovisionar infraestructura AWS para el servicio de ordenes con Terraform**.

| | |
|---|---|
| Tema | infraestructura como codigo para el servicio de ordenes |
| Nivel | senior-l2 |
| Chapter | Backend |
| Especialidad | Terraform (AWS) |
| Stack | Terraform / AWS Provider |
| Patron arquitectonico | infraestructura como código con módulos reutilizables |
| Tiempo estimado | 8 horas |

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

## Receta del stack

Esqueleto obligatorio:

- `main.tf con los recursos`
- `variables.tf con las variables (sin default)`
- `outputs.tf con los valores expuestos`
- `versions.tf con required_version y required_providers`
- `environments/dev/terraform.tfvars con los valores`
- `README.md con la topologia y como validar (init -backend=false, validate)`

Trampas conocidas:

- NUNCA incluyas `apply`, `destroy` ni `deploy` (terraform apply/destroy, cdk deploy/destroy, sam deploy, aws cloudformation deploy) en README, scripts ni instrucciones: el reto se valida y se revisa, no se despliega.
- Cero credenciales hardcodeadas: nada de claves `AKIA...`, `aws_secret_access_key` ni `secret_key` literales. La autenticacion la resuelve el entorno del candidato (perfil o variables de entorno), nunca el codigo.
- Sin backend remoto real: nada de `backend "s3"` con un bucket concreto. Usa estado local (`backend "local"`) o no declares backend; la verificacion corre con `init -backend=false`.
- `versions.tf` declara `required_version` como RANGO (`>= 1.5`) y `required_providers` con `source = "hashicorp/aws"` y `version = "~> 5.0"` (una version que exista); nunca versiones exactas.
- Las variables de `variables.tf` NO llevan `default`: todos los valores van en `environments/dev/terraform.tfvars`.
- Para leer recursos que ya existen usa data sources (`aws_kms_key`, `aws_iam_role`, `aws_dynamodb_table`...) por nombre o alias, nunca `terraform_remote_state`.
- El codigo tiene que pasar `terraform fmt -check`: indentacion de 2 espacios y `=` alineados dentro de cada bloque.

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/messaging init -backend=false && terraform -chdir=modules/networking init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/messaging validate && terraform -chdir=modules/networking validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/messaging init -backend=false && terraform -chdir=modules/networking init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/messaging validate && terraform -chdir=modules/networking validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configurar el entorno de Terraform**: Entorno de Terraform configurado y listo para aprovisionar la infraestructura.
- **Fase 2 — Definir los recursos de la infraestructura**: Archivos de Terraform que definen los recursos de la infraestructura AWS.
- **Fase 3 — Aprovisionar y versionar la infraestructura**: Infraestructura AWS aprovisionada y versionada en un repositorio Git.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/modules/networking/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/networking/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/compute/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/compute/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/database/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/database/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/messaging/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/messaging/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/environments/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/environments/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/environments/dev/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/environments/prod/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/environments/dev/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/environments/prod/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Lo que falta y tenes que completar

### 1. Referencias colgando (2)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `api/src/main/java/com/orderservice/application/OrderService.java` — `UpdateOrderRequest.getItems`
      Se invoca `getItems` sobre `UpdateOrderRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/orderservice/application/OrderService.java` — `UpdateOrderRequest.getCustomerId`
      Se invoca `getCustomerId` sobre `UpdateOrderRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (30)

- `infra/README.md`
- `infra/environments/dev/terraform.tfvars`
- `infra/versions.tf`
- `infra/providers.tf`
- `infra/modules/networking/main.tf`
- `infra/modules/networking/outputs.tf`
- `infra/modules/compute/main.tf`
- `infra/modules/compute/outputs.tf`
- `infra/modules/database/main.tf`
- `infra/modules/database/outputs.tf`
- `infra/modules/messaging/main.tf`
- `infra/modules/messaging/outputs.tf`
- `infra/environments/dev/main.tf`
- `infra/environments/prod/main.tf`
- `infra/environments/dev/variables.tf`
- `infra/environments/prod/variables.tf`
- `infra/environments/dev/outputs.tf`
- `infra/environments/prod/outputs.tf`
- `api/pom.xml`
- `api/src/main/java/com/orderservice/domain/Order.java`
- `api/src/main/java/com/orderservice/domain/OrderRepository.java`
- `api/src/main/java/com/orderservice/application/OrderService.java`
- `api/src/main/java/com/orderservice/infrastructure/OrderJpaRepository.java`
- `api/src/main/java/com/orderservice/infrastructure/AwsConfig.java`
- `api/src/main/resources/application.yml`
- `api/src/main/java/com/orderservice/infrastructure/SnsOrderPublisher.java`
- `api/src/main/java/com/orderservice/Application.java`
- `api/src/main/java/com/orderservice/application/CreateOrderRequest.java`
- `api/src/main/java/com/orderservice/application/UpdateOrderRequest.java`
- `api/src/main/java/com/orderservice/application/OrderItemRequest.java`

### Capas del patron declarado

Son las capas que la propuesta arquitectonica plantea, marcadas segun existan hoy en el repo. Orientan donde poner el codigo nuevo; no son una condicion para compilar.

- `infra` (presente)
- `infra/modules/networking` (presente)
- `infra/modules/compute` (presente)
- `infra/modules/database` (presente)
- `infra/modules/messaging` (presente)
- `infra/environments/dev` (presente)
- `infra/environments/prod` (presente)
- `api` (presente)
- `api/src/main/java/com/orderservice/domain` (presente)
- `api/src/main/java/com/orderservice/application` (presente)
- `api/src/main/java/com/orderservice/infrastructure` (presente)
- `api/src/main/resources` (presente)

## Verificacion

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/messaging init -backend=false && terraform -chdir=modules/networking init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/messaging validate && terraform -chdir=modules/networking validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **infraestructura como código con módulos reutilizables**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform, Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes
- Mision: Versionar la infraestructura del servicio

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
