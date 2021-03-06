-- Generated by Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   at:        2020-11-27 16:55:46 EET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE acte (
    nr_matricol  NUMBER(4) NOT NULL,
    cod_tip_act  NUMBER(1) NOT NULL,
    data_act     DATE NOT NULL,
    nr_act       VARCHAR2(8) NOT NULL
)
LOGGING;

ALTER TABLE acte
    ADD CONSTRAINT data_depunere_ck CHECK ( EXTRACT(MONTH FROM data_act) = 9
                                            AND EXTRACT(DAY FROM data_act) > 10
                                            AND EXTRACT(DAY FROM data_act) < 20 );

ALTER TABLE acte
    ADD CONSTRAINT nr_act_ck CHECK ( REGEXP_LIKE ( nr_act,
                                                   '^[A-Za-z0-9]+$' ) );
												   
ALTER TABLE acte ADD CONSTRAINT acte_pk PRIMARY KEY ( nr_matricol,
                                                      cod_tip_act );

ALTER TABLE acte ADD CONSTRAINT serie_nr_act_uk UNIQUE ( nr_act );

CREATE TABLE administratori (
    id_administrator       NUMBER(2) NOT NULL,
    nume_administrator     VARCHAR2(30) NOT NULL,
    email_administrator    VARCHAR2(50) NOT NULL,
    telefon_administrator  VARCHAR2(10) NOT NULL
)
LOGGING;

ALTER TABLE administratori
    ADD CONSTRAINT nume_administratori_ck CHECK ( length(nume_administrator) >= 2
                                                  AND REGEXP_LIKE ( nume_administrator,
                                                                    '^[A-Z][A-Za-z ,.-]+$' ) );

ALTER TABLE administratori
    ADD CONSTRAINT email_administrator_ck CHECK ( REGEXP_LIKE ( email_administrator,
                                                                '[a-z0-9._%-]+@[a-z0-9._%-]+\.[a-z]{2,4}' ) );

ALTER TABLE administratori
    ADD CONSTRAINT telefon_administrator_ck CHECK ( REGEXP_LIKE ( telefon_administrator,
                                                                  '^(07)\d{8}$' ) );

ALTER TABLE administratori ADD CONSTRAINT administratori_pk PRIMARY KEY ( id_administrator );

ALTER TABLE administratori ADD CONSTRAINT telefon_administrator_uk UNIQUE ( telefon_administrator );

ALTER TABLE administratori ADD CONSTRAINT email_administrator_uk UNIQUE ( email_administrator );

CREATE TABLE camere (
    id_camera    NUMBER(4) NOT NULL,
    nr_camera    NUMBER(3) NOT NULL,
    nr_locuri    NUMBER(1) NOT NULL,
    pret_cazare  NUMBER(3) NOT NULL,
    baie         CHAR(3) NOT NULL,
    cod_camin    VARCHAR2(3) NOT NULL
)
LOGGING;

ALTER TABLE camere ADD CONSTRAINT id_camera_ck CHECK ( id_camera > 0 );

ALTER TABLE camere ADD CONSTRAINT nr_camera_ck CHECK ( nr_camera > 0 );

ALTER TABLE camere
    ADD CONSTRAINT nr_locuri_ck CHECK ( nr_locuri BETWEEN 1 AND 4 );

ALTER TABLE camere
    ADD CONSTRAINT pret_cazare_ck CHECK ( pret_cazare > 100
                                          AND pret_cazare < 500 );

ALTER TABLE camere
    ADD CONSTRAINT camere_baie_ck CHECK ( baie IN ( 'C2C', 'C2P', 'I' ) );

ALTER TABLE camere ADD CONSTRAINT camere_pk PRIMARY KEY ( id_camera );

ALTER TABLE camere ADD CONSTRAINT camera_camin_uk UNIQUE ( nr_camera,
                                                           cod_camin );

CREATE TABLE camine (
    cod_camin         VARCHAR2(3) NOT NULL,
    adresa_camin      VARCHAR2(100) NOT NULL,
    nr_camere         NUMBER(3) NOT NULL,
    id_administrator  NUMBER(2)
)
LOGGING;

ALTER TABLE camine
    ADD CONSTRAINT cod_camin_ck CHECK ( REGEXP_LIKE ( cod_camin,
                                                      '^T[0-9]+$' ) );

ALTER TABLE camine
    ADD CONSTRAINT adresa_camin_ck CHECK ( length(adresa_camin) >= 2
                                           AND REGEXP_LIKE ( adresa_camin,
                                                             '^[a-zA-Z., 0-9-]+$' ) );

ALTER TABLE camine ADD CONSTRAINT nr_camere_ck CHECK ( nr_camere > 0 );

ALTER TABLE camine ADD CONSTRAINT camine_pk PRIMARY KEY ( cod_camin );

CREATE TABLE facultati (
    cod_facultate  VARCHAR2(4) NOT NULL,
    denumire       VARCHAR2(80) NOT NULL,
    adresa         VARCHAR2(100) NOT NULL
)
LOGGING;

ALTER TABLE facultati
    ADD CONSTRAINT cod_facultate_ck CHECK ( length(cod_facultate) > 1
                                            AND REGEXP_LIKE ( cod_facultate,
                                                              '^[A-Z]+$' ) );

ALTER TABLE facultati
    ADD CONSTRAINT denumire_ck CHECK ( length(denumire) >= 2
                                       AND REGEXP_LIKE ( denumire,
                                                         '^[A-Z][a-z]*[ A-Za-z,.-\\"]*$' ) );

ALTER TABLE facultati
    ADD CONSTRAINT adresa_ck CHECK ( length(adresa) >= 2
                                     AND REGEXP_LIKE ( adresa,
                                                       '^[a-zA-Z., 0-9-]+$' ) );

ALTER TABLE facultati ADD CONSTRAINT facultati_pk PRIMARY KEY ( cod_facultate );

CREATE TABLE optiuni (
    nr_matricol  NUMBER(4) NOT NULL,
    cod_camin    VARCHAR2(3) NOT NULL,
    id_camera    NUMBER(4),
    coleg1       NUMBER(4),
    coleg2       NUMBER(4),
    coleg3       NUMBER(4)
)
LOGGING;

ALTER TABLE optiuni ADD CONSTRAINT optiuni_pk PRIMARY KEY ( nr_matricol );

CREATE TABLE punctaje (
    nr_matricol    NUMBER(4) NOT NULL,
    punctaj_total  NUMBER(5, 2),
    bonus          NUMBER(3, 1) NOT NULL,
    medie_student  NUMBER(4, 2) NOT NULL,
    numar_credite  NUMBER(3) NOT NULL,
    an_studiu      NUMBER(1) NOT NULL
)
LOGGING;

ALTER TABLE punctaje ADD CONSTRAINT punctaj_total_ck CHECK ( punctaj_total >= 0 AND punctaj_total <= 110 );

ALTER TABLE punctaje
    ADD CONSTRAINT bonus_ck CHECK ( bonus BETWEEN 0 AND 10 );

ALTER TABLE punctaje ADD CONSTRAINT medie_student_ck CHECK ( medie_student >= 0 AND  medie_student <= 10);

ALTER TABLE punctaje
    ADD CONSTRAINT numar_credite_ck CHECK ( numar_credite >= 0
                                            AND numar_credite <= 180 );

ALTER TABLE punctaje
    ADD CONSTRAINT an_studiu_ck CHECK ( an_studiu BETWEEN 1 AND 4 );

ALTER TABLE punctaje ADD CONSTRAINT punctaje_pk PRIMARY KEY ( nr_matricol );

CREATE TABLE studenti (
    nr_matricol      NUMBER(4) NOT NULL,
    nume_student     VARCHAR2(40) NOT NULL,
    domiciliu        VARCHAR2(80) NOT NULL,
    localitate       VARCHAR2(30) NOT NULL,
    judet            VARCHAR2(2) NOT NULL,
    email_student    VARCHAR2(50),
    telefon_student  VARCHAR2(10) NOT NULL,
    cod_facultate    VARCHAR2(4) NOT NULL
)
LOGGING;

ALTER TABLE studenti ADD CONSTRAINT nr_matricol_ck CHECK ( nr_matricol >= 4000 );

ALTER TABLE studenti
    ADD CONSTRAINT studenti_nume_ck CHECK ( length(nume_student) >= 2
                                            AND REGEXP_LIKE ( nume_student,
                                                              '^[A-Z][A-Za-z ,.-]+$' ) );

ALTER TABLE studenti
    ADD CONSTRAINT domiciliu_ck CHECK ( length(domiciliu) >= 2
                                        AND REGEXP_LIKE ( domiciliu,
                                                          '^[a-zA-Z., 0-9-]+$' ) );

ALTER TABLE studenti
    ADD CONSTRAINT localitate_ck CHECK ( length(localitate) >= 2
                                         AND REGEXP_LIKE ( localitate,
                                                           '^[A-Z][-A-Za-z-]+$' ) );

ALTER TABLE studenti
    ADD CONSTRAINT judet_ck CHECK ( REGEXP_LIKE ( judet,
                                                  '^[A-Z]+$' ) );

ALTER TABLE studenti
    ADD CONSTRAINT email_student_ck CHECK ( REGEXP_LIKE ( email_student,
                                                          '[a-z0-9._%-]+@[a-z0-9._%-]+\.[a-z]{2,4}' ) );

ALTER TABLE studenti
    ADD CONSTRAINT telefon_student_ck CHECK ( REGEXP_LIKE ( telefon_student,
                                                            '^(07)\d{8}$' ) );

ALTER TABLE studenti ADD CONSTRAINT studenti_pk PRIMARY KEY ( nr_matricol );

ALTER TABLE studenti ADD CONSTRAINT telefon_student_uk UNIQUE ( telefon_student );

ALTER TABLE studenti ADD CONSTRAINT email_student_uk UNIQUE ( email_student );

CREATE TABLE tipuri_acte (
    cod_tip_act       NUMBER(1) NOT NULL,
    denumire_tip_act  VARCHAR2(40) NOT NULL
)
LOGGING;

ALTER TABLE tipuri_acte ADD CONSTRAINT cod_tip_act_ck CHECK ( cod_tip_act >= 0 );

ALTER TABLE tipuri_acte
    ADD CONSTRAINT denumire_tip_act_ck CHECK ( length(denumire_tip_act) >= 3
                                               AND REGEXP_LIKE ( denumire_tip_act,
                                                                 '^[a-zA-Z., 0-9-]+$' ) );

ALTER TABLE tipuri_acte ADD CONSTRAINT tipuri_acte_pk PRIMARY KEY ( cod_tip_act );

ALTER TABLE tipuri_acte ADD CONSTRAINT denumire_tip_act_uk UNIQUE ( denumire_tip_act );

ALTER TABLE acte
    ADD CONSTRAINT acte_studenti_fk FOREIGN KEY ( nr_matricol )
        REFERENCES studenti ( nr_matricol )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE acte
    ADD CONSTRAINT acte_tipuri_acte_fk FOREIGN KEY ( cod_tip_act )
        REFERENCES tipuri_acte ( cod_tip_act )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE camine
    ADD CONSTRAINT administratori_camine_fk FOREIGN KEY ( id_administrator )
        REFERENCES administratori ( id_administrator )
            ON DELETE SET NULL
    NOT DEFERRABLE;

ALTER TABLE optiuni
    ADD CONSTRAINT camere_optiuni_fk FOREIGN KEY ( id_camera )
        REFERENCES camere ( id_camera )
		ON DELETE SET NULL
    NOT DEFERRABLE;

ALTER TABLE camere
    ADD CONSTRAINT camine_camere_fk FOREIGN KEY ( cod_camin )
        REFERENCES camine ( cod_camin )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE optiuni
    ADD CONSTRAINT camine_optiuni_fk FOREIGN KEY ( cod_camin )
        REFERENCES camine ( cod_camin )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE studenti
    ADD CONSTRAINT facultati_studenti_fk FOREIGN KEY ( cod_facultate )
        REFERENCES facultati ( cod_facultate )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE optiuni
    ADD CONSTRAINT s_o1 FOREIGN KEY ( coleg1 )
        REFERENCES studenti ( nr_matricol )
            ON DELETE SET NULL
    NOT DEFERRABLE;

ALTER TABLE optiuni
    ADD CONSTRAINT s_o2 FOREIGN KEY ( coleg2 )
        REFERENCES studenti ( nr_matricol )
            ON DELETE SET NULL
    NOT DEFERRABLE;

ALTER TABLE optiuni
    ADD CONSTRAINT s_o3 FOREIGN KEY ( coleg3 )
        REFERENCES studenti ( nr_matricol )
            ON DELETE SET NULL
    NOT DEFERRABLE;

ALTER TABLE optiuni
    ADD CONSTRAINT studenti_optiuni FOREIGN KEY ( nr_matricol )
        REFERENCES studenti ( nr_matricol )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE punctaje
    ADD CONSTRAINT studenti_punctaje_fk FOREIGN KEY ( nr_matricol )
        REFERENCES studenti ( nr_matricol )
            ON DELETE CASCADE
    NOT DEFERRABLE;

CREATE OR REPLACE TRIGGER trg_data_act 
    BEFORE INSERT OR UPDATE ON Acte 
    FOR EACH ROW 
BEGIN
IF( :new.data_act > SYSDATE)
THEN
RAISE_APPLICATION_ERROR( -20001,
'Data depunere acte invalida.' );
END IF;
END; 
/

CREATE SEQUENCE administratori_id_administrato START WITH 1 MINVALUE 1 MAXVALUE 99 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER administratori_id_administrato BEFORE
    INSERT ON administratori
    FOR EACH ROW
    WHEN ( new.id_administrator IS NULL )
BEGIN
    :new.id_administrator := administratori_id_administrato.nextval;
END;
/

CREATE SEQUENCE camere_id_camera_seq START WITH 1 MINVALUE 1 MAXVALUE 9999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER camere_id_camera_trg BEFORE
    INSERT ON camere
    FOR EACH ROW
    WHEN ( new.id_camera IS NULL )
BEGIN
    :new.id_camera := camere_id_camera_seq.nextval;
END;
/

CREATE SEQUENCE studenti_nr_matricol_seq START WITH 4000 MINVALUE 1 MAXVALUE 9999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER studenti_nr_matricol_trg BEFORE
    INSERT ON studenti
    FOR EACH ROW
    WHEN ( new.nr_matricol IS NULL )
BEGIN
    :new.nr_matricol := studenti_nr_matricol_seq.nextval;
END;
/

CREATE SEQUENCE tipuri_acte_cod_tip_act_seq START WITH 1 MINVALUE 1 MAXVALUE 9 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tipuri_acte_cod_tip_act_trg BEFORE
    INSERT ON tipuri_acte
    FOR EACH ROW
    WHEN ( new.cod_tip_act IS NULL )
BEGIN
    :new.cod_tip_act := tipuri_acte_cod_tip_act_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             57
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          4
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
