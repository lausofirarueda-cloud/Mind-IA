# ⚖️ Lineamientos Éticos

## Propósito

Este documento define los principios éticos que guían el desarrollo de `anxiety-crisis-ai`.  
Debe consultarse antes de implementar cualquier funcionalidad que involucre usuarios o datos.

---

## 1. Alcance y limitaciones del sistema

### Lo que el sistema PUEDE hacer:
- Detectar patrones lingüísticos asociados a ansiedad
- Ofrecer técnicas de regulación emocional basadas en evidencia (respiración, grounding)
- Proveer información psicoeducativa validada
- Derivar al usuario a recursos profesionales

### Lo que el sistema NUNCA debe hacer:
- Emitir diagnósticos clínicos
- Prescribir o recomendar medicamentos
- Suplantar la relación terapéutica
- Retener a un usuario en crisis sin derivarlo a ayuda de emergencia
- Almacenar conversaciones sin consentimiento explícito

---

## 2. Consentimiento informado

Antes de cualquier interacción, el usuario debe conocer:

```
Este es un sistema de inteligencia artificial experimental.
No soy un terapeuta ni puedo reemplazar la atención profesional.
Si estás en una crisis severa, por favor contacta a:
[Línea de crisis local]

¿Deseas continuar? [Sí / No]
```

---

## 3. Manejo de datos

| Tipo de dato          | ¿Se recopila? | Condición                        |
|-----------------------|---------------|----------------------------------|
| Texto de conversación | Solo local    | Consentimiento explícito         |
| Patrones de uso       | No            | —                                |
| Datos de identificación| No           | —                                |
| Feedback del usuario  | Opcional      | Anonimizado                      |

### Reglas de datos:
- **Minimización:** recopilar solo lo estrictamente necesario
- **Anonimización:** ningún dato debe poder vincularse a una persona real
- **Retención:** definir tiempo máximo de almacenamiento
- **Acceso:** solo el desarrollador autorizado

---

## 4. Gestión de riesgo

### Protocolo ante crisis severa detectada:

```
SI el sistema detecta indicadores de riesgo alto:
  1. Interrumpir el flujo normal de la IA
  2. Mostrar mensaje de crisis con recursos de emergencia
  3. NO continuar la conversación hasta que el usuario confirme seguridad
  4. Registrar el evento (sin datos personales) para revisión
```

### Indicadores de riesgo a detectar:
- Lenguaje de autolesión o ideación suicida
- Expresiones de desesperanza extrema
- Solicitudes de información sobre métodos de daño

---

## 5. Sesgos y equidad

- El modelo debe evaluarse en diversidad de perfiles (edad, género, cultura, idioma)
- Documentar sesgos conocidos en `docs/dataset-info.md`
- No asumir que los patrones entrenados aplican universalmente
- Priorizar inclusión de perspectivas latinoamericanas (contexto del proyecto)

---

## 6. Transparencia del modelo

- Documentar la arquitectura en `docs/architecture.md`
- Registrar versiones y cambios relevantes
- Ser honesto sobre tasas de error conocidas
- No presentar el modelo como más capaz de lo que es

---

## 7. Revisión periódica

Este documento debe revisarse:
- Antes de cada versión mayor del prototipo
- Cuando se cambie la arquitectura del modelo
- Si se incorporan nuevas fuentes de datos
- Cada 3 meses como mínimo

---

*Basado en principios de IA responsable y ética en salud mental digital.*
