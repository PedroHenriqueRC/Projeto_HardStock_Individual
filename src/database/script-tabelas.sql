-- Criando a base de dados HardStock
CREATE DATABASE IF NOT EXISTS HardStock;

-- Usando a base de dados criada
USE HardStock;

-- Tabela Funcionario para armazenar dados dos funcionários
CREATE TABLE IF NOT EXISTS Funcionario (
    idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(100),
    numeroTelefone char(11),
    email VARCHAR(256),
    senha VARCHAR(256),	
    permissao VARCHAR(45),
    fkAdministrador INT,
    fkEmpresa INT,
    estado varchar(45) default "Ativo",
    fkHardStock VARCHAR(45) DEFAULT "NP",
    FOREIGN KEY (fkAdministrador) REFERENCES Funcionario(idFuncionario)
);

-- Inserindo um registro na tabela Funcionario
INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao, fkAdministrador, fkHardStock)
VALUES ('João', 'Silva', 123456789, 'joao.silva@empresa.com', 'senhaSegura123', 'Adm', NULL, 'NP');

INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao, fkAdministrador, fkHardStock)
VALUES ('eli', 'rufino', 123456789, 'eli.rufino@empresa.com', '123456', '1', NULL, 'NP');

-- Tabela Empresa para armazenar informações da empresa
CREATE TABLE IF NOT EXISTS Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    fkRepresentante INT DEFAULT NULL,
    razaoSocial VARCHAR(256),
    cnpj CHAR(14),
    emailCorporativo VARCHAR(256),
    FOREIGN KEY (fkRepresentante) REFERENCES Funcionario(idFuncionario)
);
select * from Empresa;
-- Inserindo um registro na tabela Empresa, relacionando com Funcionario
INSERT INTO Empresa (fkRepresentante, razaoSocial, cnpj, emailCorporativo)
VALUES (1, 'Tech Solutions Ltda', '12345678000195', 'contato@techsolutions.com');

-- Tabela Especificacoes para armazenar detalhes técnicos de servidores
CREATE TABLE IF NOT EXISTS Especificacoes (
    idEspecificacao INT AUTO_INCREMENT PRIMARY KEY,
    distribuicao VARCHAR(70),
    sistemaOperacional VARCHAR(50),
    processador VARCHAR(100),
    memoriaRam INT,
    qntDisco INT,
    placaRede VARCHAR(50)
);
-- Inserindo um registro na tabela Especificacoes
INSERT INTO Especificacoes (distribuicao, sistemaOperacional, processador, memoriaRam, qntDisco, placaRede)
VALUES ('Ubuntu', 'Linux', 'Intel Xeon E5', 16, 2, 'Intel Ethernet I210');


-- Tabela Servidor para armazenar dados dos servidores e associá-los à empresa e especificações
-- Tabela Servidor para armazenar dados dos servidores e associá-los à empresa e especificações
CREATE TABLE IF NOT EXISTS Servidor (
    idServidor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    fkEmpresa INT,
    fkEspecificacao INT,
    UNIQUE (idServidor),  -- Garantir que idServidor seja único
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkEspecificacao) REFERENCES Especificacoes(idEspecificacao)
);

-- Inserindo um registro na tabela Servidor, relacionando com Empresa e Especificacoes
INSERT INTO Servidor (nome, fkEmpresa, fkEspecificacao)
VALUES ('ServidorPrincipal', 1, 1);

-- Tabela Componentes para definir o tipo de componente e unidade de medida
CREATE TABLE IF NOT EXISTS Componentes (
    idComponente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, -- Nome do componente (e.g., CPU Uso, Memória RAM)
    unidadeMedida VARCHAR(20) NOT NULL -- Unidade de medida (e.g., %, GB)
);

INSERT INTO Componentes (nome, unidadeMedida) VALUES 
('CPU Uso', '%'),
('Memória RAM', 'GB'),
('Armazenamento', 'GB'),
('Uso Disco', '%'),
('Rede Upload', 'Mbps'),
('Rede Download', 'Mbps');


/*
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Enviados', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Recebidos', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso da CPU', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Velocidade da CPU', 'MHz');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo Ativo da CPU', 's');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Usado', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Livre', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Porcentagem de Disco Usado', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo de Leitura do Disco', 'ms');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo de Gravação do Disco', 'ms');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Disponível', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Porcentagem de Memória Usada', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Usada', 'GB');
*/

select * from funcionario;

-- Tabela Capturas para armazenar os valores capturados de componentes
CREATE TABLE IF NOT EXISTS Capturas (
    idCaptura INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Data e hora da captura
    valor FLOAT NOT NULL, -- Valor capturado (e.g., 75.5)
    fkComponente INT, -- Referência ao componente capturado
    fkServidor INT, -- Referência ao servidor
    FOREIGN KEY (fkComponente) REFERENCES Componentes(idComponente),
    FOREIGN KEY (fkServidor) REFERENCES Servidor(idServidor)
);

-- Inserindo capturas para monitoramento dos componentes em dois servidores
INSERT INTO Capturas (data_hora, valor, fkComponente, fkServidor) VALUES
('2024-11-05 09:00:00', 35.2, 1, 1),
('2024-11-05 09:01:00', 36.8, 1, 1),
('2024-11-05 09:02:00', 33.5, 1, 1),
('2024-11-05 09:03:00', 40.1, 1, 1),
('2024-11-05 09:04:00', 45.6, 1, 1),
('2024-11-05 09:05:00', 50.0, 1, 1),
('2024-11-05 09:06:00', 55.3, 1, 1),
('2024-11-05 09:07:00', 60.7, 1, 1),
('2024-11-05 09:08:00', 65.2, 1, 1),
('2024-11-05 09:09:00', 70.1, 1, 1),

('2024-11-05 09:00:00', 8.5, 2, 1),
('2024-11-05 09:01:00', 8.2, 2, 1),
('2024-11-05 09:02:00', 7.9, 2, 1),
('2024-11-05 09:03:00', 8.1, 2, 1),
('2024-11-05 09:04:00', 8.0, 2, 1),
('2024-11-05 09:05:00', 8.3, 2, 1),
('2024-11-05 09:06:00', 7.8, 2, 1),
('2024-11-05 09:07:00', 8.6, 2, 1),
('2024-11-05 09:08:00', 8.4, 2, 1),
('2024-11-05 09:09:00', 8.7, 2, 1),

('2024-11-05 09:00:00', 120.5, 3, 1),
('2024-11-05 09:01:00', 121.0, 3, 1),
('2024-11-05 09:02:00', 119.9, 3, 1),
('2024-11-05 09:03:00', 122.3, 3, 1),
('2024-11-05 09:04:00', 121.4, 3, 1),
('2024-11-05 09:05:00', 119.7, 3, 1),
('2024-11-05 09:06:00', 120.8, 3, 1),
('2024-11-05 09:07:00', 121.2, 3, 1),
('2024-11-05 09:08:00', 120.3, 3, 1),
('2024-11-05 09:09:00', 119.6, 3, 1),

('2024-11-05 09:00:00', 52.3, 4, 2),
('2024-11-05 09:01:00', 53.1, 4, 2),
('2024-11-05 09:02:00', 51.8, 4, 2),
('2024-11-05 09:03:00', 54.0, 4, 2),
('2024-11-05 09:04:00', 53.7, 4, 2),
('2024-11-05 09:05:00', 52.2, 4, 2),
('2024-11-05 09:06:00', 54.3, 4, 2),
('2024-11-05 09:07:00', 53.9, 4, 2),
('2024-11-05 09:08:00', 52.7, 4, 2),
('2024-11-05 09:09:00', 54.1, 4, 2),

('2024-11-05 09:00:00', 30.2, 5, 2),
('2024-11-05 09:01:00', 29.9, 5, 2),
('2024-11-05 09:02:00', 31.0, 5, 2),
('2024-11-05 09:03:00', 30.7, 5, 2),
('2024-11-05 09:04:00', 30.5, 5, 2),
('2024-11-05 09:05:00', 31.1, 5, 2),
('2024-11-05 09:06:00', 30.4, 5, 2),
('2024-11-05 09:07:00', 30.8, 5, 2),
('2024-11-05 09:08:00', 30.1, 5, 2),
('2024-11-05 09:09:00', 31.2, 5, 2),

('2024-11-05 09:00:00', 25.1, 6, 2),
('2024-11-05 09:01:00', 24.8, 6, 2),
('2024-11-05 09:02:00', 25.5, 6, 2),
('2024-11-05 09:03:00', 25.2, 6, 2),
('2024-11-05 09:04:00', 24.9, 6, 2),
('2024-11-05 09:05:00', 25.6, 6, 2),
('2024-11-05 09:06:00', 25.0, 6, 2),
('2024-11-05 09:07:00', 25.3, 6, 2),
('2024-11-05 09:08:00', 24.7, 6, 2),
('2024-11-05 09:09:00', 25.4, 6, 2);


-- Exemplo de componentes para referência
INSERT INTO Componentes (nome, unidadeMedida) VALUES 
('CPU Uso', '%'),
('Memória RAM', 'GB'),
('Disco', '%');

-- Certifique-se de que existem dados em Componentes e Servidor antes de rodar isso

DELIMITER $$

CREATE PROCEDURE PopulateCapturas()
BEGIN
    DECLARE startDate DATE DEFAULT CURDATE() - INTERVAL 180 DAY;
    DECLARE endDate DATE DEFAULT CURDATE();
    
    WHILE startDate < endDate DO
        -- Insere 3 registros para a data atual (startDate) com valores aleatórios
        INSERT INTO Capturas (data_hora, valor, fkComponente, fkServidor)
        VALUES
            (startDate + INTERVAL RAND() * 24 HOUR, RAND() * 100, FLOOR(1 + RAND() * (SELECT COUNT(*) FROM Componentes)), 1),
            (startDate + INTERVAL RAND() * 24 HOUR, RAND() * 100, FLOOR(1 + RAND() * (SELECT COUNT(*) FROM Componentes)), 1),
            (startDate + INTERVAL RAND() * 24 HOUR, RAND() * 100, FLOOR(1 + RAND() * (SELECT COUNT(*) FROM Componentes)), 1);

        -- Incrementa o dia
        SET startDate = startDate + INTERVAL 1 DAY;
    END WHILE;

END$$

DELIMITER ;

-- Chame a stored procedure para executar as inserções
CALL PopulateCapturas();



SELECT 
    Capturas.valor,
    Componentes.nome AS componente
FROM 
    Capturas
JOIN 
    Componentes ON Capturas.fkComponente = Componentes.idComponente;


SELECT 
    c.nome AS nomeComponente,
    AVG(cap.valor) AS mediaValor
FROM 
    Capturas cap
JOIN 
    Componentes c ON cap.fkComponente = c.idComponente
GROUP BY 
    c.nome;

SELECT 
    c.nome AS nomeComponente,
    AVG(cap.valor) AS mediaValor
FROM 
    Capturas cap
JOIN 
    Componentes c ON cap.fkComponente = c.idComponente
WHERE 
    cap.data_hora >= NOW() - INTERVAL 180 DAY
GROUP BY 
    c.nome;
    

-- Tabela Alertas para registrar alertas associados às capturas
CREATE TABLE IF NOT EXISTS Alertas (
    idAlerta INT AUTO_INCREMENT PRIMARY KEY,
    fkCaptura INT,
    gravidade ENUM('baixo', 'médio', 'alto', 'critico'),
    descricao VARCHAR(256),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkCaptura) REFERENCES Capturas(idCaptura)
);
 
 select * from funcionario;
 alter table Funcionario add constraint ligacao foreign key (fkEmpresa) references Empresa(idEmpresa);

 CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizFunc AS
SELECT idFuncionario,nome,sobrenome,email,fkEmpresa,estado FROM Funcionario;

select * from VizFunc;

select idFuncionario, nome, email, permissao, fkEmpresa from Funcionario where email = 'pedrohenrique@techsolutions.com' AND senha = '123456789';

 CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizEdit AS
SELECT idFuncionario,nome,numeroTelefone, senha, permissao, estado FROM Funcionario;

select*from VizEdit where idFuncionario=1;




insert into funcionario(nome,sobrenome,numeroTelefone,email,senha,permissao) values ('Pedro','Henrique',962752952,'pedrohenrique@techsolutions','123456789','Analista');

SELECT * FROM funcionario;

update funcionario set numeroTelefone = 11111111, senha = 11111111, permissao = 'Gerente' where idFuncionario = 4;
