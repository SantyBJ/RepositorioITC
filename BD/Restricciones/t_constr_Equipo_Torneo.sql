--
-- Resticciones a la Tabla: Equipo_Torneo
--
ALTER TABLE t_Equipo_Torneo ADD CONSTRAINT fk_Equipo FOREIGN KEY (eqtn_equipo) REFERENCES t_equipos(eqpo_eqpo);
ALTER TABLE t_Equipo_Torneo ADD CONSTRAINT fk_Torneo FOREIGN KEY (eqtn_torneo) REFERENCES t_torneo(trno_trno);