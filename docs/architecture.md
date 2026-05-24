# 🏗️ Arquitectura del Sistema

> Documento vivo — actualizar conforme el prototipo evolucione.

---

## Estado actual: Prototipo Inicial

La arquitectura aún está en fase de definición. Este documento irá creciendo conforme se tomen decisiones técnicas.

---

## 🎯 Objetivos técnicos

- [ ] Detección de señales de ansiedad en texto
- [ ] Generación de respuestas empáticas y orientadoras
- [ ] Protocolo de derivación ante crisis severa
- [ ] Interfaz de usuario (por definir)
- [ ] Almacenamiento seguro (si aplica)

---

## 🧩 Componentes planeados

```
┌─────────────────────────────────────────┐
│              Usuario                    │
└────────────────┬────────────────────────┘
                 │ texto / input
                 ▼
┌─────────────────────────────────────────┐
│         Módulo de entrada               │
│  - Preprocesamiento de texto            │
│  - Detección de idioma                  │
│  - Filtro de contenido sensible         │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│         Módulo de análisis (IA)         │
│  - Clasificación de estado emocional    │
│  - Detección de nivel de crisis         │
│  - Modelo por definir                   │
└────────┬────────────────┬───────────────┘
         │                │
    Crisis normal    Crisis severa
         │                │
         ▼                ▼
┌──────────────┐  ┌─────────────────────┐
│  Respuesta   │  │  Protocolo de        │
│  empática    │  │  emergencia          │
│  + técnicas  │  │  + recursos crisis   │
└──────────────┘  └─────────────────────┘
```

---

## 🤖 Opciones de modelo (por evaluar)

| Opción                  | Ventajas                        | Desventajas                     |
|-------------------------|---------------------------------|---------------------------------|
| LLM via API (GPT/Claude)| Rápido de prototipar            | Costo, dependencia externa      |
| Modelo fine-tuned       | Control total                   | Requiere datos, tiempo          |
| ML clásico + NLP        | Liviano, interpretable          | Menor capacidad de conversación |
| Híbrido                 | Balance                         | Complejidad                     |

---

## 📦 Stack tecnológico (por definir)

| Capa         | Tecnología      | Estado       |
|--------------|-----------------|--------------|
| Lenguaje     | Python          | ✅ Definido   |
| Modelo IA    | Por definir     | 🔴 Pendiente  |
| Backend      | Por definir     | 🔴 Pendiente  |
| Base de datos| Por definir     | 🔴 Pendiente  |
| Frontend     | Por definir     | 🔴 Pendiente  |
| Deploy       | Por definir     | 🔴 Pendiente  |

---

## 📝 Decisiones técnicas tomadas

| Fecha | Decisión | Razón |
|-------|----------|-------|
| —     | —        | —     |

*(Registrar aquí cada decisión importante de arquitectura)*

---

## 🔄 Historial de versiones

| Versión | Descripción              | Fecha |
|---------|--------------------------|-------|
| v0.1    | Prototipo inicial        | —     |
