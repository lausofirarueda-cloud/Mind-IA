# 📊 Información de Datasets

> Este documento debe actualizarse cada vez que se agregue, modifique o elimine una fuente de datos.

---

## ⚠️ Principios de uso de datos

1. **Solo datos anonimizados** — nunca datos reales de personas identificables
2. **Consentimiento claro** — si se recopilan datos propios, documentar el proceso de consentimiento
3. **Propósito específico** — cada dataset tiene un uso declarado y no se usa para otra cosa
4. **Minimización** — usar el mínimo de datos necesarios

---

## 📁 Datasets actuales

*(Vacío — agregar cuando se incorporen datos)*

### Plantilla para registrar un dataset:

```
### [Nombre del dataset]
- **Fuente:** 
- **Tipo de datos:** 
- **Tamaño:** 
- **Idioma:** 
- **Licencia:** 
- **Uso en el proyecto:** 
- **Sesgos conocidos:** 
- **Fecha de incorporación:** 
- **Ubicación en repo:** 
```

---

## 🔍 Fuentes de datos a explorar

| Fuente                          | Tipo              | Estado      |
|---------------------------------|-------------------|-------------|
| Reddit r/anxiety (API pública)  | Texto             | 🟡 Por evaluar|
| Datasets de NLP en salud mental | Texto clasificado | 🟡 Por evaluar|
| Datos sintéticos generados      | Texto             | 🟡 Por evaluar|
| Encuestas propias (con consentimiento) | Texto      | 🔴 Futuro    |

---

## 🧪 Datos sintéticos

Para el prototipo inicial se recomienda usar **datos sintéticos** generados manualmente o con IA, que representen:

- Ejemplos de lenguaje en estado de ansiedad leve
- Ejemplos de lenguaje en estado de ansiedad moderada  
- Ejemplos de lenguaje en crisis severa
- Ejemplos de lenguaje en estado neutro (control)

Estos datos NO deben usarse en producción.

---

## 📋 Checklist antes de usar cualquier dataset

- [ ] ¿Tiene licencia que permite uso en investigación?
- [ ] ¿Los datos están anonimizados?
- [ ] ¿Se conocen los sesgos principales?
- [ ] ¿Está documentado en este archivo?
- [ ] ¿Está excluido del repositorio (en `.gitignore`) si contiene info sensible?
