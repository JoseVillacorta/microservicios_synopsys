# Sistema de Pedidos - Microservicios

Arquitectura de microservicios para gestión de pedidos y productos usando Spring Boot, Spring Cloud y Docker.

## Servicios

- **API Gateway**: Enrutamiento, balanceo de carga y autenticación OAuth2
- **Eureka Server**: Registro y descubrimiento de servicios
- **Config Server**: Configuración centralizada
- **MS-Productos**: Gestión de catálogo de productos con OAuth2 Resource Server
- **OAuth Server**: Authorization Server OAuth2 con JWT
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
- `GET /oauth2/authorization/oauth-client` → Iniciar flujo OAuth2
- `GET /authorized` → Callback OAuth2 (maneja tokens)
- `GET /productos` → Listar productos (requiere autenticación)
- `POST /productos` → Crear producto (requiere autenticación)
- `GET /productos/{id}` → Obtener producto (requiere autenticación)
- `PUT /productos/{id}` → Actualizar producto (requiere autenticación)
- `DELETE /productos/{id}` → Eliminar producto (requiere autenticación)

### Eureka Dashboard (puerto 8761)
- `http://localhost:8761` → Ver servicios registrados

### Config Server (puerto 8888)
- `http://localhost:8888/{service}/docker` → Ver configuración
- `http://localhost:8888/oauth-server/docker` → Config OAuth2

### OAuth Server (puerto 9000)
- `http://localhost:9000/oauth2/authorize` → Autorización OAuth2
- `http://localhost:9000/oauth2/token` → Obtener tokens JWT
- `http://localhost:9000/oauth2/jwks` → Claves públicas JWT
- `http://localhost:9000/userinfo` → Información del usuario

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

```

### Con Docker
```bash
# Desarrollo completo
docker-compose up --build

# Solo servicios específicos
docker-compose up gateway ms-productos
```

## Notas de Desarrollo

- Los servicios usan perfiles: `dev` (local) y `docker` (contenedores)
- Base de datos PostgreSQL debe estar accesible en desarrollo
- Health checks aseguran dependencias antes de iniciar servicios
- Configuraciones se recargan automáticamente desde config-repo/

## Autenticación OAuth2

### Flujo de Autenticación
1. **Inicio**: `http://localhost:8083/oauth2/authorization/oauth-client`
2. **Login**: Usuario `jose` / Password `123456`
3. **Autorización**: Otorgar permisos (openid, profile)
4. **Callback**: Redirección automática a aplicación
5. **Acceso**: API protegida con Bearer Token JWT

### Credenciales OAuth2
- **Usuario**: `jose` / `123456`
- **Cliente**: `oauth-client` / `12345678910`
- **Scopes**: `openid`, `profile`, `read`, `write`

### Testing con Postman
```bash
# 1. Obtener token (Password Grant)
POST http://localhost:9000/oauth2/token
Authorization: Basic Auth (oauth-client / 12345678910)
Body: grant_type=password&username=jose&password=123456&scope=read

# 2. Usar token en API
GET http://localhost:8081/resources/user
Authorization: Bearer [access_token]
```