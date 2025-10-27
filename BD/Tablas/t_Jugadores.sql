--
-- Tabla: Jugadores
--
-- DROP TABLE IF EXISTS t_Jugadores;

CREATE TABLE IF NOT EXISTS t_Jugadores
(
    jgdr_jgdr     NUMERIC(15,0)
   ,jgdr_nombres  VARCHAR(100) CONSTRAINT nn_jgdr_nombres   NOT NULL
   ,jgdr_apelidos VARCHAR(100) CONSTRAINT nn_jgdr_apellidos NOT NULL
   ,jgdr_genero   VARCHAR(1)   CONSTRAINT nn_jgdr_genero    NOT NULL
   ,jgdr_prfm     NUMERIC(4,0) CONSTRAINT nn_jgdr_prfm      NOT NULL
   ,jgdr_estado   BOOLEAN      CONSTRAINT nn_jgdr_estado    NOT NULL DEFAULT TRUE
   ,jgdr_usua     VARCHAR(30)  CONSTRAINT nn_jgdr_usua      NOT NULL DEFAULT USER
   ,jgdr_feccre   TIMESTAMP    CONSTRAINT nn_jgdr_feccre    NOT NULL DEFAULT CURRENT_TIMESTAMP
   ,jgdr_usua_alt VARCHAR(30)
   ,jgdr_fecalt   TIMESTAMP
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS t_Jugadores
    OWNER to postgres;

COMMENT ON TABLE  t_Jugadores               IS 'Almacena informacion basica de jugadores';
COMMENT ON COLUMN t_Jugadores.jgdr_jgdr     IS 'Cedula del Jugador';
COMMENT ON COLUMN t_Jugadores.jgdr_nombres  IS 'Nombres del Jugador';
COMMENT ON COLUMN t_Jugadores.jgdr_apelidos IS 'Apellidos del Jugador';
COMMENT ON COLUMN t_Jugadores.jgdr_genero   IS 'Genero del Jugador';
COMMENT ON COLUMN t_Jugadores.jgdr_prfm     IS 'Profesionalismo del jugador';
COMMENT ON COLUMN t_Jugadores.jgdr_estado   IS 'Estado del jugador';
COMMENT ON COLUMN t_Jugadores.jgdr_usua     IS 'Usuario Creador del Jugadores';
COMMENT ON COLUMN t_Jugadores.jgdr_feccre   IS 'Fecha de creacion del Jugadores';
COMMENT ON COLUMN t_Jugadores.jgdr_usua_alt IS 'Ultimo Usuario modificador del Jugadores';
COMMENT ON COLUMN t_Jugadores.jgdr_fecalt   IS 'Ultima fecha de modificacion del Jugadores';