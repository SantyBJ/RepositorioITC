--
-- Tabla: Equipo_Torneo
--
-- DROP TABLE IF EXISTS t_Equipo_Torneo;

CREATE TABLE IF NOT EXISTS t_Equipo_Torneo
(
    eqtn_equipo NUMERIC(5,0)
   ,eqtn_torneo NUMERIC(11,0)
   ,eqtn_estado BOOLEAN       CONSTRAINT nn_eqtn_estado NOT NULL DEFAULT TRUE
)
TABLESPACE pg_default;
--
ALTER TABLE IF EXISTS public.t_Equipo_Torneo
    OWNER to postgres;
--
-- Comentarios de la tabla y de las columnas de cada tabla
--
COMMENT ON TABLE  t_Equipo_Torneo             IS 'Almacena Los torneos que han jugado los equipos';
COMMENT ON COLUMN t_Equipo_Torneo.eqtn_equipo IS 'Identificacion del equipo';
COMMENT ON COLUMN t_Equipo_Torneo.eqtn_torneo IS 'Identificacion del torneo';
COMMENT ON COLUMN t_Equipo_Torneo.eqtn_estado IS 'Estado del equipo en el torneo, TRUE - Juega, FALSE - Eliminado';