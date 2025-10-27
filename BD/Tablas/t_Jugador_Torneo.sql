--
-- Tabla: Jugador_Torneo
--
-- DROP TABLE IF EXISTS t_Jugador_Torneo;

CREATE TABLE IF NOT EXISTS t_Jugador_Torneo
(
    jgtr_jugador      NUMERIC(15,0)
   ,jgtr_torneo       NUMERIC(11,0)
   ,jgtr_equipo       NUMERIC(5,0)  CONSTRAINT nn_jgtr_equipo       NOT NULL
   ,jgtr_nro_camiseta NUMERIC(2,0)  CONSTRAINT nn_jgtr_nro_camiseta NOT NULL
   ,jgtr_usua         VARCHAR(30)   CONSTRAINT nn_jgtr_usua         NOT NULL DEFAULT USER
   ,jgtr_feccre       TIMESTAMP     CONSTRAINT nn_jgtr_feccre       NOT NULL DEFAULT CURRENT_TIMESTAMP
   ,jgtr_usua_alt     VARCHAR(30)
   ,jgtr_fecalt       TIMESTAMP
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS t_Jugador_Torneo
    OWNER to postgres;

COMMENT ON TABLE  t_Jugador_Torneo                   IS 'Asocia los jugadores con los torneos, ya que un jugador puede estar en mas de un torneo';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_jugador      IS 'Jugador en el torneo';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_torneo       IS 'Torneo asociado';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_equipo       IS 'Equipo donde esta asociad el jugador';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_nro_camiseta IS 'Numero de camiseta con el que juega';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_posicion     IS 'Posicion donde juega';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_usua         IS 'Usuario Creador del registro';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_feccre       IS 'Fecha de creacion del registro';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_usua_alt     IS 'Ultimo Usuario modificador del registro';
COMMENT ON COLUMN t_Jugador_Torneo.jgtr_fecalt       IS 'Ultima fecha de modificacion del registro';