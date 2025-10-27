--
-- Resticciones a la Tabla: Profesionalismo
--
ALTER TABLE t_Profesionalismo ADD CONSTRAINT fk_Profesionalismo_Deportes FOREIGN KEY (prfm_dprt) REFERENCES t_Deportes(dprt_dprt);