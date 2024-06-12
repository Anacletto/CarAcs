CREATE DATABASE caracs;

USE caracs;

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    primeiroNome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    anoNascimento INT NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    cidade VARCHAR(20) NOT NULL
);

CREATE TABLE funcionarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    primeiroNome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    telefone INT NOT NULL
);


CREATE TABLE carros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    preco FLOAT NOT NULL,
    anoFabrico INT NOT NULL,
    cor VARCHAR(15) NOT NULL,
    marca VARCHAR(20) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    garantia INT NOT NULL,
    quantidadeDisponivel INT
);


CREATE TABLE cartoesCredito (
    numeroCartao INT PRIMARY KEY,
    dataValidade DATE NOT NULL,
    codigoSeguranca INT NOT NULL,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente)
        REFERENCES clientes (id)
);


CREATE TABLE  testes (
	id INT PRIMARY KEY AUTO_INCREMENT,
    dataTeste DATE NOT NULL,
    horaTeste TIME NOT NULL,
    idcliente INT NOT NULL,
    FOREIGN KEY (idcliente)
        REFERENCES clientes (id),
    idcarro INT NOT NULL,
    FOREIGN KEY (idcarro)
        REFERENCES carros (id)
);

CREATE TABLE compras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dataCompra DATE NOT NULL,
    horaCompra TIME NOT NULL,
    quantidade INT NOT NULL,
    valorCompra FLOAT NOT NULL,
    idcliente INT NOT NULL,
    FOREIGN KEY (idCliente)
        REFERENCES clientes (id),
    idcarro INT NOT NULL,
    FOREIGN KEY(idcarro)
        REFERENCES carros (id)
);


CREATE TABLE clientes_liga_funcionarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idfuncionario INT NOT NULL,
    FOREIGN KEY (idfuncionario)
        REFERENCES funcionarios (id),
    idcliente INT NOT NULL,
    FOREIGN KEY (idcliente)
        REFERENCES clientes (id)
);

-- Retorna o carro com maior preco
SELECT 
    id, marca, modelo, preco
FROM
    carros AS Car
WHERE
    Car.preco = (SELECT 
            MAX(preco)
        FROM
            carros);

-- Retorna o carro com menor preco
SELECT 
    id, marca, modelo, preco
FROM
    carros AS Car
WHERE
    Car.preco = (SELECT 
            MIN(preco)
        FROM
            carros);

-- retorna o carro mais antigo
SELECT 
    id, marca, modelo, anoFabrico
FROM
    carros AS Car
WHERE
    Car.anoFabrico = (SELECT 
            MIN(anoFabrico)
        FROM
            carros);

-- Retorna o carro mais novo
SELECT 
    id, marca, modelo, anoFabrico
FROM
    carros AS Car
WHERE
    Car.anoFabrico = (SELECT 
            MAX(anoFabrico)
        FROM
            carros);

-- Retorna o carro em menor quantidade
SELECT 
    id, marca, modelo, quantidadeDisponivel
FROM
    carros AS Car
WHERE
    Car.quantidadeDisponivel = (SELECT 
            MIN(quantidadeDisponivel)
        FROM
            carros);

-- Retorna o carro em maior quantidade
SELECT 
    id, marca, modelo, quantidadeDisponivel
FROM
    carros AS Car
WHERE
    Car.quantidadeDisponivel = (SELECT 
            MAX(quantidadeDisponivel)
        FROM
            carros);


-- View de todos os carros verdes
CREATE VIEW GreenCars AS 
    SELECT 
        id,marca,modelo,cor 
    FROM 
        carros 
    WHERE
         cor LIKE "Verde"; 



-- Todos os carros com modelo KIA
    SELECT 
        id,marca,modelo 
    FROM 
        carros 
    WHERE 
        marca LIKE "Kia";




-- View de todos carros com garantia maior de 1 ano
CREATE VIEW LongWarranty AS 
    SELECT 
        id,marca,modelo,garantia
    FROM 
        carros 
    WHERE 
        garantia > 1; 



-- Procedimentos do cliente


DELIMITER  //
CREATE PROCEDURE InsertCliente(
    IN cliente_primeiroNome VARCHAR(50),
    IN cliente_sobrenome VARCHAR(50),
    IN cliente_anoNascimento INT,
    IN cliente_bairro VARCHAR(50),
    IN cliente_provincia VARCHAR(20),
    IN cliente_cidade VARCHAR(20)
)
BEGIN
    INSERT INTO clientes (primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade)
    VALUES (cliente_primeiroNome, cliente_sobrenome, cliente_anoNascimento, cliente_bairro, cliente_provincia, cliente_cidade);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetCliente(IN cliente_id INT)
BEGIN
    SELECT * FROM clientes WHERE id = cliente_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateCliente(
    IN cliente_id INT,
    IN novo_primeiroNome VARCHAR(50)
)
BEGIN
    UPDATE clientes
    SET primeiroNome = novo_primeiroNome
    WHERE id = cliente_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteCliente(IN cliente_id INT)
BEGIN
    DELETE FROM clientes WHERE id = cliente_id;
END //
DELIMITER ;


-- Procedimentos do funcionario


DELIMITER  //
CREATE PROCEDURE InsertFuncionario(
    IN funcionario_primeiroNome VARCHAR(50),
    IN funcionario_sobrenome VARCHAR(50),
    IN funcionario_provincia VARCHAR(20),
    IN funcionario_cidade VARCHAR(20),
    IN funcionario_bairro VARCHAR(50),
    IN funcionario_telefone INT
)
BEGIN
    INSERT INTO funcionarios (primeiroNome, sobrenome, provincia, cidade, bairro, telefone)
    VALUES (funcionario_primeiroNome, funcionario_sobrenome, funcionario_provincia, funcionario_cidade, funcionario_bairro, funcionario_telefone);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetFuncionario(IN funcionario_id INT)
BEGIN
    SELECT * FROM funcionarios WHERE id = funcionario_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateFuncionario(
    IN funcionario_id INT,
    IN novo_primeiroNome VARCHAR(50)
)
BEGIN
    UPDATE funcionarios
    SET primeiroNome = novo_primeiroNome
    WHERE id = funcionario_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteFuncionario(IN funcionario_id INT)
BEGIN
    DELETE FROM funcionarios WHERE id = funcionario_id;
END //
DELIMITER ;


-- Procedimentos do carro

DELIMITER  //
CREATE PROCEDURE InsertCarro(
    IN carro_preco FLOAT,
    IN carro_anoFabrico INT,
    IN carro_cor VARCHAR(15),
    IN carro_marca VARCHAR(20),
    IN carro_modelo VARCHAR(20),
    IN carro_garantia INT,
    IN carro_quantidadeDisponivel INT
)
BEGIN
    INSERT INTO carros (preco, anoFabrico, cor, marca, modelo, garantia, quantidadeDisponivel)
    VALUES (carro_preco, carro_anoFabrico, carro_cor, carro_marca, carro_modelo, carro_garantia, carro_quantidadeDisponivel);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetCarro(IN carro_id INT)
BEGIN
    SELECT * FROM carros WHERE id = carro_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateCarro(
    IN carro_id INT,
    IN novo_preco FLOAT
)
BEGIN
    UPDATE carros
    SET preco = novo_preco
    WHERE id = carro_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteCarro(IN carro_id INT)
BEGIN
    DELETE FROM carros WHERE id = carro_id;
END //
DELIMITER ;


-- Procedimentos do cartão de credito

DELIMITER  //
CREATE PROCEDURE InsertCartaoCredito(
    IN cartao_numeroCartao INT,
    IN cartao_dataValidade DATE,
    IN cartao_codigoSeguranca INT,
    IN cartao_idCliente INT
)
BEGIN
    INSERT INTO cartoesCredito (numeroCartao, dataValidade, codigoSeguranca, idCliente)
    VALUES (cartao_numeroCartao, cartao_dataValidade, cartao_codigoSeguranca, cartao_idCliente);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetCartaoCredito(IN cartao_numeroCartao INT)
BEGIN
    SELECT * FROM cartoesCredito WHERE numeroCartao = cartao_numeroCartao;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateCartaoCredito(
    IN cartao_numeroCartao INT,
    IN novo_dataValidade DATE
)
BEGIN
    UPDATE cartoesCredito
    SET dataValidade = novo_dataValidade
    WHERE numeroCartao = cartao_numeroCartao;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteCartaoCredito(IN cartao_numeroCartao INT)
BEGIN
    DELETE FROM cartoesCredito WHERE numeroCartao = cartao_numeroCartao;
END //
DELIMITER ;



-- Procedimentos do teste


DELIMITER  //
CREATE PROCEDURE InsertTeste(
    IN teste_idcliente INT,
    IN teste_idcarro INT
)
BEGIN
    INSERT INTO testes (dataTeste, horaTeste, idcliente, idcarro)
    VALUES (current_date(), current_time(), teste_idcliente, teste_idcarro);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetTeste(IN teste_id INT)
BEGIN
    SELECT * FROM testes WHERE id = teste_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateTeste(
    IN teste_id INT,
    IN novo_dataTeste DATE
)
BEGIN
    UPDATE testes
    SET dataTeste = novo_dataTeste
    WHERE id = teste_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteTeste(IN teste_id INT)
BEGIN
    DELETE FROM testes WHERE id = teste_id;
END //
DELIMITER ;


-- Procedimentos das compras


DELIMITER  //
CREATE PROCEDURE InsertCompra(
    IN compra_dataCompra DATE,
    IN compra_horaCompra TIME,
    IN compra_quantidade INT,
    IN compra_valorCompra FLOAT,
    IN compra_idcliente INT,
    IN compra_idcarro INT
)
BEGIN
    INSERT INTO compras (dataCompra, horaCompra, quantidade, valorCompra, idcliente, idcarro)
    VALUES (compra_dataCompra, compra_horaCompra, compra_quantidade, compra_valorCompra, compra_idcliente, compra_idcarro);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetCompra(IN compra_id INT)
BEGIN
    SELECT * FROM compras WHERE id = compra_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateCompra(
    IN compra_id INT,
    IN novo_dataCompra DATE
)
BEGIN
    UPDATE compras
    SET dataCompra = novo_dataCompra
    WHERE id = compra_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteCompra(IN compra_id INT)
BEGIN
    DELETE FROM compras WHERE id = compra_id;
END //
DELIMITER ;


-- Procedimentos da relação clientes liga funcionarios


DELIMITER  //
CREATE PROCEDURE InsertLigacao(
    IN funcionario_id INT,
    IN cliente_id INT
)
BEGIN
    INSERT INTO clientes_liga_funcionarios (idfuncionario, idcliente)
    VALUES (funcionario_id,cliente_id);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetLigacao(IN cliente_id INT)
BEGIN
    SELECT * FROM clientes_liga_funcionarios WHERE idcliente = cliente_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteLigacao(
    IN idligacao INT
)
BEGIN
    DELETE FROM clientes_liga_funcionarios WHERE id = idligacao;
END //
DELIMITER ;
