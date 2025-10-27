--
-- Resticciones a la Tabla: Equipos
--
ALTER TABLE t_Equipos ADD CONSTRAINT uq_Equipos_nombre UNIQUE (eqpo_nombre);