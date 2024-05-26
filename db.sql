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
create procedure AddCar(in marca varchar(20), in modelo varchar(20), in anoFabrico int, in cor varchar(15), in garantia int, in preco float, in quantidadeDisponivel int)
BEGIN
    insert into carros (id,marca,modelo,anoFabrico,cor,garantiapreco,quantidadeDisponivel) values (default,marca,modelo,anoFabrico,cor,garantia,preco);
END //
DELIMITER ;

DELIMITER //
create procedure  RemoveCar(in ToDeleteId int)
BEGIN 
    delete from carros where  id=ToDeleteId;
END //
DELIMITER ;

DELIMITER //
create procedure  UpdateCar(in  name type)
BEGIN 
    
END //
DELIMITER ;


-- CRUD Procedure model
DELIMITER //
create procedure  Name(in name type)
BEGIN 

END //
DELIMITER ;

DELIMITER //
create procedure  UpdateCar(in  name type)
BEGIN 
    
END //
DELIMITER ;

-- End

DELIMITER //
create procedure  Name(in name type)
BEGIN 

END //
DELIMITER ;


