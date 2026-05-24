# 🤝 Guía de Contribución

Gracias por tu interés en este proyecto. Aunque actualmente es un desarrollo **personal**, esta guía documenta cómo trabajar de forma ordenada y segura en el repositorio.

---

## 🌿 Estrategia de ramas

```
main          → Versión estable (nunca se toca directamente)
develop       → Integración de cambios
feature/xxx   → Nuevas funcionalidades
experiment/xx → Pruebas e investigación
docs/xxx      → Solo documentación
```

### Regla principal
> ❌ **Nunca hagas commits directamente en `main` o `develop`.**  
> ✅ Siempre trabaja en una rama separada y luego haz un Pull Request.

---

## 🔄 Flujo de trabajo

### 1. Crear una rama nueva

```bash
# Siempre desde develop actualizado
git checkout develop
git pull origin develop
git checkout -b feature/nombre-descriptivo
```

### 2. Trabajar en tus cambios

```bash
# Ver qué archivos cambiaste
git status

# Agregar cambios
git add nombre-del-archivo.py
# o todos:
git add .

# Hacer commit con mensaje claro
git commit -m "feat: agrega detección de patrones de texto"
```

### 3. Subir la rama y crear Pull Request

```bash
git push origin feature/nombre-descriptivo
```

Luego en GitHub: **"Compare & pull request"** → hacia `develop`.

---

## 📝 Formato de commits

Usa este formato para mensajes de commit:

| Prefijo    | Uso                                      |
|------------|------------------------------------------|
| `feat:`    | Nueva funcionalidad                      |
| `fix:`     | Corrección de errores                    |
| `docs:`    | Cambios en documentación                 |
| `test:`    | Agregar o modificar pruebas              |
| `refactor:`| Mejora de código sin cambiar funcionalidad|
| `experiment:` | Prueba exploratoria                   |
| `chore:`   | Tareas de mantenimiento                  |

**Ejemplos:**
```
feat: agrega módulo de análisis de sentimiento
fix: corrige error en carga de modelo
docs: actualiza arquitectura en docs/
experiment: prueba integración con API externa
```

---

## 🚫 Qué NO subir al repositorio

- ❌ Archivos `.env` con credenciales reales
- ❌ Datos de usuarios o datasets sensibles
- ❌ Modelos entrenados de gran tamaño (usar Git LFS o almacenamiento externo)
- ❌ Claves API, tokens o contraseñas
- ❌ Archivos temporales o de caché (`__pycache__`, `.DS_Store`, etc.)

---

## 🏷️ Uso de Issues

Para registrar ideas, errores o tareas usa **GitHub Issues** con las plantillas disponibles.

**Labels disponibles:**
- `idea` — Nueva idea a explorar
- `bug` — Algo no funciona
- `research` — Requiere investigación
- `ethics` — Consideración ética importante
- `blocked` — No se puede avanzar por dependencia

---

## 🔐 Datos sensibles

Este proyecto trabaja con un tema de salud mental. Por ello:

1. **Nunca** incluyas datos reales de personas en el código o commits
2. Usa siempre datos sintéticos o anonimizados para pruebas
3. Cualquier dataset debe documentarse en `docs/dataset-info.md`
4. Consulta `docs/ethics-guidelines.md` antes de implementar funcionalidades de recopilación de datos
