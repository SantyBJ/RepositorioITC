--
-- Resticciones a la Tabla: Registros
--
ALTER TABLE t_Registros ADD CONSTRAINT ch_Registros_estado      CHECK (rgtr_estado IN ('J', 'B', 'L', 'E'));
ALTER TABLE t_Registros ADD CONSTRAINT ch_Registros_goles       CHECK (rgtr_goles > 0);
ALTER TABLE t_Registros ADD CONSTRAINT ch_Registros_asistencias CHECK (rgtr_asistencias > 0);
ALTER TABLE t_Registros ADD CONSTRAINT ch_Registros_faltas      CHECK (ARRAY['L','M','G']::varchar[] && rgtr_Faltas);

ALTER TABLE t_Registros ADD CONSTRAINT fk_Registros_Jugador_Torneo FOREIGN KEY (rgtr_jugador, rgtr_torneo) REFERENCES t_Jugador_Torneo(jgtr_jugador, jgtr_torneo);
ALTER TABLE t_Registros ADD CONSTRAINT fk_Registros_Partido        FOREIGN KEY (rgtr_partido, rgtr_torneo) REFERENCES t_Partidos(prtd_prtd, prtd_trno);