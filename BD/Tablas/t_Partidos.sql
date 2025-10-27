--
-- Tabla: Partidos
--
-- DROP TABLE IF EXISTS t_Partidos;

CREATE TABLE IF NOT EXISTS t_Partidos
(
    prtd_trno      NUMERIC(11,0)
   ,prtd_prtd      NUMERIC(3,0)
   ,prtd_local     NUMERIC(5,0) CONSTRAINT nn_prtd_local     NOT NULL
   ,prtd_visitante NUMERIC(5,0) CONSTRAINT nn_prtd_visitante NOT NULL
   ,prtd_fecha     TIMESTAMP    CONSTRAINT nn_prtd_fecha     NOT NULL
   ,prtd_estado    VARCHAR(1)   CONSTRAINT nn_prtd_estado    NOT NULL DEFAULT 'P'
   ,trno_usua      VARCHAR(30)  CONSTRAINT nn_prtd_usua      NOT NULL DEFAULT USER
   ,prtd_feccre    TIMESTAMP    CONSTRAINT nn_prtd_feccre    NOT NULL DEFAULT CURRENT_TIMESTAMP
   ,prtd_usua_alt  VARCHAR(30)
   ,prtd_fecalt    TIMESTAMP
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS t_Partidos
    OWNER to postgres;

COMMENT ON TABLE  t_Partidos                IS 'Registro de los Partidoss';
COMMENT ON COLUMN t_Partidos.prtd_trno      IS 'Torneo donde se celebra el partido';
COMMENT ON COLUMN t_Partidos.prtd_prtd      IS 'Identificador del partido';
COMMENT ON COLUMN t_Partidos.prtd_local     IS 'Equipo local';
COMMENT ON COLUMN t_Partidos.prtd_visitante IS 'Equipo visitante';
COMMENT ON COLUMN t_Partidos.prtd_fecha     IS 'Estado del Partido';
COMMENT ON COLUMN t_Partidos.prtd_estado    IS 'Estado del partido P-Programado, C-en Curso, F-Finalizado';
COMMENT ON COLUMN t_Partidos.trno_usua      IS 'Usuario Creador del Partido';
COMMENT ON COLUMN t_Partidos.prtd_feccre    IS 'Fecha de creacion del Partido';
COMMENT ON COLUMN t_Partidos.prtd_usua_alt  IS 'Ultimo Usuario modificador del Partido';
COMMENT ON COLUMN t_Partidos.prtd_fecalt    IS 'Ultima fecha de modificacion del Partido';