--
-- Tabla: Registros
--
-- DROP TABLE IF EXISTS t_Registros;

CREATE TABLE IF NOT EXISTS t_Registros
(
    rgtr_torneo      NUMERIC(11,0)
   ,rgtr_partido     NUMERIC(3,0)
   ,rgtr_jugador     NUMERIC(15,0)
   ,rgtr_fecreg      TIMESTAMP     CONSTRAINT nn_rgtr_trno_fecini NOT NULL DEFAULT CURRENT_TIMESTAMP
   ,rgtr_estado      VARCHAR(1)    CONSTRAINT nn_rgtr_trno_estado NOT NULL DEFAULT 'J'
   ,rgtr_goles       NUMERIC(3,0)
   ,rgtr_asistencias NUMERIC(3,0)
   ,rgtr_Faltas      VARCHAR(1) []
   ,rgtr_usua        VARCHAR(30)   CONSTRAINT nn_rgtr_usua        NOT NULL DEFAULT USER
   ,rgtr_usua_alt    VARCHAR(30)
   ,rgtr_fecalt      TIMESTAMP
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS t_Registros
    OWNER to postgres;

COMMENT ON TABLE  t_Registros                  IS 'Registros de jugador por partido en un torneo';
COMMENT ON COLUMN t_Registros.rgtr_torneo      IS 'Torneo asociado';
COMMENT ON COLUMN t_Registros.rgtr_partido     IS 'Partido donde se realiza el registro';
COMMENT ON COLUMN t_Registros.rgtr_jugador     IS 'Jugador registrado';
COMMENT ON COLUMN t_Registros.rgtr_fecreg      IS 'Fecha del Registros';
COMMENT ON COLUMN t_Registros.rgtr_estado      IS 'Estado del jugador en el partido J-Jugando, B-Banca, L-Lesionado, E-Expulsado';
COMMENT ON COLUMN t_Registros.rgtr_goles       IS 'Goles hechos por el jugador';
COMMENT ON COLUMN t_Registros.rgtr_asistencias IS 'Asistencias Hechas por el jugador';
COMMENT ON COLUMN t_Registros.rgtr_Faltas      IS 'Faltas hechas por el Jugador, donde L-Leve, M-Media, G-Grave';
COMMENT ON COLUMN t_Registros.rgtr_usua        IS 'Ususario de creacion del Registro';
COMMENT ON COLUMN t_Registros.rgtr_usua_alt    IS 'Ultimo Usuario modificador del Registro';
COMMENT ON COLUMN t_Registros.rgtr_fecalt      IS 'Ultima fecha de modificacion del Registro';