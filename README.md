# Sistema de Microservicios: Gestión de Pedidos

Sistema completo de microservicios desarrollado con Spring Boot, WebFlux, R2DBC, PostgreSQL, Kafka, OAuth2, Config Server, Eureka, Gateway, Prometheus y Grafana.

## 🚀 Servicios del Sistema

### Microservicios de Negocio

| Servicio | Puerto | Descripción | Documentación |
|----------|--------|-------------|---------------|
| **MS Productos V2** | 8083 | Gestión reactiva de productos con eventos Kafka | [README](ms-productos-v2/README.md) |
| **MS Pedidos** | 8082 | Gestión reactiva de pedidos con estados | [README](ms-pedidos/README.md) |
| **OAuth Server** | 9000 | Servidor de autorización OAuth2 con JWT | [README](oauth-server/README.md) |

### Servicios de Infraestructura

| Servicio | Puerto | Descripción | Documentación |
|----------|--------|-------------|---------------|
| **Gateway Service** | 8080 | API Gateway con enrutamiento y load balancing | [README](gateway/README.md) |
| **Config Server** | 8888 | Configuración centralizada con Spring Cloud Config | [README](ms-config-server/README.md) |
| **Registry Service** | 8761 | Service Registry con Eureka | [README](registry-service/README.md) |

### Infraestructura y Monitoreo

| Componente | Puerto | Descripción |
|------------|--------|-------------|
| **Apache Kafka** | 9092 | Platform de streaming de eventos |
| **PostgreSQL - db_productos** | 5433 | Base de datos para productos |
| **PostgreSQL - db_pedidos** | 5434 | Base de datos para pedidos |
| **Prometheus** | 9090 | Sistema de monitoreo y métricas |
| **Grafana** | 3000 | Dashboard de visualización (admin/admin) |

## 🛠️ Setup Básico

### Prerrequisitos
- Java 21+
- Docker y Docker Compose
- Git


### URLs de Acceso Rápido

#### Servicios Principales
- **Gateway**: http://localhost:8080
- **MS Productos**: http://localhost:8080/api/productos
- **MS Pedidos**: http://localhost:8080/api/pedidos
- **Eureka Registry**: http://localhost:8761

#### Monitoreo
- **Grafana**: http://localhost:3000 (admin/admin)
- **Prometheus**: http://localhost:9090

### Scripts de Utilidad

```bash
# Compilar todos los servicios
./build.bat

# Iniciar todos los servicios
./start.bat

# Detener todos los servicios
./stop.bat

# Limpiar contenedores e imágenes
./clean.bat

# Ejecutar tests
./test.bat
```

## 📚 Enlaces Rápidos

### Documentación de APIs

**MS Productos V2:**
```bash
# Crear producto
curl -X POST http://localhost:8080/api/productos \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Producto","precio":100.0,"stock":10}'

# Listar productos
curl http://localhost:8080/api/productos

# Productos bajo stock
curl "http://localhost:8080/api/productos/bajo-stock?minimo=5"
```

**MS Pedidos:**
```bash
# Crear pedido
curl -X POST http://localhost:8080/api/pedidos \
  -H "Content-Type: application/json" \
  -d '{"cliente":{"nombre":"Juan"},"detalles":[{"productoId":1,"cantidad":2}]}'

# Listar pedidos
curl http://localhost:8080/api/pedidos

# Actualizar estado
curl -X PUT "http://localhost:8080/api/pedidos/1/estado?estado=CONFIRMADO"
```

### Health Checks

```bash
# Verificar estado de todos los servicios
curl http://localhost:8080/actuator/health        # Gateway
curl http://localhost:8083/actuator/health        # MS Productos
curl http://localhost:8082/actuator/health        # MS Pedidos
curl http://localhost:8888/actuator/health        # Config Server
curl http://localhost:8761/actuator/health        # Registry Service
```

### Kafka Events

```bash
# Consumir eventos de productos creados
docker-compose exec kafka kafka-console-consumer \
  --bootstrap-server kafka:9092 \
  --topic product-created \
  --from-beginning

# Listar topics
docker-compose exec kafka kafka-topics --list \
  --bootstrap-server kafka:9092
```
