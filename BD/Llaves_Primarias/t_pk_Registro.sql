--
-- Llave Primaria a la Tabla: Registros
--
ALTER TABLE t_Registros ADD CONSTRAINT pk_Registros PRIMARY KEY (rgtr_torneo, rgtr_partido, rgtr_jugador)