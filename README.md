# Aprovisionar infraestructura AWS para el servicio de ordenes con Terraform

El equipo de desarrollo del servicio de ordenes necesita aprovisionar una infraestructura AWS utilizando Terraform. La infraestructura debe ser versionada para asegurar su reproducibilidad y consistencia. El dominio es la gestión de órdenes en una plataforma de comercio electrónico. Los actores involucrados son el Cliente, el Sistema de Pagos y el Almacén. El Cliente realiza una orden, el Sistema de Pagos verifica el pago y el Almacén procesa la orden para el envío. La infraestructura debe soportar un volumen pico de 10,000 órdenes por hora con una disponibilidad del 99.9%.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Maven 3.9+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `mvn compile` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configurar el entorno de Terraform

**Objetivo:** Establecer el entorno de Terraform para comenzar a aprovisionar la infraestructura.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar y configurar las variables de entorno necesarias para Terraform.
- Configurar el acceso a la cuenta de AWS.
- Crear un archivo main.tf inicial.

**Entregable:** Entorno de Terraform configurado y listo para aprovisionar la infraestructura.

<details>
<summary>Pistas de conocimiento</summary>

- Configuración de variables de entorno en Terraform.
- Autenticación y autorización en AWS.

</details>

### Fase 2: Definir los recursos de la infraestructura

**Objetivo:** Definir los recursos de la infraestructura AWS necesarios para el servicio de ordenes.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Identificar los recursos de AWS necesarios (VPC, subredes, instancias EC2, etc.).
- Definir estos recursos en los archivos de Terraform.
- Asegurar que los recursos cumplan con los requisitos de volumen y disponibilidad.

**Entregable:** Archivos de Terraform que definen los recursos de la infraestructura AWS.

<details>
<summary>Pistas de conocimiento</summary>

- Definición de recursos en Terraform.
- Requisitos de volumen y disponibilidad en AWS.

</details>

### Fase 3: Aprovisionar y versionar la infraestructura

**Objetivo:** Aprovisionar la infraestructura definida y versionarla utilizando Git.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Ejecutar los comandos de Terraform para aprovisionar la infraestructura.
- Versionar los archivos de Terraform en un repositorio Git.
- Realizar una corrida end-to-end para verificar la infraestructura.

**Entregable:** Infraestructura AWS aprovisionada y versionada en un repositorio Git.

<details>
<summary>Pistas de conocimiento</summary>

- Comandos de Terraform para aprovisionar la infraestructura.
- Versionado de archivos en Git.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve versionar la infraestructura con Git?
- **comoSeUsa**: ¿Cómo se configura el entorno de Terraform para aprovisionar la infraestructura?
- **erroresComunes**: ¿Cuáles son los errores comunes al definir recursos en Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el aprovisionamiento de la infraestructura y cómo se toman?

## Criterios de Evaluacion

- Configuración correcta del entorno de Terraform.
- Definición adecuada de los recursos de la infraestructura en Terraform.
- Aprovisionamiento exitoso de la infraestructura AWS.
- Versionado correcto de los archivos de Terraform en Git.
- Verificación de la infraestructura mediante una corrida end-to-end.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/messaging init -backend=false && terraform -chdir=modules/networking init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/messaging validate && terraform -chdir=modules/networking validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
