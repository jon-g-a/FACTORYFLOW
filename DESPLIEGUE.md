# 🏭 FactoryFlow — Guía de Despliegue

## Archivos del proyecto

```
factoryflow/
├── index.html          ← La aplicación completa
├── config.js           ← Tus credenciales de Supabase (editar)
└── supabase_schema.sql ← Schema de la base de datos
```

---

## PASO 1 — Crear la base de datos en Supabase

1. Ve a **https://supabase.com** → *Start your project* → inicia sesión con GitHub o email

2. Clic en **New project**
   - Pon un nombre: `factoryflow`
   - Elige una contraseña de base de datos (guárdala)
   - Región: `West EU (Ireland)` → más rápido desde España
   - Clic **Create new project** (tarda ~2 minutos)

3. Cuando esté listo, ve al menú izquierdo → **SQL Editor** → **New query**

4. Pega **todo el contenido** de `supabase_schema.sql` y haz clic en **Run** (▶)
   - Verás: *Success. No rows returned*

5. Ve a **Settings** → **API**
   - Copia **Project URL** → es tu `SUPABASE_URL`
   - Copia **anon public** (en Project API Keys) → es tu `SUPABASE_ANON_KEY`

---

## PASO 2 — Configurar las credenciales

Abre `config.js` y reemplaza los valores:

```js
window.SUPABASE_URL      = 'https://XXXXXXXX.supabase.co';
window.SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

Guarda el archivo.

---

## PASO 3 — Desplegar en Netlify (gratis)

### Opción A — Drag & Drop (más fácil, 2 minutos)

1. Ve a **https://netlify.com** → inicia sesión (puedes usar GitHub)
2. En el panel principal, busca la zona que dice:
   > *"Want to deploy a new site without connecting to Git? Drag and drop your site output folder here"*
3. **Arrastra la carpeta `factoryflow`** (la que contiene los 3 archivos) directamente ahí
4. Netlify desplegará en segundos y te dará una URL tipo:
   `https://nombre-aleatorio.netlify.app`

### Opción B — CLI desde terminal

```bash
# Instalar Netlify CLI
npm install -g netlify-cli

# Ir a la carpeta del proyecto
cd factoryflow

# Iniciar sesión y desplegar
netlify login
netlify deploy --prod --dir .
```

---

## PASO 4 — Dominio personalizado (opcional)

En Netlify → tu sitio → **Domain settings** → **Add custom domain**
- Puedes usar un dominio propio o el subdominio gratuito de Netlify

---

## ✅ Verificación

Una vez desplegado, abre la URL y deberías ver:
- La pantalla de carga "Conectando con la base de datos..."
- El tablero con los datos de ejemplo
- En la barra lateral inferior izquierda: **"Supabase ✓"**

Si ves el banner amarillo de advertencia → revisa que `config.js` tenga las credenciales correctas.

---

## 🔄 Tiempo real

Cualquier cambio (nueva tarea, mover tarjeta, comentario) se sincroniza automáticamente
en todos los navegadores abiertos — sin recargar la página.

---

## 🔁 Actualizar la app

Para subir cambios a Netlify:
- **Drag & Drop**: arrastra la carpeta de nuevo en Netlify (crea una nueva versión)
- **CLI**: `netlify deploy --prod --dir .`

---

## Costes

| Servicio | Plan | Coste |
|----------|------|-------|
| Supabase | Free | 0 € (500 MB BD, 2 GB transferencia/mes) |
| Netlify  | Free | 0 € (100 GB ancho de banda/mes) |
| **Total** | | **0 €/mes** |
