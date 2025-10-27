--
-- Tabla: Equipos
--
-- DROP TABLE IF EXISTS t_Equipos;

CREATE TABLE IF NOT EXISTS t_Equipos
(
    eqpo_eqpo     NUMERIC(5,0) DEFAULT NEXTVAL('s_Equipos')
   ,eqpo_nombre   VARCHAR(100) CONSTRAINT nn_eqpo_descri NOT NULL
   ,eqpo_estado   BOOLEAN      CONSTRAINT nn_eqpo_cambio NOT NULL DEFAULT TRUE
   ,eqpo_usua     VARCHAR(30)  CONSTRAINT nn_eqpo_usua   NOT NULL DEFAULT USER
   ,eqpo_feccre   TIMESTAMP    CONSTRAINT nn_eqpo_feccre NOT NULL DEFAULT CURRENT_TIMESTAMP
   ,eqpo_usua_alt VARCHAR(30)
   ,eqpo_fecalt   TIMESTAMP
)
TABLESPACE pg_default;
--
ALTER TABLE IF EXISTS t_Equipos
    OWNER to postgres;
--
-- Comentarios de la tabla y de las columnas de cada tabla
--
COMMENT ON TABLE  t_Equipos               IS 'Informacion acerca de los equipos';
COMMENT ON COLUMN t_Equipos.eqpo_eqpo     IS 'Identificador de Equipo';
COMMENT ON COLUMN t_Equipos.eqpo_nombre   IS 'Nombre del Equipo';
COMMENT ON COLUMN t_Equipos.eqpo_estado   IS 'Estado del equipo';
COMMENT ON COLUMN t_Equipos.eqpo_usua     IS 'Usuario Creador del Profesionalismo';
COMMENT ON COLUMN t_Equipos.eqpo_feccre   IS 'Fecha de creacion del Profesionalismo';
COMMENT ON COLUMN t_Equipos.eqpo_usua_alt IS 'Ultimo Usuario modificador del Profesionalismo';
COMMENT ON COLUMN t_Equipos.eqpo_fecalt   IS 'Ultima fecha de modificacion del Profesionalismo';