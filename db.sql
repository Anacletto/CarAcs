create database carAcsDB;

use carAcsDB;


create table  clientes (
	id int  not null unique primary key,
	primeiroNome varchar (50) not null,
    sobrenome varchar  (50) not null,
    anoNascimento int not null,
    bairro varchar  (50) not null,
    provincia varchar  (20) not null,
    cidade varchar  (20) not null
);

create table  funcionarios (
	id int  primary key not null unique,
    primeiroNome varchar (50) not null,
    sobrenome varchar  (50) not null,
    provincia varchar  (20) not null,
    cidade varchar  (20) not null,
    bairro varchar  (50) not null
    
);

create table telefoneFuncionarios(
    idFuncionario int not null,
    foreign key (idFuncionario)  references funcionarios (id),
    telefone int not null
);


create table  carros (
	id int primary key unique not null auto_increment,
    preco float not null,
    anoFabrico int not null,
    cor varchar (15) not null,
    marca varchar  (20) not null,
    modelo varchar (20) not null,
    garantia int not null,
    quantidadeDisponivel int
);

create table  cartoesCredito (
	numeroCartao int primary key unique not null,
    dataValidade date not null,
    codigoSeguranca int not null,
    idCliente int not null,
    foreign key  (idCliente)  references clientes (id)
);

create table  compras(
	id int  primary key not null unique auto_increment,
    dataCompra date not null,
    horaCompra time not null,
    quantidade int not null,
    valorCompra float not null
);


create table  testes (
	id int primary key not null unique auto_increment,
    dataTeste date not null,
    horaTeste time not null,
    idCliente int not null unique,
    foreign key (idCliente) references clientes (id),
    idCarro int not null,
    foreign key (idcarro) references carros (id)
);

create table clientes_testes(
	idcliente int not null,
    foreign key(idcliente) references clientes (id),
	idteste int not null,
    foreign key (idteste) references testes (id)
);

create table carros_testes(
	idteste int not null,
    foreign key(idteste) references testes (id),
	idcarro int not null,
    foreign key (idcarro) references carros (id)
);

create table clientes_compras(
    idcliente int not null,
    foreign key (idcliente) references  clientes (id),
	idcompra int not null,
    foreign key(idcompra) references compras (id)
);

create table clientes_cartoescredito(
	numerocartao int not null,
	foreign key(numerocartao) references cartoesCredito(numerocartao),
    idcliente int not null,
    foreign key(idcliente) references clientes (id)
);

create table clientes_liga_funcionarios(
	idfuncionario int not null,
	foreign key(idfuncionario) references funcionarios(id),
    idcliente int not null,
    foreign key(idcliente) references clientes (id)
);

-- Retorna o carro com maior preco
select id,marca,modelo,preco from carros as Car where Car.preco = (select max(preco) from carros);

-- Retorna o carro com menor preco
select id,marca,modelo,preco from carros as Car where Car.preco = (select min(preco) from carros);

-- retorna o carro mais antigo
select id,marca,modelo,anoFabrico from carros as Car  where Car.anoFabrico = (select min(anoFabrico) from carros);

-- Retorna o carro mais novo
select id,marca,modelo,anoFabrico from carros as Car  where Car.anoFabrico = (select max(anoFabrico) from carros);

-- Retorna o carro em menor quantidade
select id,marca,modelo,quantidadeDisponivel from carros as Car  where Car.quantidadeDisponivel = (select min(quantidadeDisponivel) from carros);

-- Retorna o carro em maior quantidade
select id,marca,modelo,quantidadeDisponivel from carros as Car  where Car.quantidadeDisponivel = (select max(quantidadeDisponivel) from carros);


DELIMITER //
create procedure FilterCarByColor(in Color varchar(15))
BEGIN
    select id,marca,modelo,cor from carros where cor like Color; 
END //
DELIMITER ;


DELIMITER //
create procedure FilterCarByModel(in Model varchar(15))
BEGIN
    select id,marca,modelo from carros where modelo like Model;
END //
DELIMITER ;

DELIMITER //
create procedure FilterCarByMaker(in Maker varchar(15))
BEGIN
    select id,marca,modelo from carros where marca like Maker; 
END //
DELIMITER ;

-- Car procedures

DELIMITER //
create procedure CreateCar(in Marca varchar(20), in Modelo varchar(20), in AnoFabrico int, in Cor varchar(15), in Garantia int, in Preco float, in QuantidadeDisponivel int)
BEGIN
    insert into carros (id,marca,modelo,anoFabrico,cor,garanti,preco,quantidadeDisponivel) values (default,Marca,Modelo,AnoFabrico,Cor,Garantia,Preco,);
END //
DELIMITER ;

DELIMITER //
create procedure  DeleteCar(in ID int)
BEGIN 
    delete from carros where  id=ID;
END //
DELIMITER ;

DELIMITER //
create procedure  ReadCar(in ID int)
BEGIN 
    select * from carros where id=ID;
END //
DELIMITER ;

DELIMITER //
create procedure  UpdateCarPrice(ID,in  price float)
BEGIN 
    update carros set preco = price where id = ID; 
END //
DELIMITER ;

DELIMITER //
create procedure  UpdateCarFactoryYear(in ID int, in Newyear int)
BEGIN 
    update carros set anoFabrico=Newyear where id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarColor(in ID int, in  Color varchar(15))
BEGIN 
    update carros set cor=Color where id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarMaker(in ID int, in  Maker varchar(20))
BEGIN 
    update carros set marca=Maker where id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarModel(in ID int, in  Model varchar(20))
BEGIN 
    update carros set modelo=Model where id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarWarranty(in ID int, in Warranty int)
BEGIN 
    update carros set garantia=Warranty where id=ID;
END //
DELIMITER ;


DELIMITER //
create procedure  UpdateCarQuantity(in ID int, in Quantity int)
BEGIN 
    update carros set quantidadeDisponivel=Quantity where id=ID;
END //
DELIMITER ;

-- End Car CRUD

-- Client CRUD procedures
DELIMITER //
create procedure CreateClient(in PNome varchar(50),in SobreNome varchar(50),in AnoNascimento int,in Bairro varchar(50),in Provincia varchar(20),in cidade varchar(20))
BEGIN
    insert into clientes (id,primeiroNome,sobreNome,anoNascimento,bairro,provincia,cidade) values (default,PNome,SobreNome,AnoNascimento,Bairro,Provincia,cidade);
END //
DELIMITER ;

DELEIMITER //
create procedure ReadClient(in ID int)
BEGIN
    select * from clientes where id=ID;
END//
DELIMITER ;

DELIMITER //
create procedure DeleteClient(in ID int)
BEGIN
    delete from clientes where id=ID;
END //
DELIMITER ;

CREATE PROCEDURE UpdateFirstName(IN clientID INT, IN newFirstName VARCHAR(50))
BEGIN
    UPDATE clientes
    SET primeiroNome = newFirstName
    WHERE id = clientID;
END;

-- Procedure to update the last name of a client
CREATE PROCEDURE UpdateLastName(IN clientID INT, IN newLastName VARCHAR(50))
BEGIN
    UPDATE clientes
    SET sobrenome = newLastName
    WHERE id = clientID;
END;

-- Procedure to update the year of birth of a client
CREATE PROCEDURE UpdateYearOfBirth(IN clientID INT, IN newYearOfBirth INT)
BEGIN
    UPDATE clientes
    SET anoNascimento = newYearOfBirth
    WHERE id = clientID;
END;

-- Procedure to update the neighborhood of a client
CREATE PROCEDURE UpdateNeighborhood(IN clientID INT, IN newNeighborhood VARCHAR(50))
BEGIN
    UPDATE clientes
    SET bairro = newNeighborhood
    WHERE id = clientID;
END;

-- Procedure to update the province of a client
CREATE PROCEDURE UpdateProvince(IN clientID INT, IN newProvince VARCHAR(20))
BEGIN
    UPDATE clientes
    SET provincia = newProvince
    WHERE id = clientID;
END;

-- Procedure to update the city of a client
CREATE PROCEDURE UpdateCity(IN clientID INT, IN newCity VARCHAR(20))
BEGIN
    UPDATE clientes
    SET cidade = newCity
    WHERE id = clientID;
END;
-- End Client CRUD procedures

-- Emplyees CRUD procedures
DELIMITER //
create procedure CreateEmployee(in PNome varchar(50),in SobreNome varchar(50),in AnoNascimento int,in Bairro varchar(50),in Provincia varchar(20),in cidade varchar(20))
BEGIN
    insert into funcionarios  (id,primeiroNome,sobreNome,anoNascimento,bairro,provincia,cidade) values (default,PNome,SobreNome,AnoNascimento,Bairro,Provincia,cidade);
END //
DELIMITER ;

DELEIMITER //
create procedure ReadEmployee(in ID int)
BEGIN
    select * from funcionarios  where id=ID;
END//
DELIMITER ;

DELIMITER //
create procedure DeleteEmployee(in ID int)
BEGIN
    delete from funcionarios  where id=ID;
END //
DELIMITER ;

CREATE PROCEDURE UpdateFirstName(IN EmployeeID INT, IN newFirstName VARCHAR(50))
BEGIN
    UPDATE funcionarios 
    SET primeiroNome = newFirstName
    WHERE id = EmployeeID;
END;

-- Procedure to update the last name of a Employee
CREATE PROCEDURE UpdateLastName(IN EmployeeID INT, IN newLastName VARCHAR(50))
BEGIN
    UPDATE funcionarios 
    SET sobrenome = newLastName
    WHERE id = EmployeeID;
END;

-- Procedure to update the neighborhood of a Employee
CREATE PROCEDURE UpdateNeighborhood(IN EmployeeID INT, IN newNeighborhood VARCHAR(50))
BEGIN
    UPDATE funcionarios 
    SET bairro = newNeighborhood
    WHERE id = EmployeeID;
END;

-- Procedure to update the province of a Employee
CREATE PROCEDURE UpdateProvince(IN EmployeeID INT, IN newProvince VARCHAR(20))
BEGIN
    UPDATE funcionarios 
    SET provincia = newProvince
    WHERE id = EmployeeID;
END;

-- Procedure to update the city of a Employee
CREATE PROCEDURE UpdateCity(IN EmployeeID INT, IN newCity VARCHAR(20))
BEGIN
    UPDATE funcionarios 
    SET cidade = newCity
    WHERE id = EmployeeID;
END;
-- End employees CRUD pricedures

-- CRUD procedure 

-- CRUD Procedure model
DELIMITER //
create procedure  Name(in name type)
BEGIN 

END //
DELIMITER ;

DELIMITER //
create procedure  Update(in ID int, in  name type)
BEGIN 
    update - set -=- where id=ID;
END //
DELIMITER ;

-- End


