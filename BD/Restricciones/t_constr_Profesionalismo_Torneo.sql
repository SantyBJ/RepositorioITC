--
-- Resticciones a la Tabla: Profesionalismo_Torneo
--
ALTER TABLE t_Profesionalismo_Torneo ADD CONSTRAINT fk_Profesionalismo FOREIGN KEY (prtn_profesionalismo) REFERENCES t_profesionalismo(prfm_prfm);
ALTER TABLE t_Profesionalismo_Torneo ADD CONSTRAINT fk_Torneo          FOREIGN KEY (prtn_torneo)          REFERENCES t_torneo(trno_trno);