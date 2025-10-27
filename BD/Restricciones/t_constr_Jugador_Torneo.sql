--
-- Resticciones a la Tabla: Jugador_Torneo
--
ALTER TABLE t_Jugador_Torneo ADD CONSTRAINT fk_Jugador FOREIGN KEY (jgtr_jugador) REFERENCES t_jugadores(jgdr_jgdr);
ALTER TABLE t_Jugador_Torneo ADD CONSTRAINT fk_Torneo  FOREIGN KEY (jgtr_torneo)  REFERENCES t_torneo(trno_trno);
ALTER TABLE t_Jugador_Torneo ADD CONSTRAINT fk_Equipo  FOREIGN KEY (jgtr_equipo)  REFERENCES t_equipos(eqpo_eqpo);