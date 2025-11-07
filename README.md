# Sistema de Pedidos - Microservicios

Arquitectura de microservicios para gestión de pedidos y productos usando Spring Boot, Spring Cloud y Docker.

## Arquitectura

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   API Gateway   │────│  Eureka Server  │────│  Config Server  │
│     (8083)      │    │     (8761)      │    │     (8888)      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                        │                        │
         └────────────────────────┼────────────────────────┘
                                  │
                    ┌─────────────┴─────────────┐
                    │     PostgreSQL (5432)    │
                    │       syncap DB          │
                    └──────────────────────────┘
                                  │
                    ┌─────────────┴─────────────┐
                    │    MS-Productos (8081)   │
                    │   CRUD productos/stock   │
                    └──────────────────────────┘
```

## Servicios

- **API Gateway**: Enrutamiento y balanceo de carga
- **Eureka Server**: Registro y descubrimiento de servicios
- **Config Server**: Configuración centralizada
- **MS-Productos**: Gestión de catálogo de productos
- **PostgreSQL**: Base de datos principal

## Inicio Rápido

### Prerrequisitos
- Docker y Docker Compose
- PostgreSQL corriendo en localhost:5432 (opcional para desarrollo)

### Despliegue Completo
```bash
# Construir y ejecutar todos los servicios
docker-compose up --build

# Ejecutar en segundo plano
docker-compose up --build -d
```

### Verificar Estado
```bash
# Estado de contenedores
docker-compose ps

# Logs de servicios
docker-compose logs [service-name]
```

## Endpoints Principales

### API Gateway (puerto 8083)
- `GET /productos` → Listar productos
- `POST /productos` → Crear producto
- `GET /productos/{id}` → Obtener producto
- `PUT /productos/{id}` → Actualizar producto
- `DELETE /productos/{id}` → Eliminar producto

### Eureka Dashboard (puerto 8761)
- `http://localhost:8761` → Ver servicios registrados

### Config Server (puerto 8888)
- `http://localhost:8888/{service}/docker` → Ver configuración

## Configuración Docker

### Variables de Entorno
- `SPRING_PROFILES_ACTIVE=docker` → Perfil para contenedores
- `PROPERTIES_DIRECTORY=/config-repo` → Directorio de configs

### Redes y Comunicación
- **Red**: `microservicios` (Docker bridge)
- **Nombres de servicio**: Usados para DNS interno
- **Base de datos**: `host.docker.internal:5432` para acceso local

### Health Checks
Cada servicio incluye health checks automáticos:
- PostgreSQL: Verificación de conectividad
- Servicios: Endpoints `/actuator/health`
- Timeouts: 30s interval, 10s timeout, 5 retries

## Desarrollo Local

### Sin Docker
```bash
# Iniciar servicios individualmente
./gradlew bootRun  # En cada directorio

# O usar IDE con perfil 'dev'
```

### Con Docker (Recomendado)
```bash
# Desarrollo completo
docker-compose up --build

# Solo servicios específicos
docker-compose up gateway ms-productos
```

## Estructura del Proyecto

```
sistema-pedidos/
├── config-repo/           # Configuraciones centralizadas
│   ├── *.yaml            # Configs por servicio y perfil
│   └── README.md         # Documentación de configs
├── gateway/              # API Gateway
├── ms-config-server/     # Servidor de configuración
├── ms-product/           # Microservicio productos
├── registry-service/     # Eureka Server
├── docker-compose.yml    # Orquestación Docker
└── README.md            # Este archivo
```

## Solución de Problemas

### Puerto 5432 ocupado
```bash
# Detener PostgreSQL local
sudo service postgresql stop

# O cambiar puerto en docker-compose.yml
ports:
  - "5433:5432"
```

### Servicios no inician
```bash
# Ver logs específicos
docker-compose logs ms-productos

# Reconstruir imagen
docker-compose build ms-productos
```

### Configuraciones no cargan
```bash
# Verificar config server
curl http://localhost:8888/ms-productos/docker
```

## Notas de Desarrollo

- Los servicios usan perfiles: `dev` (local) y `docker` (contenedores)
- Base de datos PostgreSQL debe estar accesible en desarrollo
- Health checks aseguran dependencias antes de iniciar servicios
- Configuraciones se recargan automáticamente desde config-repo/

## Próximas Funcionalidades

- MS-Pedidos: Gestión de órdenes de compra
- Autenticación/Autorización con OAuth2
- Monitoreo con Spring Boot Actuator + Prometheus
- Logs centralizados con ELK Stack