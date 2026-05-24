-- ============================================================
--  CALMA INMEDIATA — Esquema de base de datos
--  Base de datos: PostgreSQL 15+
--  Creado para: IA de atención inmediata de crisis de ansiedad
-- ============================================================

-- Extensión para UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- 1. USERS — Pacientes registrados
-- ============================================================
CREATE TABLE users (
    id                  UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name           VARCHAR(150)  NOT NULL,
    email               VARCHAR(255)  NOT NULL UNIQUE,
    phone               VARCHAR(20),
    birth_date          DATE,
    emergency_contact   VARCHAR(150),
    emergency_phone     VARCHAR(20),
    -- Preferencias
    preferred_language  VARCHAR(10)   DEFAULT 'es',
    notification_prefs  JSONB         DEFAULT '{"email": true, "push": true, "sms": false}',
    -- Control
    is_active           BOOLEAN       DEFAULT TRUE,
    created_at          TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    last_active         TIMESTAMPTZ
);

CREATE INDEX idx_users_email ON users (email);


-- ============================================================
-- 2. PSYCHOLOGISTS — Psicólogos disponibles
-- ============================================================
CREATE TABLE psychologists (
    id                  UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name           VARCHAR(150)  NOT NULL,
    email               VARCHAR(255)  NOT NULL UNIQUE,
    phone               VARCHAR(20),
    license_number      VARCHAR(60)   NOT NULL UNIQUE,
    -- Perfil profesional
    specialties         TEXT[]        DEFAULT '{}',
    bio                 TEXT,
    years_experience    SMALLINT,
    -- Disponibilidad y sesión
    is_available        BOOLEAN       DEFAULT FALSE,
    video_call_url      VARCHAR(500),
    max_daily_sessions  SMALLINT      DEFAULT 8,
    -- Métricas
    rating              NUMERIC(3,2)  DEFAULT 0.00 CHECK (rating BETWEEN 0 AND 5),
    total_sessions      INTEGER       DEFAULT 0,
    -- Control
    is_active           BOOLEAN       DEFAULT TRUE,
    created_at          TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_psychologists_available ON psychologists (is_available) WHERE is_active = TRUE;


-- ============================================================
-- 3. SYMPTOMS_REPORTS — Reporte de síntomas del paciente
-- ============================================================
CREATE TABLE symptoms_reports (
    id                  UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id             UUID          NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    -- Síntomas (estructura flexible con JSONB)
    physical_symptoms   JSONB         NOT NULL DEFAULT '[]',
    -- Ej: ["taquicardia", "dificultad_respirar", "mareos", "sudoracion", "temblores", "nauseas"]
    emotional_symptoms  JSONB         NOT NULL DEFAULT '[]',
    -- Ej: ["miedo_intenso", "panico", "sensacion_muerte", "descontrol"]
    intensity_level     SMALLINT      NOT NULL CHECK (intensity_level BETWEEN 1 AND 10),
    duration_minutes    SMALLINT,
    trigger_context     TEXT,         -- Contexto libre: "estaba en el trabajo cuando..."
    -- Clasificación automática por IA
    ai_severity         VARCHAR(20)   CHECK (ai_severity IN ('leve', 'moderada', 'severa', 'critica')),
    reported_at         TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_symptoms_reports_user ON symptoms_reports (user_id);
CREATE INDEX idx_symptoms_reports_date ON symptoms_reports (reported_at DESC);


-- ============================================================
-- 4. AI_CONVERSATIONS — Conversaciones con el asistente IA
-- ============================================================
CREATE TABLE ai_conversations (
    id                      UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                 UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    symptoms_report_id      UUID        REFERENCES symptoms_reports(id) ON DELETE SET NULL,
    -- Mensajes almacenados como array JSON
    messages                JSONB       NOT NULL DEFAULT '[]',
    -- Ej: [{"role": "assistant", "content": "...", "ts": "..."}, {"role": "user", ...}]
    -- Evaluación de la IA
    ai_assessment           TEXT,       -- Resumen de la evaluación clínica generada
    ai_severity_detected    VARCHAR(20) CHECK (ai_severity_detected IN ('leve', 'moderada', 'severa', 'critica')),
    recommended_action      VARCHAR(50) CHECK (recommended_action IN ('tecnicas_calma', 'seguimiento', 'psic_disponible', 'emergencia')),
    escalated_to_human      BOOLEAN     DEFAULT FALSE,
    escalation_reason       TEXT,
    -- Tiempos
    started_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ended_at                TIMESTAMPTZ
);

CREATE INDEX idx_ai_conversations_user ON ai_conversations (user_id);
CREATE INDEX idx_ai_conversations_escalated ON ai_conversations (escalated_to_human) WHERE escalated_to_human = TRUE;


-- ============================================================
-- 5. CRISIS_SESSIONS — Sesiones con psicólogo
-- ============================================================
CREATE TABLE crisis_sessions (
    id                  UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id             UUID          NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    psychologist_id     UUID          NOT NULL REFERENCES psychologists(id),
    ai_conversation_id  UUID          REFERENCES ai_conversations(id) ON DELETE SET NULL,
    symptoms_report_id  UUID          REFERENCES symptoms_reports(id) ON DELETE SET NULL,
    -- Sesión
    status              VARCHAR(20)   NOT NULL DEFAULT 'pendiente'
                            CHECK (status IN ('pendiente', 'en_curso', 'completada', 'cancelada', 'no_presentado')),
    severity_level      VARCHAR(20)   CHECK (severity_level IN ('leve', 'moderada', 'severa', 'critica')),
    -- Tiempos
    scheduled_at        TIMESTAMPTZ,
    started_at          TIMESTAMPTZ,
    ended_at            TIMESTAMPTZ,
    duration_minutes    SMALLINT,
    -- Notas y seguimiento
    psychologist_notes  TEXT,         -- Notas privadas del psicólogo
    diagnosis_tags      TEXT[],       -- Ej: ["crisis_panico", "TAG", "fobia_social"]
    follow_up_required  BOOLEAN       DEFAULT FALSE,
    follow_up_date      DATE,
    -- Calificación del usuario
    user_rating         SMALLINT      CHECK (user_rating BETWEEN 1 AND 5),
    user_feedback       TEXT,
    created_at          TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_crisis_sessions_user ON crisis_sessions (user_id);
CREATE INDEX idx_crisis_sessions_psych ON crisis_sessions (psychologist_id);
CREATE INDEX idx_crisis_sessions_status ON crisis_sessions (status);
CREATE INDEX idx_crisis_sessions_date ON crisis_sessions (created_at DESC);


-- ============================================================
-- 6. MOOD_TRACKING — Seguimiento diario del estado de ánimo
-- ============================================================
CREATE TABLE mood_tracking (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    tracked_date    DATE        NOT NULL DEFAULT CURRENT_DATE,
    anxiety_level   SMALLINT    NOT NULL CHECK (anxiety_level BETWEEN 0 AND 10),
    mood_score      SMALLINT    CHECK (mood_score BETWEEN 0 AND 10),
    sleep_quality   SMALLINT    CHECK (sleep_quality BETWEEN 0 AND 10),
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, tracked_date)  -- Un registro por día por usuario
);

CREATE INDEX idx_mood_tracking_user_date ON mood_tracking (user_id, tracked_date DESC);


-- ============================================================
-- 7. NOTIFICATIONS — Alertas y notificaciones
-- ============================================================
CREATE TABLE notifications (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_id      UUID        REFERENCES crisis_sessions(id) ON DELETE SET NULL,
    type            VARCHAR(40) NOT NULL
                        CHECK (type IN (
                            'crisis_detectada',
                            'psicologo_asignado',
                            'sesion_iniciada',
                            'sesion_completada',
                            'seguimiento_pendiente',
                            'recordatorio_check_in',
                            'nuevo_mensaje'
                        )),
    title           VARCHAR(150),
    message         TEXT        NOT NULL,
    channel         VARCHAR(20) DEFAULT 'push' CHECK (channel IN ('push', 'email', 'sms')),
    is_read         BOOLEAN     DEFAULT FALSE,
    sent_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    read_at         TIMESTAMPTZ
);

CREATE INDEX idx_notifications_user ON notifications (user_id, is_read);
CREATE INDEX idx_notifications_sent ON notifications (sent_at DESC);


-- ============================================================
-- TRIGGER: Actualizar updated_at en psychologists
-- ============================================================
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_psychologists_updated_at
    BEFORE UPDATE ON psychologists
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();


-- ============================================================
-- TRIGGER: Actualizar métricas del psicólogo al cerrar sesión
-- ============================================================
CREATE OR REPLACE FUNCTION update_psychologist_stats()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'completada' AND OLD.status != 'completada' THEN
        UPDATE psychologists
        SET
            total_sessions = total_sessions + 1,
            rating = (
                SELECT ROUND(AVG(user_rating)::NUMERIC, 2)
                FROM crisis_sessions
                WHERE psychologist_id = NEW.psychologist_id
                  AND user_rating IS NOT NULL
            )
        WHERE id = NEW.psychologist_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_psych_stats
    AFTER UPDATE ON crisis_sessions
    FOR EACH ROW EXECUTE FUNCTION update_psychologist_stats();


-- ============================================================
-- DATOS DE EJEMPLO (seed)
-- ============================================================

-- Psicólogos de prueba
INSERT INTO psychologists (full_name, email, license_number, specialties, years_experience, is_available, rating, bio)
VALUES
    ('Dra. María Torres',  'mtorres@calma.app',  'PSI-COL-001234', ARRAY['ansiedad','crisis_panico','TCC'],  8, TRUE,  4.90, 'Especialista en trastornos de ansiedad y terapia cognitivo-conductual.'),
    ('Dr. Carlos Ruiz',    'cruiz@calma.app',    'PSI-COL-005678', ARRAY['trauma','crisis','duelo'],        12, FALSE, 4.80, 'Psicólogo clínico con énfasis en intervención en crisis y trauma.'),
    ('Dra. Lucía Pardo',   'lpardo@calma.app',   'PSI-COL-009012', ARRAY['ansiedad','depresion','mindfulness'], 5, TRUE, 4.75, 'Terapeuta integrativa con enfoque en mindfulness y aceptación.');

-- Usuario de prueba
INSERT INTO users (full_name, email, phone, birth_date, emergency_contact, emergency_phone)
VALUES
    ('Juan Pérez', 'juan@ejemplo.com', '+573001234567', '1995-06-15', 'Ana Pérez (hermana)', '+573007654321');