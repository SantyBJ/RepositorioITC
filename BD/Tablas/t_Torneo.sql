--
-- Tabla: Torneo
--
-- DROP TABLE IF EXISTS t_Torneo;

CREATE TABLE IF NOT EXISTS t_Torneo
(
    trno_trno          NUMERIC(11,0) DEFAULT NEXTVAL('s_Torneo')
   ,trno_nombre        VARCHAR(100)  CONSTRAINT nn_trno_nombre        NOT NULL
   ,trno_min_equipos   NUMERIC(2,0)  CONSTRAINT nn_trno_min_equipos   NOT NULL
   ,trno_max_equipos   NUMERIC(2,0)  CONSTRAINT nn_trno_max_equipos   NOT NULL
   ,trno_min_jugadores NUMERIC(2,0)  CONSTRAINT nn_trno_min_jugadores NOT NULL
   ,trno_max_jugadores NUMERIC(2,0)  CONSTRAINT nn_trno_max_jugadores NOT NULL
   ,trno_genero        VARCHAR(1)
   ,trno_fecini        TIMESTAMP     CONSTRAINT nn_trno_trno_fecini   NOT NULL
   ,trno_fecfin        TIMESTAMP     CONSTRAINT nn_trno_trno_fecfin   NOT NULL
   ,trno_estado        BOOLEAN       CONSTRAINT nn_trno_trno_estado   NOT NULL DEFAULT TRUE
   ,trno_dprt          NUMERIC(3,0)  CONSTRAINT nn_trno_trno_dprt     NOT NULL
   ,trno_usua          VARCHAR(30)   CONSTRAINT nn_trno_usua          NOT NULL DEFAULT USER
   ,trno_feccre        TIMESTAMP     CONSTRAINT nn_trno_feccre        NOT NULL DEFAULT CURRENT_TIMESTAMP
   ,trno_usua_alt      VARCHAR(30)
   ,trno_fecalt        TIMESTAMP
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS t_Torneo
    OWNER to postgres;

COMMENT ON TABLE  t_Torneo                    IS 'Registro de los Torneos';
COMMENT ON COLUMN t_Torneo.trno_trno          IS 'Identificacion de los torneos';
COMMENT ON COLUMN t_Torneo.trno_nombre        IS 'Nombre del torneo';
COMMENT ON COLUMN t_Torneo.trno_min_equipos   IS 'Numero minimo de equipos en el torneo';
COMMENT ON COLUMN t_Torneo.trno_max_equipos   IS 'Numero maximo de equipos en el torneo';
COMMENT ON COLUMN t_Torneo.trno_min_jugadores IS 'Numero minimo de jugadores por equipo en el torneo';
COMMENT ON COLUMN t_Torneo.trno_max_jugadores IS 'Numero maximo de jugadores por equipos en el torneo';
COMMENT ON COLUMN t_Torneo.trno_genero        IS 'Genero del torneo, si es NULL, significa mixto';
COMMENT ON COLUMN t_Torneo.trno_fecini        IS 'Fecha de inicio del torneo';
COMMENT ON COLUMN t_Torneo.trno_fecfin        IS 'Fecha de fin del torneo';
COMMENT ON COLUMN t_Torneo.trno_estado        IS 'Estado del torneo';
COMMENT ON COLUMN t_Torneo.trno_dprt          IS 'Deporte asociado';
COMMENT ON COLUMN t_Torneo.trno_usua          IS 'Usuario Creador del torneo';
COMMENT ON COLUMN t_Torneo.trno_feccre        IS 'Fecha de creacion del torneo';
COMMENT ON COLUMN t_Torneo.trno_usua_alt      IS 'Ultimo Usuario modificador del torneo';
COMMENT ON COLUMN t_Torneo.trno_fecalt        IS 'Ultima fecha de modificacion del torneo';