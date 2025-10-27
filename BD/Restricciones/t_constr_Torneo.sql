--
-- Resticciones a la Tabla: Torneo
--
ALTER TABLE t_Torneo ADD CONSTRAINT ch_torneo_min_jugadores CHECK (trno_min_jugadores > 0);
ALTER TABLE t_Torneo ADD CONSTRAINT ch_torneo_max_jugadores CHECK (trno_max_jugadores >= trno_min_jugadores);
ALTER TABLE t_Torneo ADD CONSTRAINT ch_torneo_min_equipos   CHECK (trno_min_equipos > 0);
ALTER TABLE t_Torneo ADD CONSTRAINT ch_torneo_max_equipos   CHECK (trno_max_equipos >= trno_min_equipos);
ALTER TABLE t_Torneo ADD CONSTRAINT ch_torneo_genero        CHECK (trno_genero IN ('F', 'M'));
ALTER TABLE t_Torneo ADD CONSTRAINT ch_torneo_fechas        CHECK (trno_fecini < trno_fecfin);

ALTER TABLE t_Torneo ADD CONSTRAINT fk_Torneo_Deporte FOREIGN KEY (trno_dprt) REFERENCES t_Deportes(dprt_dprt);