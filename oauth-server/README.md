# OAuth Server

Authorization Server OAuth2 completo con JWT para microservicios.

## Funcionalidades Implementadas

- **Authorization Server**: Emisión de códigos de autorización
- **Token Endpoint**: Generación de access/refresh tokens JWT
- **UserInfo Endpoint**: Información de usuarios autenticados
- **JWKS Endpoint**: Claves públicas para validación de tokens
- **Clientes registrados**: oauth-client y oidc-client
- **Usuarios en memoria**: jose/123456

## Endpoints Principales

- `GET /oauth2/authorize` → Inicio de flujo OAuth2
- `POST /oauth2/token` → Intercambio de código por tokens
- `GET /oauth2/jwks` → Claves públicas RSA
- `GET /userinfo` → Información del usuario autenticado
- `GET /.well-known/openid-configuration` → Metadata OpenID

## Clientes Registrados

### oauth-client (Authorization Code Flow)
- **Client ID**: `oauth-client`
- **Client Secret**: `12345678910`
- **Grant Types**: `authorization_code`, `refresh_token`
- **Scopes**: `openid`, `profile`, `read`, `write`
- **Redirect URIs**: `http://localhost:8083/authorized`

### oidc-client (Authorization Code Flow)
- **Client ID**: `oidc-client`
- **Client Secret**: `123456789`
- **Grant Types**: `authorization_code`, `refresh_token`
- **Scopes**: `openid`, `profile`
- **Redirect URIs**: `https://oauthdebugger.com/debug`

## Configuración Docker

- **Puerto**: 9000
- **Perfil**: docker
- **Eureka**: `registry-service:8761`

## Testing con Postman

### 1. Authorization Code Flow
```bash
# Obtener código
GET http://localhost:9000/oauth2/authorize?response_type=code&client_id=oauth-client&scope=openid%20profile&redirect_uri=http://localhost:8083/authorized


# Intercambiar por token
POST http://localhost:9000/oauth2/token
Authorization: Basic (oauth-client:12345678910)
Body: code=[codigo]&grant_type=authorization_code&redirect_uri=http://localhost:8083/authorized
```

## Despliegue

```bash
docker-compose up --build oauth-server
```

## Health Check

- Endpoint: `http://localhost:9000/actuator/health`
- Estado esperado: `{"status":"UP"}`
