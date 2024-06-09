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
    bairro VARCHAR(50) NOT NULL
);

CREATE TABLE telefoneFuncionarios (
    idFuncionario INT NOT NULL,
    FOREIGN KEY (idFuncionario)
        REFERENCES funcionarios (id),
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

CREATE TABLE compras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dataCompra DATE NOT NULL,
    horaCompra TIME NOT NULL,
    quantidade INT NOT NULL,
    valorCompra FLOAT NOT NULL
);


CREATE TABLE  testes (
	id INT PRIMARY KEY AUTO_INCREMENT,
    dataTeste DATE NOT NULL,
    horaTeste TIME NOT NULL
);

CREATE TABLE clientes_testes (
    idcliente INT NOT NULL,
    FOREIGN KEY (idcliente)
        REFERENCES clientes (id),
    idteste INT NOT NULL,
    FOREIGN KEY (idteste)
        REFERENCES testes (id)
);

CREATE TABLE carros_testes (
    idteste INT NOT NULL,
    FOREIGN KEY (idteste)
        REFERENCES testes (id),
    idcarro INT NOT NULL,
    FOREIGN KEY (idcarro)
        REFERENCES carros (id)
);

CREATE TABLE clientes_compras (
    idcliente INT NOT NULL,
    FOREIGN KEY (idcliente)
        REFERENCES clientes (id),
    idcompra INT NOT NULL,
    FOREIGN KEY (idcompra)
        REFERENCES compras (id)
);

CREATE TABLE clientes_cartoescredito (
    numerocartao INT NOT NULL,
    FOREIGN KEY (numerocartao)
        REFERENCES cartoesCredito (numerocartao),
    idcliente INT NOT NULL,
    FOREIGN KEY (idcliente)
        REFERENCES clientes (id)
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


DELIMITER //
CREATE PROCEDURE FilterCarByColor(IN Color VARCHAR(15))
BEGIN
    SELECT id,marca,modelo,cor FROM carros WHERE cor LIKE Color; 
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE FilterCarByModel(IN Model VARCHAR(15))
BEGIN
    SELECT id,marca,modelo FROM carros WHERE modelo LIKE Model;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FilterCarByMaker(IN Maker VARCHAR(15))
BEGIN
    SELECT id,marca,modelo FROM carros WHERE marca LIKE Maker; 
END //
DELIMITER ;

-- Car procedures

DELIMITER //
CREATE PROCEDURE CreateCar(IN Marca VARCHAR(20), IN Modelo VARCHAR(20), IN AnoFabrico INT, IN Cor VARCHAR(15), IN Garantia INT, IN Preco FLOAT, IN QuantidadeDisponivel INT)
BEGIN
    INSERT INTO carros (id,marca,modelo,anoFabrico,cor,garanti,preco,quantidadeDisponivel) VALUES (DEFAULT,Marca,Modelo,AnoFabrico,Cor,Garantia,Preco,QuantidadeDisponivel);
END //
DELIMITER ;

DELIMITER //
create procedure  DeleteCar(in ID int)
BEGIN 
    delete FROM carros WHERE  id=ID;
END //
DELIMITER ;

DELIMITER //
create procedure  ReadCar(in ID int)
BEGIN 
    select * FROM carros WHERE id=ID;
END //
DELIMITER ;

DELIMITER //
create procedure  UpdateCarPrice(ID,in  price float)
BEGIN 
    update carros SET  preco = price WHERE id = ID; 
END //
DELIMITER ;

DELIMITER //
create procedure  UpdateCarFactoryYear(in ID int, in Newyear int)
BEGIN 
    update carros SET  anoFabrico=Newyear WHERE id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarColor(in ID int, in  Color VARCHAR(15))
BEGIN 
    update carros SET  cor=Color WHERE id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarMaker(in ID int, in  Maker VARCHAR(20))
BEGIN 
    update carros SET  marca=Maker WHERE id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarModel(in ID int, in  Model VARCHAR(20))
BEGIN 
    update carros SET  modelo=Model WHERE id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarWarranty(in ID int, in Warranty int)
BEGIN 
    update carros SET  garantia=Warranty WHERE id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarQuantity(in ID int, in Quantity int)
BEGIN 
    update carros SET  quantidadeDisponivel=Quantity WHERE id=ID;
END //
DELIMITER ;

-- End Car CRUD

-- Client CRUD procedures
DELIMITER //
create procedure CreateClient(in PNome VARCHAR(50),in SobreNome VARCHAR(50),IN AnoNascimento INT,IN Bairro VARCHAR(50),IN Provincia VARCHAR(20),IN cidade VARCHAR(20))
BEGIN
    INSERT INTO clientes (id,primeiroNome,sobreNome,anoNascimento,bairro,provincia,cidade) VALUES (DEFAULT,PNome,SobreNome,AnoNascimento,Bairro,Provincia,cidade);
END //
DELIMITER ;

DELEIMITER //
CREATE PROCEDURE ReadClient(IN ID INT)
BEGIN
    SELECT * FROM  clientes WHERE id=ID;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE  DeleteClient(IN ID INT)
BEGIN
    DELETE FROM  clientes WHERE  id=ID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateFirstName(IN clientID INT, IN newFirstName VARCHAR(50))
BEGIN
    UPDATE clientes
    SET  primeiroNome = newFirstName
    WHERE id = clientID;
END //
DELIMITER;

-- Procedure to update the last name of a client
DELIMITER //
CREATE PROCEDURE UpdateLastName(IN clientID INT, IN newLastName VARCHAR(50))
BEGIN
    UPDATE clientes
    SET  sobrenome = newLastName
    WHERE id = clientID;
END //
DELIMITER;

-- Procedure to update the year of birth of a client
DELIMITER //
CREATE PROCEDURE UpdateYearOfBirth(IN clientID INT, IN newYearOfBirth INT)
BEGIN
    UPDATE clientes
    SET  anoNascimento = newYearOfBirth
    WHERE id = clientID;
END //
DELIMITER;

-- Procedure to update the neighborhood of a client
DELIMITER //
CREATE PROCEDURE UpdateNeighborhood(IN clientID INT, IN newNeighborhood VARCHAR(50))
BEGIN
    UPDATE clientes
    SET  bairro = newNeighborhood
    WHERE id = clientID;
END //
DELIMITER;

-- Procedure to update the province of a client
DELIMITER //
CREATE PROCEDURE UpdateProvince(IN clientID INT, IN newProvince VARCHAR(20))
BEGIN
    UPDATE clientes
    SET  provincia = newProvince
    WHERE id = clientID;
END //
DELIMITER;

-- Procedure to update the city of a client
DELIMITER //
CREATE PROCEDURE UpdateCity(IN clientID INT, IN newCity VARCHAR(20))
BEGIN
    UPDATE clientes
    SET  cidade = newCity
    WHERE id = clientID;
END //
DELIMITER;
-- End Client CRUD procedures

-- Emplyees CRUD procedures
DELIMITER //
create procedure CreateEmployee(in PNome VARCHAR(50),in SobreNome VARCHAR(50),in AnoNascimento int,in Bairro VARCHAR(50),in Provincia VARCHAR(20),in cidade VARCHAR(20),in PhoneNumber int)
BEGIN
    declare EmployeeID int;
    insert into funcionarios  (id,primeiroNome,sobreNome,anoNascimento,bairro,provincia,cidade) values (default,PNome,SobreNome,AnoNascimento,Bairro,Provincia,cidade);
END //
DELIMITER ;

DELEIMITER //
create procedure ReadEmployee(in ID int)
BEGIN
    select * FROM funcionarios  WHERE id=ID;
END//
DELIMITER ;

DELIMITER //
create procedure DeleteEmployee(in ID int)
BEGIN
    delete FROM funcionarios  WHERE id=ID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateFirstName(IN EmployeeID INT, IN newFirstName VARCHAR(50))
BEGIN
    UPDATE funcionarios 
    SET  primeiroNome = newFirstName
    WHERE id = EmployeeID;
END //
DELIMITER ;

-- Procedure to update the last name of a Employee
DELIMITER //
CREATE PROCEDURE UpdateLastName(IN EmployeeID INT, IN newLastName VARCHAR(50))
BEGIN
    UPDATE funcionarios 
    SET  sobrenome = newLastName
    WHERE id = EmployeeID;
END //
DELIMITER ;

-- Procedure to update the neighborhood of a Employee
DELIMITER //
CREATE PROCEDURE UpdateNeighborhood(IN EmployeeID INT, IN newNeighborhood VARCHAR(50))
BEGIN
    UPDATE funcionarios 
    SET  bairro = newNeighborhood
    WHERE id = EmployeeID;
END //
DELIMITER ;

-- Procedure to update the province of a Employee
DELIMITER //
CREATE PROCEDURE UpdateProvince(IN EmployeeID INT, IN newProvince VARCHAR(20))
BEGIN
    UPDATE funcionarios 
    SET  provincia = newProvince
    WHERE id = EmployeeID;
END //
DELIMITER ;

-- Procedure to update the city of a Employee
DELIMITER //
CREATE PROCEDURE UpdateCity(IN EmployeeID INT, IN newCity VARCHAR(20))
BEGIN
    UPDATE funcionarios 
    SET  cidade = newCity
    WHERE id = EmployeeID;
END //
DELIMITER ;

-- End employees CRUD procedures

-- Credit card CRUD procedures
DELIMITER //
CREATE PROCEDURE insertTelefoneFuncionario(
    IN idFuncionarioParam INT,
    IN telefoneParam INT
)
BEGIN
    INSERT INTO telefoneFuncionarios (idFuncionario, telefone) 
    VALUES (idFuncionarioParam, telefoneParam);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE selectTelefoneFuncionario(
    IN idFuncionarioParam INT
)
BEGIN
    SELECT telefone 
    FROM telefoneFuncionarios 
    WHERE idFuncionario = idFuncionarioParam;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE updateTelefoneFuncionario(
    IN idFuncionarioParam INT,
    IN newTelefoneParam INT
)
BEGIN
    UPDATE telefoneFuncionarios 
    SET  telefone = newTelefoneParam 
    WHERE idFuncionario = idFuncionarioParam;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE deleteTelefoneFuncionario(
    IN idFuncionarioParam INT
)
BEGIN
    DELETE FROM telefoneFuncionarios 
    WHERE idFuncionario = idFuncionarioParam;
END //
DELIMITER ;

-- END credit card procedures

-- Credit card CRUD procedures
DELIMITER //

CREATE PROCEDURE InsertCartaoCredito(
    IN p_numeroCartao INT,
    IN p_dataValidade DATE,
    IN p_codigoSeguranca INT,
    IN p_idCliente INT
)
BEGIN
    INSERT INTO cartoesCredito (numeroCartao, dataValidade, codigoSeguranca, idCliente)
    VALUES (p_numeroCartao, p_dataValidade, p_codigoSeguranca, p_idCliente);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetCartaoCreditoById(
    IN p_numeroCartao INT
)
BEGIN
    SELECT * FROM cartoesCredito WHERE numeroCartao = p_numeroCartao;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateNumeroCartao(
    IN p_numeroCartao INT,
    IN p_newNumeroCartao INT
)
BEGIN
    UPDATE cartoesCredito SET  numeroCartao = p_newNumeroCartao WHERE numeroCartao = p_numeroCartao;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateDataValidade(
    IN p_numeroCartao INT,
    IN p_newDataValidade DATE
)
BEGIN
    UPDATE cartoesCredito SET  dataValidade = p_newDataValidade WHERE numeroCartao = p_numeroCartao;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateCodigoSeguranca(
    IN p_numeroCartao INT,
    IN p_newCodigoSeguranca INT
)
BEGIN
    UPDATE cartoesCredito SET  codigoSeguranca = p_newCodigoSeguranca WHERE numeroCartao = p_numeroCartao;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateIdCliente(
    IN p_numeroCartao INT,
    IN p_newIdCliente INT
)
BEGIN
    UPDATE cartoesCredito SET  idCliente = p_newIdCliente WHERE numeroCartao = p_numeroCartao;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteCartaoCredito(
    IN p_numeroCartao INT
)
BEGIN
    DELETE FROM cartoesCredito WHERE numeroCartao = p_numeroCartao;
END //

DELIMITER ;
-- END credit card CRUD

-- Shops CRUD procedure
DELIMITER //

CREATE PROCEDURE InsertCompra(
    IN pDataCompra DATE,
    IN pHoraCompra TIME,
    IN pQuantidade INT,
    IN pValorCompra FLOAT
)
BEGIN
    INSERT INTO compras (dataCompra, horaCompra, quantidade, valorCompra) 
    VALUES (pDataCompra, pHoraCompra, pQuantidade, pValorCompra);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE GetCompra(
    IN pID INT
)
BEGIN
    SELECT * FROM compras WHERE id = pID;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE UpdateDataCompra(
    IN pID INT,
    IN newDataCompra DATE
)
BEGIN
    UPDATE compras SET  dataCompra = newDataCompra WHERE id = pID;
END //

CREATE PROCEDURE UpdateHoraCompra(
    IN pID INT,
    IN newHoraCompra TIME
)
BEGIN
    UPDATE compras SET  horaCompra = newHoraCompra WHERE id = pID;
END //

CREATE PROCEDURE UpdateQuantidade(
    IN pID INT,
    IN newQuantidade INT
)
BEGIN
    UPDATE compras SET  quantidade = newQuantidade WHERE id = pID;
END //

CREATE PROCEDURE UpdateValorCompra(
    IN pID INT,
    IN newValorCompra FLOAT
)
BEGIN
    UPDATE compras SET  valorCompra = newValorCompra WHERE id = pID;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteCompra(
    IN pID INT
)
BEGIN
    DELETE FROM compras WHERE id = pID;
END //

DELIMITER ;

-- END shop CRUD procedure

-- Test CRUD procedure
DELIMITER //

CREATE PROCEDURE InsertTeste(
    IN dataTesteParam DATE,
    IN horaTesteParam TIME
)
BEGIN
    INSERT INTO testes (dataTeste, horaTeste) VALUES (dataTesteParam, horaTesteParam);
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE SelectTestes()
BEGIN
    SELECT * FROM testes;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateDataTeste(
    IN idParam INT,
    IN newDataTeste DATE
)
BEGIN
    UPDATE testes SET  dataTeste = newDataTeste WHERE id = idParam;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateHoraTeste(
    IN idParam INT,
    IN newHoraTeste TIME
)
BEGIN
    UPDATE testes SET  horaTeste = newHoraTeste WHERE id = idParam;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteTeste(
    IN idParam INT
)
BEGIN
    DELETE FROM testes WHERE id = idParam;
END//

DELIMITER ;
-- END test procedure
