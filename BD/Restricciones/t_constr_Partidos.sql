--
-- Resticciones a la Tabla: Partidos
--
ALTER TABLE t_Partidos ADD CONSTRAINT ch_Partidos_estado  CHECK (prtd_estado IN ('P', 'C', 'F'));
ALTER TABLE t_Partidos ADD CONSTRAINT ch_Partidos_equipos CHECK (prtd_local <> prtd_visitante);

ALTER TABLE t_Partidos ADD CONSTRAINT fk_Partidos_Equipo_Local     FOREIGN KEY (prtd_trno, prtd_local)     REFERENCES t_Equipo_Torneo(eqtn_torneo, eqtn_equipo);
ALTER TABLE t_Partidos ADD CONSTRAINT fk_Partidos_Equipo_Visitante FOREIGN KEY (prtd_trno, prtd_visitante) REFERENCES t_Equipo_Torneo(eqtn_torneo, eqtn_equipo);