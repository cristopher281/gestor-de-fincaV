# AgroControl Backend

API RESTful para la gestión integral de fincas (personal, planillas, préstamos, inventario, finanzas, OCR, informes).

## Tecnologías
- Node.js + Express
- MongoDB Atlas (Free Tier)
- Firebase Authentication
- Firebase Storage
- OCR.space API

## Estructura sugerida
- `/src` Código fuente
- `/src/routes` Rutas de la API
- `/src/controllers` Lógica de negocio
- `/src/models` Modelos de datos (Mongoose)
- `/src/middleware` Middlewares

## Comandos básicos
- `npm install` para instalar dependencias
- `npm run dev` para desarrollo (con nodemon)

## Configuración
- Variables de entorno en `.env` (MongoDB URI, claves Firebase, etc.)

---

Desarrolla primero la autenticación y gestión de trabajadores para un MVP rápido.
