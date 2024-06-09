CREATE DATABASE carAcsDB;

USE carAcsDB;


CREATE TABLE clientes (
    id INT PRIMARY KEY,
    primeiroNome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    anoNascimento INT NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    cidade VARCHAR(20) NOT NULL
);

CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
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
        REFERENCES carros (id),
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




DELIMITER //DELIMITER //
CREATE PROCEDURE FilterCarByColor(IN Color VARCHAR(15))
BEGIN
    SELECT id,marca,modelo,cor FROM carros WHERE cor LIKE Color; 
END //
DELIMITER ;




DELIMITER //DELIMITER //
CREATE PROCEDURE FilterCarByModel(IN Model VARCHAR(15))
BEGIN
    SELECT id,marca,modelo FROM carros WHERE modelo LIKE Model;
END //
DELIMITER ;



DELIMITER //DELIMITER //
CREATE PROCEDURE FilterCarByMaker(IN Maker VARCHAR(15))
BEGIN
    SELECT id,marca,modelo FROM carros WHERE marca LIKE Maker; 
END //
DELIMITER ;


-- Procedimentos do cliente


DELIMITER //DELIMITER  //
CREATE PROCEDURE InsertCliente(
    IN cliente_id INT,
    IN cliente_primeiroNome VARCHAR(50),
    IN cliente_sobrenome VARCHAR(50),
    IN cliente_anoNascimento INT,
    IN cliente_bairro VARCHAR(50),
    IN cliente_provincia VARCHAR(20),
    IN cliente_cidade VARCHAR(20)
)
BEGIN
    INSERT INTO clientes (id, primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade)
    VALUES (cliente_id, cliente_primeiroNome, cliente_sobrenome, cliente_anoNascimento, cliente_bairro, cliente_provincia, cliente_cidade);
END //


DELIMITER //
CREATE PROCEDURE GetCliente(IN cliente_id INT)
BEGIN
    SELECT * FROM clientes WHERE id = cliente_id;
END //


DELIMITER //
CREATE PROCEDURE UpdateCliente(
    IN cliente_id INT,
    IN novo_primeiroNome VARCHAR(50),
    IN novo_sobrenome VARCHAR(50),
    IN novo_anoNascimento INT,
    IN novo_bairro VARCHAR(50),
    IN novo_provincia VARCHAR(20),
    IN novo_cidade VARCHAR(20)
)
BEGIN
    UPDATE clientes
    SET primeiroNome = novo_primeiroNome, sobrenome = novo_sobrenome, anoNascimento = novo_anoNascimento,
        bairro = novo_bairro, provincia = novo_provincia, cidade = novo_cidade
    WHERE id = cliente_id;
END //


DELIMITER //
CREATE PROCEDURE DeleteCliente(IN cliente_id INT)
BEGIN
    DELETE FROM clientes WHERE id = cliente_id;
END //
DELIMITER ;

-- Procedimentos do funcionario


DELIMITER //DELIMITER  //
CREATE PROCEDURE InsertFuncionario(
    IN funcionario_id INT,
    IN funcionario_primeiroNome VARCHAR(50),
    IN funcionario_sobrenome VARCHAR(50),
    IN funcionario_provincia VARCHAR(20),
    IN funcionario_cidade VARCHAR(20),
    IN funcionario_bairro VARCHAR(50),
    IN funcionario_telefone INT
)
BEGIN
    INSERT INTO funcionarios (id, primeiroNome, sobrenome, provincia, cidade, bairro, telefone)
    VALUES (funcionario_id, funcionario_primeiroNome, funcionario_sobrenome, funcionario_provincia, funcionario_cidade, funcionario_bairro, funcionario_telefone);
END //


DELIMITER //
CREATE PROCEDURE GetFuncionario(IN funcionario_id INT)
BEGIN
    SELECT * FROM funcionarios WHERE id = funcionario_id;
END //


DELIMITER //
CREATE PROCEDURE UpdateFuncionario(
    IN funcionario_id INT,
    IN novo_primeiroNome VARCHAR(50),
    IN novo_sobrenome VARCHAR(50),
    IN novo_provincia VARCHAR(20),
    IN novo_cidade VARCHAR(20),
    IN novo_bairro VARCHAR(50),
    IN novo_telefone INT
)
BEGIN
    UPDATE funcionarios
    SET primeiroNome = novo_primeiroNome, sobrenome = novo_sobrenome, provincia = novo_provincia,
        cidade = novo_cidade, bairro = novo_bairro, telefone = novo_telefone
    WHERE id = funcionario_id;
END //


DELIMITER //
CREATE PROCEDURE DeleteFuncionario(IN funcionario_id INT)
BEGIN
    DELETE FROM funcionarios WHERE id = funcionario_id;
END //
DELIMITER ;

-- Procedimentos do carro


DELIMITER //DELIMITER  //
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


DELIMITER //
CREATE PROCEDURE GetCarro(IN carro_id INT)
BEGIN
    SELECT * FROM carros WHERE id = carro_id;
END //


DELIMITER //
CREATE PROCEDURE UpdateCarro(
    IN carro_id INT,
    IN novo_preco FLOAT,
    IN novo_anoFabrico INT,
    IN nova_cor VARCHAR(15),
    IN nova_marca VARCHAR(20),
    IN novo_modelo VARCHAR(20),
    IN nova_garantia INT,
    IN nova_quantidadeDisponivel INT
)
BEGIN
    UPDATE carros
    SET preco = novo_preco, anoFabrico = novo_anoFabrico, cor = nova_cor, marca = nova_marca,
        modelo = novo_modelo, garantia = nova_garantia, quantidadeDisponivel = nova_quantidadeDisponivel
    WHERE id = carro_id;
END //


DELIMITER //
CREATE PROCEDURE DeleteCarro(IN carro_id INT)
BEGIN
    DELETE FROM carros WHERE id = carro_id;
END //
DELIMITER ;

-- Procedimentos do cartão de credito


DELIMITER //DELIMITER  //
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


DELIMITER //
CREATE PROCEDURE GetCartaoCredito(IN cartao_numeroCartao INT)
BEGIN
    SELECT * FROM cartoesCredito WHERE numeroCartao = cartao_numeroCartao;
END //


DELIMITER //
CREATE PROCEDURE UpdateCartaoCredito(
    IN cartao_numeroCartao INT,
    IN novo_dataValidade DATE,
    IN novo_codigoSeguranca INT,
    IN novo_idCliente INT
)
BEGIN
    UPDATE cartoesCredito
    SET dataValidade = novo_dataValidade, codigoSeguranca = novo_codigoSeguranca, idCliente = novo_idCliente
    WHERE numeroCartao = cartao_numeroCartao;
END //


DELIMITER //
CREATE PROCEDURE DeleteCartaoCredito(IN cartao_numeroCartao INT)
BEGIN
    DELETE FROM cartoesCredito WHERE numeroCartao = cartao_numeroCartao;
END //
DELIMITER ;


-- Procedimentos do teste


DELIMITER //DELIMITER  //
CREATE PROCEDURE InsertTeste(
    IN teste_id INT,
    IN teste_dataTeste DATE,
    IN teste_horaTeste TIME,
    IN teste_idcliente INT,
    IN teste_idcarro INT
)
BEGIN
    INSERT INTO testes (id, dataTeste, horaTeste, idcliente, idcarro)
    VALUES (teste_id, teste_dataTeste, teste_horaTeste, teste_idcliente, teste_idcarro);
END //


DELIMITER //
CREATE PROCEDURE GetTeste(IN teste_id INT)
BEGIN
    SELECT * FROM testes WHERE id = teste_id;
END //


DELIMITER //
CREATE PROCEDURE UpdateTeste(
    IN teste_id INT,
    IN novo_dataTeste DATE,
    IN novo_horaTeste TIME,
    IN novo_idcliente INT,
    IN novo_idcarro INT
)
BEGIN
    UPDATE testes
    SET dataTeste = novo_dataTeste, horaTeste = novo_horaTeste, idcliente = novo_idcliente, idcarro = novo_idcarro
    WHERE id = teste_id;
END //


DELIMITER //
CREATE PROCEDURE DeleteTeste(IN teste_id INT)
BEGIN
    DELETE FROM testes WHERE id = teste_id;
END //
DELIMITER ;

-- Procedimentos das compras


DELIMITER //DELIMITER  //
CREATE PROCEDURE InsertCompra(
    IN compra_id INT,
    IN compra_dataCompra DATE,
    IN compra_horaCompra TIME,
    IN compra_quantidade INT,
    IN compra_valorCompra FLOAT,
    IN compra_idcliente INT,
    IN compra_idcarro INT
)
BEGIN
    INSERT INTO compras (id, dataCompra, horaCompra, quantidade, valorCompra, idcliente, idcarro)
    VALUES (compra_id, compra_dataCompra, compra_horaCompra, compra_quantidade, compra_valorCompra, compra_idcliente, compra_idcarro);
END //


DELIMITER //
CREATE PROCEDURE GetCompra(IN compra_id INT)
BEGIN
    SELECT * FROM compras WHERE id = compra_id;
END //


DELIMITER //
CREATE PROCEDURE UpdateCompra(
    IN compra_id INT,
    IN novo_dataCompra DATE,
    IN novo_horaCompra TIME,
    IN novo_quantidade INT,
    IN novo_valorCompra FLOAT,
    IN novo_idcliente INT,
    IN novo_idcarro INT
)
BEGIN
    UPDATE compras
    SET dataCompra = novo_dataCompra, horaCompra = novo_horaCompra, quantidade = novo_quantidade, 
        valorCompra = novo_valorCompra, idcliente = novo_idcliente, idcarro = novo_idcarro
    WHERE id = compra_id;
END //


DELIMITER //
CREATE PROCEDURE DeleteCompra(IN compra_id INT)
BEGIN
    DELETE FROM compras WHERE id = compra_id;
END //
DELIMITER ;

-- Procedimentos da relação clientes liga funcionarios


DELIMITER //DELIMITER  //
CREATE PROCEDURE InsertClienteLigaFuncionario(
    IN cliente_liga_funcionario_idfuncionario INT,
    IN cliente_liga_funcionario_idcliente INT
)
BEGIN
    INSERT INTO clientes_liga_funcionarios (idfuncionario, idcliente)
    VALUES (cliente_liga_funcionario_idfuncionario, cliente_liga_funcionario_idcliente);
END //


DELIMITER //
CREATE PROCEDURE GetClienteLigaFuncionario(IN cliente_liga_funcionario_idcliente INT)
BEGIN
    SELECT * FROM clientes_liga_funcionarios WHERE idcliente = cliente_liga_funcionario_idcliente;
END //


DELIMITER //
CREATE PROCEDURE UpdateClienteLigaFuncionario(
    IN cliente_liga_funcionario_idcliente INT,
    IN novo_idfuncionario INT
)
BEGIN
    UPDATE clientes_liga_funcionarios
    SET idfuncionario = novo_idfuncionario
    WHERE idcliente = cliente_liga_funcionario_idcliente;
END //


DELIMITER //
CREATE PROCEDURE DeleteClienteLigaFuncionario(IN cliente_liga_funcionario_idcliente INT)
BEGIN
    DELETE FROM clientes_liga_funcionarios WHERE idcliente = cliente_liga_funcionario_idcliente;
END //
DELIMITER ;