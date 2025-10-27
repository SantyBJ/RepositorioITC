--
-- Resticciones a la Tabla: Jugadores
--
ALTER TABLE t_Jugadores ADD CONSTRAINT ch_Jugadores_genero CHECK (jgdr_genero IN ('F', 'M'));

ALTER TABLE t_Jugadores ADD CONSTRAINT fk_Jugadores_Profesionalismo FOREIGN KEY (jgdr_prfm) REFERENCES t_Profesionalismo(prfm_prfm);