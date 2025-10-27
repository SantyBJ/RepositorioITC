--
-- Tabla: Profesionalismo_Torneo
--
-- DROP TABLE IF EXISTS t_Profesionalismo_Torneo;

CREATE TABLE IF NOT EXISTS t_Profesionalismo_Torneo
(
    prtn_profesionalismo NUMERIC(4,0)
   ,prtn_torneo          NUMERIC(11,0)
)
TABLESPACE pg_default;
--
ALTER TABLE IF EXISTS public.t_Profesionalismo_Torneo
    OWNER to postgres;
--
-- Comentarios de la tabla y de las columnas de cada tabla
--
COMMENT ON TABLE  t_Profesionalismo_Torneo                      IS 'Se indica cuales niveles de profesionalismo se admiten por torneo';
COMMENT ON COLUMN t_Profesionalismo_Torneo.prtn_profesionalismo IS 'Identificacion del profesionalismo';
COMMENT ON COLUMN t_Profesionalismo_Torneo.prtn_torneo          IS 'Identificacion del torneo';