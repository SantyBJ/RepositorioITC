--
-- Tabla: Deportes
--
-- DROP TABLE IF EXISTS t_Deportes;

CREATE TABLE IF NOT EXISTS t_Deportes
(
    dprt_dprt   NUMERIC(3,0) DEFAULT NEXTVAL('s_Deportes')
   ,dprt_descri VARCHAR(100) CONSTRAINT nn_dprt_descri NOT NULL
)
TABLESPACE pg_default;
--
ALTER TABLE IF EXISTS public.t_Deportes
    OWNER to postgres;
--
-- Comentarios de la tabla y de las columnas de cada tabla
--
COMMENT ON TABLE  t_Deportes             IS 'Informacion de deportes';
COMMENT ON COLUMN t_Deportes.dprt_dprt   IS 'Identificacion del deporte';
COMMENT ON COLUMN t_Deportes.dprt_descri IS 'Descripcion del deporte';