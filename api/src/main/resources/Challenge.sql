-- RM94526 - CAIO GALLO BARREIRA
-- RM89384 - GUILHERME MENEZES DA SILVA
-- RM94771 - GUILHERME OLIVEIRA ROCHA
-- RM92119 - JO?O VICTOR DE SOUZA SILVA

-- COMANDOS DDL

DROP TABLE t_std_alternativa CASCADE CONSTRAINTS;

DROP TABLE t_std_aula CASCADE CONSTRAINTS;

DROP TABLE t_std_cronograma CASCADE CONSTRAINTS;

DROP TABLE t_std_exercicio CASCADE CONSTRAINTS;

DROP TABLE t_std_forma_pagamento CASCADE CONSTRAINTS;

DROP TABLE t_std_gptprompt CASCADE CONSTRAINTS;

DROP TABLE t_std_materia CASCADE CONSTRAINTS;

DROP TABLE t_std_modulo CASCADE CONSTRAINTS;

DROP TABLE t_std_pagamento CASCADE CONSTRAINTS;

DROP TABLE t_std_plano CASCADE CONSTRAINTS;

DROP TABLE t_std_submodulo CASCADE CONSTRAINTS;

DROP TABLE t_std_usuario CASCADE CONSTRAINTS;

CREATE TABLE t_std_alternativa (
    id_alternativa NUMBER(5) NOT NULL,
    id_exercicio   NUMBER(5) NOT NULL,
    ds_alternativa VARCHAR2(100) NOT NULL,
    ds_resposta    CHAR(1) NOT NULL
);

ALTER TABLE t_std_alternativa ADD CONSTRAINT t_std_alternativa_pk PRIMARY KEY ( id_alternativa );

CREATE TABLE t_std_aula (
    id_aula           NUMBER(5) NOT NULL,
    id_materia        NUMBER(5) NOT NULL,
    ds_titulo         VARCHAR2(30) NOT NULL,
    ds_descricao_aula VARCHAR2(50) NOT NULL
);

ALTER TABLE t_std_aula ADD CONSTRAINT t_std_aula_pk PRIMARY KEY ( id_aula );

CREATE TABLE t_std_cronograma (
    id_cronograma  NUMBER(5) NOT NULL,
    id_usuario     NUMBER(10) NOT NULL,
    nr_porcentagem NUMBER(3) NOT NULL
);

ALTER TABLE t_std_cronograma ADD CONSTRAINT t_std_cronograma_pk PRIMARY KEY ( id_cronograma );

CREATE TABLE t_std_exercicio (
    id_exercicio NUMBER(5) NOT NULL,
    id_submodulo NUMBER(5) NOT NULL,
    ds_titulo    VARCHAR2(50) NOT NULL,
    ds_pergunta  VARCHAR2(50) NOT NULL
);

ALTER TABLE t_std_exercicio ADD CONSTRAINT t_std_exercicio_pk PRIMARY KEY ( id_exercicio );

CREATE TABLE t_std_forma_pagamento (
    id_forma_pagamento NUMBER(5) NOT NULL,
    id_plano           NUMBER(2) NOT NULL,
    id_pagamento       NUMBER(5) NOT NULL,
    nm_titular         VARCHAR2(50) NOT NULL,
    nr_cpf             VARCHAR2(11) NOT NULL,
    nr_cartao          NUMBER(16),
    dt_validade        DATE,
    nr_cvv             NUMBER(3)
);

ALTER TABLE t_std_forma_pagamento ADD CONSTRAINT t_std_forma_pagamento_pk PRIMARY KEY ( id_forma_pagamento );

CREATE TABLE t_std_gptprompt (
    id_prompt         NUMBER(5) NOT NULL,
    id_cronograma     NUMBER(5) NOT NULL,
    dt_prompt         DATE NOT NULL,
    ds_prompt         VARCHAR2(30) NOT NULL,
    gpt_choices       BLOB NOT NULL,
    gpt_created       NUMBER(38) NOT NULL,
    gpt_id            VARCHAR2(100) NOT NULL,
    gpt_model         VARCHAR2(100) NOT NULL,
    gpt_object        VARCHAR2(100) NOT NULL,
    gpt_compl_tokens  NUMBER(38) NOT NULL,
    gpt_prompt_tokens NUMBER(38) NOT NULL,
    gpt_total_tokens  NUMBER(38) NOT NULL
);

ALTER TABLE t_std_gptprompt ADD CONSTRAINT t_std_gptprompt_pk PRIMARY KEY ( id_prompt );

CREATE TABLE t_std_materia (
    id_materia    NUMBER(5) NOT NULL,
    id_cronograma NUMBER(5) NOT NULL,
    nm_materia    VARCHAR2(50) NOT NULL,
    nr_nivel      NUMBER(1) NOT NULL
);

ALTER TABLE t_std_materia ADD CONSTRAINT t_std_materia_pk PRIMARY KEY ( id_materia );

CREATE TABLE t_std_modulo (
    id_modulo NUMBER(5) NOT NULL,
    id_aula   NUMBER(5) NOT NULL,
    ds_modulo VARCHAR2(50) NOT NULL
);

ALTER TABLE t_std_modulo ADD CONSTRAINT t_std_modulo_pk PRIMARY KEY ( id_modulo );

CREATE TABLE t_std_pagamento (
    id_pagamento        NUMBER(5) NOT NULL,
    dt_pagamento        DATE NOT NULL,
    vl_pagamento        NUMBER(5, 2) NOT NULL,
    ds_status_pagamento CHAR(2) NOT NULL
);

ALTER TABLE t_std_pagamento ADD CONSTRAINT t_std_pagamento_pk PRIMARY KEY ( id_pagamento );

CREATE TABLE t_std_plano (
    id_plano NUMBER(2) NOT NULL,
    nm_plano VARCHAR2(20) NOT NULL,
    vl_preco NUMBER(5, 2) NOT NULL,
    ds_plano VARCHAR2(50) NOT NULL
);

ALTER TABLE t_std_plano ADD CONSTRAINT t_std_plano_pk PRIMARY KEY ( id_plano );

CREATE TABLE t_std_submodulo (
    id_submodulo NUMBER(5) NOT NULL,
    id_modulo    NUMBER(5) NOT NULL,
    ds_titulo    VARCHAR2(30) NOT NULL,
    ds_conteudo  VARCHAR2(50) NOT NULL
);

ALTER TABLE t_std_submodulo ADD CONSTRAINT t_std_submodulo_pk PRIMARY KEY ( id_submodulo );

CREATE TABLE t_std_usuario (
    id_usuario       NUMBER(10) NOT NULL,
    id_plano         NUMBER(2) NOT NULL,
    nm_usuario       VARCHAR2(50) NOT NULL,
    dt_nascimento    DATE NOT NULL,
    ds_cpf           VARCHAR2(11) NOT NULL,
    ds_email         VARCHAR2(80) NOT NULL,
    ds_senha         VARCHAR2(30) NOT NULL,
    dt_criacao_login DATE NOT NULL,
    ds_status_conta  CHAR(1) NOT NULL,
    dt_ultimo_login  DATE NOT NULL
);

ALTER TABLE t_std_usuario ADD CONSTRAINT t_std_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_std_alternativa
    ADD CONSTRAINT t_std_alternativa_exercicio_fk FOREIGN KEY ( id_exercicio )
        REFERENCES t_std_exercicio ( id_exercicio );

ALTER TABLE t_std_aula
    ADD CONSTRAINT t_std_aula_materia_fk FOREIGN KEY ( id_materia )
        REFERENCES t_std_materia ( id_materia );

ALTER TABLE t_std_cronograma
    ADD CONSTRAINT t_std_cronograma_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES t_std_usuario ( id_usuario );

ALTER TABLE t_std_exercicio
    ADD CONSTRAINT t_std_exercicio_submodulo_fk FOREIGN KEY ( id_submodulo )
        REFERENCES t_std_submodulo ( id_submodulo );

ALTER TABLE t_std_forma_pagamento
    ADD CONSTRAINT t_std_forma_pagamento_pg_fk FOREIGN KEY ( id_pagamento )
        REFERENCES t_std_pagamento ( id_pagamento );

ALTER TABLE t_std_forma_pagamento
    ADD CONSTRAINT t_std_forma_pagamento_plano_fk FOREIGN KEY ( id_plano )
        REFERENCES t_std_plano ( id_plano );

ALTER TABLE t_std_gptprompt
    ADD CONSTRAINT t_std_gptprompt_cronograma_fk FOREIGN KEY ( id_cronograma )
        REFERENCES t_std_cronograma ( id_cronograma );

ALTER TABLE t_std_materia
    ADD CONSTRAINT t_std_materia_cronograma_fk FOREIGN KEY ( id_cronograma )
        REFERENCES t_std_cronograma ( id_cronograma );

ALTER TABLE t_std_modulo
    ADD CONSTRAINT t_std_modulo_aula_fk FOREIGN KEY ( id_aula )
        REFERENCES t_std_aula ( id_aula );

ALTER TABLE t_std_submodulo
    ADD CONSTRAINT t_std_submodulo_modulo_fk FOREIGN KEY ( id_modulo )
        REFERENCES t_std_modulo ( id_modulo );

ALTER TABLE t_std_usuario
    ADD CONSTRAINT t_std_usuario_plano_fk FOREIGN KEY ( id_plano )
        REFERENCES t_std_plano ( id_plano );



--COMANDOS DML

-- Populando tabela t_std_plano
INSERT INTO t_std_plano (id_plano,nm_plano, vl_preco, ds_plano) VALUES (1, 'Plano 1', 29.90,'Plano Pro');
INSERT INTO t_std_plano (id_plano,nm_plano, vl_preco, ds_plano) VALUES (2, 'Plano 2', 0,'Plano Gr�tis');
INSERT INTO t_std_plano (id_plano,nm_plano, vl_preco, ds_plano) VALUES (3, 'Plano 3', 19.90,'Plano Iniciante');
INSERT INTO t_std_plano (id_plano,nm_plano, vl_preco, ds_plano) VALUES (4, 'Plano 1', 29.90,'Plano Pro');
INSERT INTO t_std_plano (id_plano,nm_plano, vl_preco, ds_plano) VALUES (5, 'Plano 2', 0,'Plano Gr�tis');

-- Populando tabela t_std_usuario
INSERT INTO t_std_usuario (id_usuario, id_plano, nm_usuario, dt_nascimento, ds_cpf, ds_email, ds_senha, dt_criacao_login, ds_status_conta, dt_ultimo_login) VALUES (1, 1, 'Usu�rio 1', TO_DATE('2000-01-01', 'YYYY-MM-DD'), '12345678901', 'usuario1@example.com', 'senha1', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'A', TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO t_std_usuario (id_usuario, id_plano, nm_usuario, dt_nascimento, ds_cpf, ds_email, ds_senha, dt_criacao_login, ds_status_conta, dt_ultimo_login) VALUES (2, 2, 'Usu�rio 2', TO_DATE('2000-02-02', 'YYYY-MM-DD'), '23456789012', 'usuario2@example.com', 'senha2', TO_DATE('2023-02-02', 'YYYY-MM-DD'), 'A', TO_DATE('2023-02-02', 'YYYY-MM-DD'));
INSERT INTO t_std_usuario (id_usuario, id_plano, nm_usuario, dt_nascimento, ds_cpf, ds_email, ds_senha, dt_criacao_login, ds_status_conta, dt_ultimo_login) VALUES (3, 2, 'Usu�rio 3', TO_DATE('2000-03-03', 'YYYY-MM-DD'), '34567890123', 'usuario3@example.com', 'senha3', TO_DATE('2023-03-03', 'YYYY-MM-DD'), 'A', TO_DATE('2023-03-03', 'YYYY-MM-DD'));
INSERT INTO t_std_usuario (id_usuario, id_plano, nm_usuario, dt_nascimento, ds_cpf, ds_email, ds_senha, dt_criacao_login, ds_status_conta, dt_ultimo_login) VALUES (4, 3, 'Usu�rio 4', TO_DATE('2000-04-04', 'YYYY-MM-DD'), '45678901234', 'usuario4@example.com', 'senha4', TO_DATE('2023-04-04', 'YYYY-MM-DD'), 'A', TO_DATE('2023-04-04', 'YYYY-MM-DD'));
INSERT INTO t_std_usuario (id_usuario, id_plano, nm_usuario, dt_nascimento, ds_cpf, ds_email, ds_senha, dt_criacao_login, ds_status_conta, dt_ultimo_login) VALUES (5, 3, 'Usu�rio 5', TO_DATE('2000-05-05', 'YYYY-MM-DD'), '56789012345', 'usuario5@example.com', 'senha5', TO_DATE('2023-05-05', 'YYYY-MM-DD'), 'A', TO_DATE('2023-05-05', 'YYYY-MM-DD'));

-- Populando tabela t_std_cronograma
INSERT INTO t_std_cronograma (id_cronograma, id_usuario, nr_porcentagem) VALUES (1, 1, 50);
INSERT INTO t_std_cronograma (id_cronograma, id_usuario, nr_porcentagem) VALUES (2, 2, 75);
INSERT INTO t_std_cronograma (id_cronograma, id_usuario, nr_porcentagem) VALUES (3, 3, 25);
INSERT INTO t_std_cronograma (id_cronograma, id_usuario, nr_porcentagem) VALUES (4, 4, 90);
INSERT INTO t_std_cronograma (id_cronograma, id_usuario, nr_porcentagem) VALUES (5, 5, 60);

-- Populando tabela t_std_materia
INSERT INTO t_std_materia (id_materia, id_cronograma, nm_materia, nr_nivel) VALUES (1, 1, 'Mat�ria 1', 1);
INSERT INTO t_std_materia (id_materia, id_cronograma, nm_materia, nr_nivel) VALUES (2, 1, 'Mat�ria 2', 2);
INSERT INTO t_std_materia (id_materia, id_cronograma, nm_materia, nr_nivel) VALUES (3, 2, 'Mat�ria 1', 3);
INSERT INTO t_std_materia (id_materia, id_cronograma, nm_materia, nr_nivel) VALUES (4, 2, 'Mat�ria 2', 1);
INSERT INTO t_std_materia (id_materia, id_cronograma, nm_materia, nr_nivel) VALUES (5, 3, 'Mat�ria 1', 3);

-- Populando tabela t_std_aula
INSERT INTO t_std_aula (id_aula, id_materia, ds_titulo, ds_descricao_aula) VALUES (1, 1, 'Aula 1', 'Descri��o da Aula 1');
INSERT INTO t_std_aula (id_aula, id_materia, ds_titulo, ds_descricao_aula) VALUES (2, 1, 'Aula 2', 'Descri��o da Aula 2');
INSERT INTO t_std_aula (id_aula, id_materia, ds_titulo, ds_descricao_aula) VALUES (3, 2, 'Aula 1', 'Descri��o da Aula 1');
INSERT INTO t_std_aula (id_aula, id_materia, ds_titulo, ds_descricao_aula) VALUES (4, 2, 'Aula 2', 'Descri��o da Aula 2');
INSERT INTO t_std_aula (id_aula, id_materia, ds_titulo, ds_descricao_aula) VALUES (5, 3, 'Aula 1', 'Descri��o da Aula 1');

-- Populando tabela t_std_modulo
INSERT INTO t_std_modulo (id_modulo, id_aula, ds_modulo) VALUES (1, 1, 'M�dulo 1');
INSERT INTO t_std_modulo (id_modulo, id_aula, ds_modulo) VALUES (2, 1, 'M�dulo 2');
INSERT INTO t_std_modulo (id_modulo, id_aula, ds_modulo) VALUES (3, 2, 'M�dulo 1');
INSERT INTO t_std_modulo (id_modulo, id_aula, ds_modulo) VALUES (4, 2, 'M�dulo 2');
INSERT INTO t_std_modulo (id_modulo, id_aula, ds_modulo) VALUES (5, 3, 'M�dulo 1');

-- Populando tabela t_std_submodulo
INSERT INTO t_std_submodulo (id_submodulo, id_modulo, ds_titulo, ds_conteudo) VALUES (1, 1, 'Subm�dulo A', 'Conte�do A');
INSERT INTO t_std_submodulo (id_submodulo, id_modulo, ds_titulo, ds_conteudo) VALUES (2, 1, 'Subm�dulo B', 'Conte�do B');
INSERT INTO t_std_submodulo (id_submodulo, id_modulo, ds_titulo, ds_conteudo) VALUES (3, 2, 'Subm�dulo A', 'Conte�do C');
INSERT INTO t_std_submodulo (id_submodulo, id_modulo, ds_titulo, ds_conteudo) VALUES (4, 2, 'Subm�dulo B', 'Conte�do D');
INSERT INTO t_std_submodulo (id_submodulo, id_modulo, ds_titulo, ds_conteudo) VALUES (5, 3, 'Subm�dulo A', 'Conte�do E');

-- Populando tabela t_std_exercicio
INSERT INTO t_std_exercicio (id_exercicio, id_submodulo, ds_titulo, ds_pergunta) VALUES (1, 1, 'Exerc�cio 1', 'Qual � a capital do Brasil?');
INSERT INTO t_std_exercicio (id_exercicio, id_submodulo, ds_titulo, ds_pergunta) VALUES (2, 1, 'Exerc�cio 2', 'Quanto � 2 + 2?');
INSERT INTO t_std_exercicio (id_exercicio, id_submodulo, ds_titulo, ds_pergunta) VALUES (3, 2, 'Exerc�cio 1', 'Qual � o maior planeta do sistema solar?');
INSERT INTO t_std_exercicio (id_exercicio, id_submodulo, ds_titulo, ds_pergunta) VALUES (4, 2, 'Exerc�cio 2', 'Quem pintou a Mona Lisa?');
INSERT INTO t_std_exercicio (id_exercicio, id_submodulo, ds_titulo, ds_pergunta) VALUES (5, 3, 'Exerc�cio 1', 'Qual � a f�rmula qu�mica da �gua?');

-- Populando tabela t_std_alternativa
INSERT INTO t_std_alternativa (id_alternativa, id_exercicio, ds_alternativa, ds_resposta) VALUES (1, 1, 'Gatos s�o felinos', 'A');
INSERT INTO t_std_alternativa (id_alternativa, id_exercicio, ds_alternativa, ds_resposta) VALUES (2, 1, 'A f�rmula da �gua � H20', 'B');
INSERT INTO t_std_alternativa (id_alternativa, id_exercicio, ds_alternativa, ds_resposta) VALUES (3, 1, '2+2 � 4', 'C');
INSERT INTO t_std_alternativa (id_alternativa, id_exercicio, ds_alternativa, ds_resposta) VALUES (4, 2, 'Segunda Guerra Mundial', 'A');
INSERT INTO t_std_alternativa (id_alternativa, id_exercicio, ds_alternativa, ds_resposta) VALUES (5, 2, 'Hist�ria', 'B');

-- Populando tabela t_std_pagamento
INSERT INTO t_std_pagamento (id_pagamento, dt_pagamento, vl_pagamento, ds_status_pagamento) VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'),29.9, 'P');
INSERT INTO t_std_pagamento (id_pagamento, dt_pagamento, vl_pagamento, ds_status_pagamento) VALUES (2, TO_DATE('2023-02-23', 'YYYY-MM-DD'),0, 'N');
INSERT INTO t_std_pagamento (id_pagamento, dt_pagamento, vl_pagamento, ds_status_pagamento) VALUES (3, TO_DATE('2023-04-01', 'YYYY-MM-DD'),19.9, 'P');
INSERT INTO t_std_pagamento (id_pagamento, dt_pagamento, vl_pagamento, ds_status_pagamento) VALUES (4, TO_DATE('2023-01-12', 'YYYY-MM-DD'),0, 'N');
INSERT INTO t_std_pagamento (id_pagamento, dt_pagamento, vl_pagamento, ds_status_pagamento) VALUES (5, TO_DATE('2023-05-31', 'YYYY-MM-DD'),29.9, 'P');

-- Populando tabela t_std_forma_pagamento
INSERT INTO t_std_forma_pagamento (id_forma_pagamento, id_plano, id_pagamento, nm_titular, nr_cpf, nr_cartao, dt_validade, nr_cvv) VALUES (1, 1, 1, 'Titular 1', '12345678901', 1234567890123456, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 123);
INSERT INTO t_std_forma_pagamento (id_forma_pagamento, id_plano, id_pagamento, nm_titular, nr_cpf, nr_cartao, dt_validade, nr_cvv) VALUES (2, 2, 2, 'Titular 2', '23456789012', 2345678901234567, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 234);
INSERT INTO t_std_forma_pagamento (id_forma_pagamento, id_plano, id_pagamento, nm_titular, nr_cpf, nr_cartao, dt_validade, nr_cvv) VALUES (3, 2, 3, 'Titular 3', '34567890123', 3456789012345678, TO_DATE('2023-08-31', 'YYYY-MM-DD'), 345);
INSERT INTO t_std_forma_pagamento (id_forma_pagamento, id_plano, id_pagamento, nm_titular, nr_cpf, nr_cartao, dt_validade, nr_cvv) VALUES (4, 3, 4, 'Titular 4', '45678901234', 4567890123456789, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 456);
INSERT INTO t_std_forma_pagamento (id_forma_pagamento, id_plano, id_pagamento, nm_titular, nr_cpf, nr_cartao, dt_validade, nr_cvv) VALUES (5, 3, 5, 'Titular 5', '56789012345', 5678901234567890, TO_DATE('2024-04-30', 'YYYY-MM-DD'), 567);

UPDATE
  T_STD_PLANO
SET
  NM_PLANO = 'PLANO 3',
  VL_PRECO = 19.90
WHERE
  ID_PLANO = 2






--- COMANDOS DQL

-- RETORNA A PORCENTAGEM COMPLETA DO CURSO DE CADA USU�RIO
SELECT t_std_usuario.nm_usuario, t_std_cronograma.nr_porcentagem
FROM t_std_usuario
INNER JOIN t_std_cronograma ON t_std_usuario.id_usuario = t_std_cronograma.id_usuario;


-- RETORNA O N�MERO DE USU�RIOS QUE UTILIZAM DETERMINADO PLANO
SELECT ID_PLANO AS "PLANO", COUNT(ID_USUARIO) AS "NUMERO DE USUARIOS"
FROM T_STD_USUARIO 
GROUP BY ID_PLANO;