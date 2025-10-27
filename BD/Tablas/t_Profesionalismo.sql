--
-- Tabla: Profesionalismo
--
-- DROP TABLE IF EXISTS t_profesionalismo;

CREATE TABLE IF NOT EXISTS t_profesionalismo
(
    prfm_prfm     NUMERIC(4,0) DEFAULT NEXTVAL('s_Profesionalismo')
   ,prfm_dprt     NUMERIC(3,0) CONSTRAINT nn_prfm_dprt   NOT NULL
   ,prfm_descri   VARCHAR(100) CONSTRAINT nn_prfm_descri NOT NULL
   ,prfm_usua     VARCHAR(30)  CONSTRAINT nn_prfm_usua   NOT NULL DEFAULT USER
   ,prfm_feccre   TIMESTAMP    CONSTRAINT nn_prfm_feccre NOT NULL DEFAULT CURRENT_TIMESTAMP
   ,prfm_usua_alt VARCHAR(30)
   ,prfm_fecalt   TIMESTAMP
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS t_profesionalismo
    OWNER to postgres;

COMMENT ON TABLE  t_profesionalismo               IS 'Registro de categorias de Profesionalismo por deporte';
COMMENT ON COLUMN t_profesionalismo.prfm_prfm     IS 'Identificacion del Profesionalismo';
COMMENT ON COLUMN t_profesionalismo.prfm_dprt     IS 'Deporte asociado';
COMMENT ON COLUMN t_profesionalismo.prfm_descri   IS 'Descripcion del Profesionalismo';
COMMENT ON COLUMN t_profesionalismo.prfm_usua     IS 'Usuario Creador del Profesionalismo';
COMMENT ON COLUMN t_profesionalismo.prfm_descri   IS 'Fecha de creacion del Profesionalismo';
COMMENT ON COLUMN t_profesionalismo.prfm_usua_alt IS 'Ultimo Usuario modificador del Profesionalismo';
COMMENT ON COLUMN t_profesionalismo.prfm_fecalt   IS 'Ultima fecha de modificacion del Profesionalismo';