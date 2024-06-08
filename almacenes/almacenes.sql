--Borrado de las Tablas

drop table if exists PREMIOS;
drop table if exists ATENCIONES;
drop table if exists PAGOS;
drop table if exists COMPRAS;
drop table if exists SURTIDOS;
drop table if exists VENTAS;
drop table if exists CAJERO;
drop table if exists CAJA;
drop table if exists ARTICULO;
drop table if exists CREDITO;
drop table if exists PEDIDOS;
drop table if exists TARJETA_PREMIOS;
drop table if exists VENDEDOR;
drop table if exists DEPARTAMENTO;
drop table if exists AREA_VENTA;
drop table if exists PROVEEDOR;
drop table if exists CLIENTE;
drop table if exists MERCADERISTA;
drop table if exists SUCURSAL;

--Creación de las Tablas

create table SUCURSAL(
Codigo_Suc numeric(8) constraint pk_sucursal primary key,--Código de la Sucursal
Ubicacion varchar(20) constraint nn_sucursal not null,--Ubicacion de la Sucursal
Ciudad varchar(20) constraint nn2_sucursal not null--Ciudad de la Sucursal
);

create table MERCADERISTA(
Cod_Merc numeric(8) constraint pk_mercaderista primary key,--Código de Mercaderista
Nom_Merc varchar(30) constraint nn_mercaderista not null,--Nombre de Mercaderista
Fecha_Nac_Merc date,--Fecha de Nacimiento de Mercaderista
Telefono varchar(20),--Teléfono del Mercaderista
Gen_Mercaderista varchar(15)--Género del Mercaderista
);

create table CLIENTE(
Cod_Cli numeric(8) constraint pk_cliente primary key,--Código del Cliente
Nombre_Cli varchar(30) constraint nn_cliente not null,--Nombre del Cliente
Telefono varchar(20),--Teléfono de Cliente
Fecha_Nac_Cli date --Fecha Nacimiento de Cliente
);

create table PROVEEDOR(
Codigo  numeric(8) constraint pk_proveedor primary key,--Código de Proveedor
Nombre varchar(30) constraint nn_proveedor not null constraint un_proveedor unique,-- Nombre del Proveedor
Telefono varchar(15),--Teléfono del proveedor
Ciudad varchar(15) --Ciudad del Proveedor
);

create table AREA_VENTA(
Cod_Area numeric(8) constraint pk_area  primary key,--Código del Área de Venta
Nom_Area varchar(30) constraint nn_area not null,--Nombre del Área de Venta
Ubicacion_Area varchar(20)--Ubicacion del Área de Venta
);

create table DEPARTAMENTO(
Codigo numeric(8) constraint pk_seccion  primary key,--Código del Departamento
Nombre varchar(30),--Nombre del Departamento
Cod_Area numeric(8),--Código del Área de venta
constraint fk_seccion foreign key(cod_area) references area_venta(cod_area) on delete cascade
);

create table VENDEDOR(
Cod_Vend numeric(8) constraint pk_vendedor primary key, --Código del Vendedor
Nom_Vend varchar(30) constraint nn_vendedor not null,--Nombre del Vendedor
Fecha_Nac_Vend date,--Fecha Nacimiento del Vendedor
Salario numeric(6),--Salario del Vendedor
Cod_Suc numeric(8),--Código de Sucursal
constraint fk_vendedor foreign key(cod_suc) references sucursal(codigo_suc) on delete cascade
);

create table TARJETA_PREMIOS(
Cod_Tarjeta numeric(8) constraint pk_tarjeta_premios primary key,--Código de la Tarjeta de Premios
Nombre varchar(30) constraint nn_tarjeta_premios not null--Nombre de la Tarjeta de Premios
);

create table PEDIDOS(
Num_Pedido numeric(8) constraint pk_pedidos primary key,--Número del Pedido
Tipo varchar(20) constraint nn_pedidos not null,--Tipo del Pedido
Fecha_Entrega_Pedido date,--Fecha de Entrega del Pedido
Valor_Domicilio numeric(8),--Valor del domicilio del Pedido
Cod_Cli numeric(8),--Código del Cliente
constraint fk_pedidos foreign key(cod_cli) references cliente(cod_cli) on delete cascade
);

create table CREDITO(
Codigo numeric(8) constraint pk_credito primary key,--Código del Cliente
Fecha_Realiza_Credito date,--Fecha del Crédito
Fecha_Pago_Credito date,--Fecha de Pago
Valor numeric(10),--Valor del Crédito
Cod_Cli numeric(8),--Código del Cliente
constraint fk_credito foreign key(cod_cli) references cliente(cod_cli) on delete cascade
);

create table ARTICULO(
Codigo numeric(8) constraint pk_articulo primary key,--Código del Árticulo
Nombre varchar(30) constraint nn_articulo not null,--Nombre del Ártículo
Stock_Articulo numeric(6), --Stock del Ártículo
Precio_Unitario_Art numeric(6),--Precio del Artículo por unidad
Cod_Merc numeric(8),--Código del Mercaderista
constraint fk1_articulo foreign key(cod_merc) references mercaderista(cod_merc) on delete cascade,
Cod_Dpto numeric(8),--Código del Departamento
constraint fk2_articulo foreign key(cod_dpto) references departamento(codigo) on delete cascade
);

create table CAJA(
Cod_Caja numeric(8) constraint pk_caja primary key, --Código de la Caja
Ubicacion varchar(20) constraint nn_caja not null --Ubicacion de la Caja
);

create table CAJERO(
Cod_Cajero numeric(8) constraint pk_cajero primary key,--Código del Cajero
Nom_Cajero varchar(30) constraint nn_cajero not null,--Nombre del Cajero
Genero_Cajero varchar(15),--Género del Cajero
Fecha_Nac_Cajero date--Fecha de Nacimiento del Cajero
);

create table VENTAS(
Codigo numeric(8) constraint pk_venta primary key,--Código de la venta
Cod_Vendedor numeric(8),--Código del Vendedor
constraint fk_vende foreign key(cod_vendedor) references vendedor(cod_vend) on delete cascade,
Cod_Articulo numeric(8),--Código del Artículo
constraint fk2_vende foreign key(cod_articulo) references articulo(codigo) on delete cascade,
Nro_Artic_Vendidos numeric(6),--Número de Artículos Vendidos
Fecha_Venta date--Fecha de la Venta
);

create table SURTIDOS(
Num_Surtido numeric(8) constraint pk_surtidos primary key,--Número de Surtido
Cod_Prov numeric(8),--Código del Proveedor
constraint fk_surtidos foreign key(cod_prov) references proveedor(codigo) on delete cascade,
Cod_Articulo numeric(8),--Código del Artículo
constraint fk2_surtidos foreign key(cod_articulo) references articulo(codigo) on delete cascade,
Fecha_Surtido date,--Fecha del Surtido
Nro_Artic_Surt numeric(6)--Número de Artículos Surtidos
);

create table COMPRAS(
Numero numeric(8) constraint pk_compras primary key,--Número de la Compra
Cod_Cli numeric(8),--Código del Cliente
constraint fk_compras foreign key(cod_cli) references cliente(cod_cli) on delete cascade,
Cod_Articulo numeric(8),--Código del´Artículo
constraint fk2_compras foreign key(cod_articulo) references articulo(codigo) on delete cascade,
Nro_Artic_Comprados numeric(6),--Número de Artículos Comprados
Fecha_Compra date--Fecha de la Compra
);

create table PAGOS(
Num_Pago numeric(8) constraint pk_pago primary key,--Número del Pago
Cod_Cliente numeric(8),--Código del Cliente
constraint fk_pago foreign key(cod_cliente) references cliente(cod_cli) on delete cascade,
Cod_Caja numeric(8),--Código de la Caja
constraint fk2_pago foreign key(cod_caja) references caja(cod_caja) on delete cascade,
Fecha_Pago date,--Fecha del Pago
Hora_Pago date--Hora del Pago
);

create table ATENCIONES(
Num_Atencion numeric(8) constraint pk_atenciones primary key,--Número de la Atención
Cod_Cajero numeric(8),--Código del Cajero
constraint fk_atenciones foreign key(cod_cajero) references cajero(cod_cajero) on delete cascade,
Cod_Caja numeric(8),--Código de la Caja
constraint fk2_atenciones foreign key(cod_caja) references caja(cod_caja) on delete cascade,
Fecha_Atencion date--Fecha de la Atención
);

create table PREMIOS(
Numero numeric(8) constraint pk_premios primary key,--Número del Premio
Cod_Cli numeric(8),--Código del Cliente
constraint fk_premios foreign key(cod_cli) references cliente(cod_cli) on delete cascade,
Cod_Tarj numeric(8),--Código de la tarjeta de premio
constraint fk2_premios foreign key(cod_tarj) references tarjeta_premios(cod_tarjeta) on delete cascade,
Fecha_Premio date,--Fecha en que se Ganó el Premio
Descripcion_Premio varchar(30)--Descripción del Premio
);

--Inserción de las tuplas

insert into sucursal values (1,'la 40', 'barranquilla');
insert into sucursal values (2,'las americas', 'bogota');
insert into sucursal values (3,'los heroes', 'bogota');
insert into sucursal values (4,'portal del norte', 'bogota');
insert into sucursal values (5,'galerias', 'bogota');
insert into sucursal values (6,'el laguito', 'cartagena');
insert into sucursal values (7,'buenavista', 'barranquilla');
insert into sucursal values (8,'avenida murillo', 'barranquilla');
insert into sucursal values (9,'centro', 'cartagena');
insert into sucursal values (10,'la flora', 'bucaramanga');
insert into sucursal values (11,'cabecera', 'bucaramanga');
insert into sucursal values (12,'cañaveral', 'floridablanca');
insert into sucursal values (13,'parque principal', 'giron');
insert into sucursal values (14,'fontibon', 'bogota');
insert into sucursal values (15,'avenida la 14', 'cali');
insert into sucursal values (16,'ciudadela cuba', 'pereira');
insert into sucursal values (17,'avenida quinta', 'santa marta');
insert into sucursal values (18,'centro chia', 'chia');
insert into sucursal values (19,'el poblado', 'giron');
insert into sucursal values (20,'lagos', 'floridablanca');
insert into sucursal values (21,'portal la 80', 'bogota');
insert into sucursal values (22,'suba', 'bogota');
insert into sucursal values (23,'boyaca con 68', 'bogota');
insert into sucursal values (24,'parque la 93', 'bogota');
insert into sucursal values (25,'megamall', 'bucaramanga');
insert into sucursal values (26,'parque principal', 'piedecuesta');
insert into sucursal values (27,'centro', 'bucaramanga');
insert into sucursal values (28,'el poblado', 'medellin');
insert into sucursal values (29,'el tesoro', 'medellin');
insert into sucursal values (30,'el contento', 'cucuta');
insert into sucursal values (31,'los pinos', 'cucuta');
insert into sucursal values (32,'centro', 'cucuta');
insert into sucursal values (33,'bocagrande', 'cartagena');
insert into sucursal values (34,'crespo', 'cartagena');
insert into sucursal values (35,'manga', 'cartagena');
insert into sucursal values (36,'san luis', 'cucuta');
insert into sucursal values (37,'la playa', 'santa marta');
insert into sucursal values (38,'unicentro', 'bogota');
insert into sucursal values (39,'rincon', 'giron');
insert into sucursal values (40,'altos de cañaveral', 'floridablanca');
insert into sucursal values (41,'centro sur', 'bogota');
insert into sucursal values (42,'usaquen', 'bogota');
insert into sucursal values (43,'banderas', 'bogota');
insert into sucursal values (44,'parque el virey', 'bogota');
insert into sucursal values (45,'megacentro', 'bucaramanga');
insert into sucursal values (46,'san francisco', 'piedecuesta');
insert into sucursal values (47,'la quinta', 'bucaramanga');
insert into sucursal values (48,'robledo', 'medellin');
insert into sucursal values (49,'pies descalzos', 'medellin');
insert into sucursal values (50,'la septima', 'cucuta');
insert into sucursal values (51,'avenida cero', 'cucuta');
insert into sucursal values (52,'centro', 'pereira');
insert into sucursal values (53,'avenida san martin', 'cartagena');
insert into sucursal values (54,'avenida santander', 'cartagena');
insert into sucursal values (55,'bazurto', 'cartagena');
insert into sucursal values (56,'el malecon', 'cucuta');
insert into sucursal values (57,'estadio', 'santa marta');
insert into sucursal values (58,'centro', 'cajica');
insert into sucursal values (59,'carrizal', 'giron');
insert into sucursal values (60,'bucarica', 'floridablanca');

insert into mercaderista values (3,'ANA','11/11/1991','6769988','f');
insert into mercaderista values (8,'rOSIta','26/07/1991','6884448','f');
insert into mercaderista values (9,'alberTO','22/09/1977','6779444','m');
insert into mercaderista values (10,'VIviana','21/09/1991','6769988','f');
insert into mercaderista values (4,'MaRtha','15/12/1985','6555323','f');
insert into mercaderista values (5,'luisa','18/10/1978','6932344','f');
insert into mercaderista values (6,'hILDa','24/12/1989','6943434','f');
insert into mercaderista values (7,'Maria','28/05/1990','6339988','f');
insert into mercaderista values (1,'Juan','01/05/1988','6559988','m');
insert into mercaderista values (2,'luisa','22/04/1989','6669988','f');
insert into mercaderista values (13,'AdriANA','11/10/1988','6769008','f');
insert into mercaderista values (18,'aaron','24/03/1989','6884998','m');
insert into mercaderista values (19,'adrian','22/09/1987','6779884','m');
insert into mercaderista values (20,'vicky','21/09/1981','6769778','f');
insert into mercaderista values (14,'magda','15/12/1988','6556623','f');
insert into mercaderista values (15,'luis','18/10/1979','6932554','m');
insert into mercaderista values (16,'hector','24/10/1989','6943444','m');
insert into mercaderista values (17,'marcolino','18/07/1990','6339338','m');
insert into mercaderista values (11,'juana','11/03/1988','6559922','f');
insert into mercaderista values (12,'fidelina','12/02/1989','6669911','f');
insert into mercaderista values (51,'juanita','01/05/1980','6551188','f');
insert into mercaderista values (52,'luisa','11/04/1989','6662288','f');
insert into mercaderista values (43,'ariana','11/11/1988','6223008','f');
insert into mercaderista values (48,'andres','24/12/1989','6444998','m');
insert into mercaderista values (49,'adriano','13/09/1987','6559884','m');
insert into mercaderista values (40,'victoria','25/09/1981','6769766','f');
insert into mercaderista values (34,'vanesa','30/12/1988','6557723','f');
insert into mercaderista values (35,'luisito','17/10/1979','6938854','m');
insert into mercaderista values (26,'hermelindo','22/10/1989','6943674','m');
insert into mercaderista values (27,'marc','15/07/1990','6385338','m');
insert into mercaderista values (23,'juaco','11/07/1988','6559342','m');
insert into mercaderista values (21,'fidel','12/09/1989','6569911','m');

insert into cliente values (115,'pablo',null,null);
insert into cliente values (116,'renne','6117788','12/03/1966');
insert into cliente values (123,'ivan',null,'23/05/1977');
insert into cliente values (124,'dario','6788889','24/08/1988');
insert into cliente values (125,'esau',null,'25/09/1976');
insert into cliente values (126,'liseth','6900990',null);
insert into cliente values (127,'lola','6543456','01/11/1965');
insert into cliente values (128,'hernando',null,'11/09/1964');
insert into cliente values (129,'adrian',null,'22/10/1955');
insert into cliente values (117,'rita','6446333','23/09/1956');
insert into cliente values (118,'lina','6333444',null);
insert into cliente values (119,'jose',null,'12/01/1954');
insert into cliente values (120,'pedro',null,'18/12/1957');
insert into cliente values (121,'alberto','6543266','21/05/1960');
insert into cliente values (122,'ismael','6555556','19/04/1988');
insert into cliente values (111,'pedro','6543210','21/03/1945');
insert into cliente values (112,'alvaro','6333344','24/09/1965');
insert into cliente values (113,'luis','6445566','21/08/1986');
insert into cliente values (114,'sara','6778866','21/09/1983');
insert into cliente values (130,'henry','6534511','24/07/1981');
insert into cliente values (110,'libardo','6788889','21/12/1983');
insert into cliente values (109,'rosario','6943212','24/12/1980');
insert into cliente values (108,'edna','6119900','21/06/1989');
insert into cliente values (104,'hernan','6224167','16/06/1967');
insert into cliente values (105,'adriana','6544211','24/07/1969');
insert into cliente values (106,'hector','6555665','21/07/1961');
insert into cliente values (101,'rosalba','6113212','16/04/1951');
insert into cliente values (102,'edgar','6112220','24/04/1951');
insert into cliente values (103,'ever','6224222','16/12/1982');
insert into cliente values (107,'diana','6334411','16/04/1971');
insert into cliente values (228,'hernan','65445467','11/09/1954');
insert into cliente values (229,'adriana','6534352','25/10/1965');
insert into cliente values (317,'ricardo','6126333','26/09/1986');
insert into cliente values (518,'luna','6332144','16/01/1958');
insert into cliente values (319,'josefa','6532666','13/01/1984');
insert into cliente values (520,'peter','6554366','13/12/1977');
insert into cliente values (521,'albert','6545466','21/05/1970');
insert into cliente values (422,'ismau','6556556','13/04/1978');
insert into cliente values (511,'edgar','6547610','21/03/1965');
insert into cliente values (512,'alvaro','6338744','24/09/1965');
insert into cliente values (213,'luisita','6498566','21/08/1966');
insert into cliente values (414,'sarina','6779966','21/09/1986');
insert into cliente values (530,'henry',null,'24/07/1987');
insert into cliente values (510,'livio','6788779','21/12/1987');
insert into cliente values (909,'rosa','6943662','24/12/1987');
insert into cliente values (808,'ermel',null,'21/06/1987');
insert into cliente values (804,'hernyojenes',null,'15/06/1967');
insert into cliente values (805,'abatisto','6543311','25/07/1979');
insert into cliente values (706,'redt',null,'21/07/1968');
insert into cliente values (701,'romelio',null,'15/04/1958');

insert into proveedor values (777,'textiles la y','6522224','bucaramanga');
insert into proveedor values (888,'el lector','6323232','bucaramanga');
insert into proveedor values (111,'digital','6542443','cali');
insert into proveedor values (123,'el sol','6544433','cali');
insert into proveedor values (235,'el portal','6543554','pereira');
insert into proveedor values (634,'de todito','6657664','bucaramanga');
insert into proveedor values (342,'credital','6546775','bucaramanga');
insert into proveedor values (345,'carnes y mas','6588789','cali');
insert into proveedor values (454,'lecherias','6993456','bogota');
insert into proveedor values (555,'soni','6543444','pereira');
insert into proveedor values (666,'computv','6657444','bucaramanga');
insert into proveedor values (222,'shorts','6546655','bucaramanga');
insert into proveedor values (333,'carnicos','6543789','cali');
insert into proveedor values (444,'lacteos uno a','6843456','bogota');
insert into proveedor values (727,'textiles aqui','6521124','bucaramanga');
insert into proveedor values (828,'el libro','6323122','bucaramanga');
insert into proveedor values (131,'digitales','6523443','cali');
insert into proveedor values (133,'el porrazo','6534433','cali');
insert into proveedor values (233,'la casa','6545554','pereira');
insert into proveedor values (644,'miscelania uno','6655664','bucaramanga');
insert into proveedor values (442,'creditotal','6546675','bucaramanga');
insert into proveedor values (445,'carnitas','6578789','cali');
insert into proveedor values (854,'lecheyogurth','6989456','bogota');
insert into proveedor values (855,'sonidos y mas','6590444','pereira');
insert into proveedor values (766,'compusonido','6650944','bucaramanga');
insert into proveedor values (722,'shorts tim','6548755','bucaramanga');
insert into proveedor values (733,'carnes dulces','6763789','cali');
insert into proveedor values (654,'lacteos lecheros','6864456','bogota');

insert into area_venta values (123, 'tecnologia','primer piso');
insert into area_venta values (128, 'aseo casa','avenida');
insert into area_venta values (129, 'aseo personal','primer piso');
insert into area_venta values (130, 'carnes','segundo piso');
insert into area_venta values (131, 'variedades','primer piso');
insert into area_venta values (124, 'alimentos','puerta principal');
insert into area_venta values (121, 'lacteos','primer piso');
insert into area_venta values (122, 'ropa y confecciones','segundo piso');
insert into area_venta values (125, 'educacion','sotano');
insert into area_venta values (126, 'papeleria','entrada avenida');
insert into area_venta values (127, 'comestibles','entrada avenida');

insert into departamento values (11,'quesos',121);
insert into departamento values (12,'yogures y kumis',121);
insert into departamento values (13,'frutas',124);
insert into departamento values (14,'verduras',124);
insert into departamento values (15,'granos',124);
insert into departamento values (16,'aceites',124);
insert into departamento values (17,'enlatados',124);
insert into departamento values (39,'carne res',130);
insert into departamento values (40,'pescado',130);
insert into departamento values (41,'carne cerdo',130);
insert into departamento values (42,'aves',130);
insert into departamento values (19,'carnes frias',130);
insert into departamento values (20,'textos y cuadernos',125);
insert into departamento values (21,'bebidas',127);
insert into departamento values (22,'galletas',127);
insert into departamento values (23,'jugos',127);
insert into departamento values (24, 'dulces',127);
insert into departamento values (25,'desinfectantes',128);
insert into departamento values (26,'jabon lavar',128);
insert into departamento values (27,'jabones',129);
insert into departamento values (28,'cremas',129);
insert into departamento values (29,'desodorantes',129);
insert into departamento values (30,'perfumes',129);
insert into departamento values (31,'televisores',123);
insert into departamento values (32,'equipos',123);
insert into departamento values (33,'computadores',123);
insert into departamento values (34,'celulares',123);
insert into departamento values (35,'camisas',122);
insert into departamento values (36,'pantalones',122);
insert into departamento values (37,'ropa interior',122);
insert into departamento values (38,'ropa cama',122);
 
insert into vendedor values (28,'ricardo','10/11/1970',10000,8);
insert into vendedor values (29,'alba','16/10/1977',13000,8);
insert into vendedor values (30,'myrian','23/09/1967',12000,22);
insert into vendedor values (1,'marina','8/11/1968',12000,23);
insert into vendedor values (2,'maria','06/04/1965',13000,24);
insert into vendedor values (3,'adela','24/02/1963',11000,26);
insert into vendedor values (4,'marcos','27/04/1963',10000,47);
insert into vendedor values (5,'beny','25/12/1976',12000,48);
insert into vendedor values (6,'martin','26/07/1963',15000,15);
insert into vendedor values (7,'abel','21/11/1977',10000,22);
insert into vendedor values (8,'rosario','07/09/1960',9000,22);
insert into vendedor values (9,'reinaldo','04/08/1971',8000,33);
insert into vendedor values (10,'luz','14/10/1988',11000,32);
insert into vendedor values (11,'fabio','13/12/1966',12000,36);
insert into vendedor values (12,'martha','18/08/1968',13000,29);
insert into vendedor values (13,'ramon','16/11/1972',12000,52);
insert into vendedor values (14,'alvaro','19/10/1967',11000,51);
insert into vendedor values (15,'mauro','22/09/1967',12000,32);
insert into vendedor values (16,'marina','08/10/1968',11000,24);
insert into vendedor values (17,'martin','05/05/1975',9000,22);
insert into vendedor values (18,'adela','27/08/1966',16000,16);
insert into vendedor values (19,'lola','28/07/1969',19000,3);
insert into vendedor values (20,'beto','24/12/1972',18000,55);
insert into vendedor values (21,'yesid','23/04/1969',14000,5);
insert into vendedor values (22,'helda','11/11/1972',10000,7);
insert into vendedor values (23,'rosa','07/09/1969',9000,8);
insert into vendedor values (24,'reyo','14/04/1959',8000,4);
insert into vendedor values (25,'amparo','14/11/1978',8600,7);
insert into vendedor values (26,'fabio','03/11/1976',9000,8);
insert into vendedor values (27,'diana','08/07/1966',8000,9);
insert into vendedor values (78,'rosmary','17/09/1960',9000,52);
insert into vendedor values (79,'ret','24/08/1971',8000,53);
insert into vendedor values (80,'luz aida','24/10/1988',11000,52);
insert into vendedor values (31,'fabiola','13/02/1966',12000,56);
insert into vendedor values (32,'martha','18/02/1968',13000,59);
insert into vendedor values (33,'ramona','16/12/1972',12000,42);
insert into vendedor values (34,'alvarito','19/11/1967',11000,41);
insert into vendedor values (35,'mauricio','22/09/1967',12000,52);
insert into vendedor values (36,'mary','08/10/1969',11000,54);
insert into vendedor values (37,'martin elias','05/05/1970',9000,52);
insert into vendedor values (38,'adelfo','24/08/1966',16000,56);
insert into vendedor values (39,'eloisa','27/07/1969',19000,23);
insert into vendedor values (40,'betin','24/10/1972',18000,5);
insert into vendedor values (41,'yesid','23/04/1979',14000,15);
insert into vendedor values (42,'helda','11/11/1977',10000,17);
insert into vendedor values (43,'rosaura','07/09/1979',9000,48);
insert into vendedor values (44,'rey rey','14/04/1969',8000,34);
insert into vendedor values (45,'adriana','14/11/1979',8600,57);

insert into tarjeta_premios values (431,'gold');
insert into tarjeta_premios values (432,'platino');
insert into tarjeta_premios values (433,'premium');
insert into tarjeta_premios values (434,'estandar');
insert into tarjeta_premios values (435,'puntos');

insert into pedidos values (1, 'ropa', '12/01/2015', 3700, 121);
insert into pedidos values (2, 'alimentos', '14/01/2015', 2000, 111);
insert into pedidos values (3, 'ropa', '24/02/2018', 3700, 105);
insert into pedidos values (4, 'tecnologia', '28/01/2018', 2000, 121);
insert into pedidos values (5, 'ropa', '14/03/2018', 3700, 109);
insert into pedidos values (6, 'alimentos', '12/12/2017', 6500, 108);
insert into pedidos values (7, 'ropa', '21/03/2015', 6500, 105);
insert into pedidos values (8, 'alimentos', '22/07/2017', 2700, 112);
insert into pedidos values (9, 'alimentos', '24/12/2017', 2700, 113);
insert into pedidos values (10, 'alimentos', '25/07/2019', 2000, 114);
insert into pedidos values (11, 'ropa', '28/12/2017', 2700, 113);
insert into pedidos values (12, 'tecnologia', '21/12/2017', 2700, 118);
insert into pedidos values (13, 'alimentos', '20/07/2017', 2000, 112);
insert into pedidos values (14, 'alimentos', '20/03/2015', 2000, 213);
insert into pedidos values (15, 'ropa', '14/03/2018', 2700, 213);
insert into pedidos values (16, 'alimentos', '24/03/2018', 3000, 228);
insert into pedidos values (17, 'aseo', '14/12/2019', 2700, 229);
insert into pedidos values (18, 'ropa', '14/12/2017', 3000, 317);
insert into pedidos values (19, 'tecnologia', '04/07/2019', 2000, 319);
insert into pedidos values (20, 'alimentos', '21/07/2019', 3000, 317);
insert into pedidos values (21, 'libros', '11/12/2017', 3000, 414);
insert into pedidos values (22, 'libros', '11/03/2018', 3000, 422);
insert into pedidos values (23, 'alimentos', '23/07/2017', 2000, 414);
insert into pedidos values (24, 'libros', '29/03/2018', 2800, 422);
insert into pedidos values (25, 'tecnologia', '28/03/2015', 2600, 414);
insert into pedidos values (26, 'alimentos', '27/07/2017', 2600, 512);
insert into pedidos values (27, 'libros', '27/03/2015', 2500, 510);
insert into pedidos values (28, 'libros', '17/08/2017', 2000, 512);
insert into pedidos values (29, 'aseo', '18/03/2018', 3400, 804);
insert into pedidos values (30, 'libros', '12/08/2017', 6500, 808);
insert into pedidos values (31, 'ropa', '17/08/2019', 5500, 805);
insert into pedidos values (32, 'alimentos', '24/01/2018', 4400, 111);
insert into pedidos values (33, 'tecnologia', '22/08/2017', 4400, 101);
insert into pedidos values (34, 'alimentos', '23/12/2017', 2700, 127);
insert into pedidos values (35, 'alimentos', '24/03/2018', 2300, 126);
insert into pedidos values (36, 'tecnologia', '23/08/2017', 3700, 123);
insert into pedidos values (37, 'alimentos', '21/03/2018', 3300, 124);
insert into pedidos values (38, 'alimentos', '20/09/2019', 4400, 119);
insert into pedidos values (39, 'tecnologia', '20/03/2018', 2400, 117);
insert into pedidos values (40, 'tecnologia', '10/09/2019', 2800, 114);
insert into pedidos values (41, 'aseo', '10/03/2018', 2300, 521);
insert into pedidos values (42, 'alimentos', '02/09/2017', 2700, 521);
insert into pedidos values (43, 'alimentos', '01/10/2017', 2600, 520);
insert into pedidos values (44, 'alimentos', '07/09/2017', 6000, 518);
insert into pedidos values (45, 'aseo', '06/03/2018', 6000, 114);
insert into pedidos values (46, 'alimentos', '12/11/2017', 6000, 116);
insert into pedidos values (47, 'aseo', '09/11/2019', 4000, 116);
insert into pedidos values (48, 'alimentos', '04/03/2015', 4000, 110);
insert into pedidos values (49, 'alimentos', '14/03/2015', 2000, 122);
insert into pedidos values (50, 'aseo', '11/10/2017', 2000, 706);
insert into pedidos values (51, 'alimentos', '15/03/2018', 2000, 706);
insert into pedidos values (52, 'aseo', '10/10/2017', 3000, 701);

insert into credito values (19,'25/08/2017','30/08/2017',4000,105);
insert into credito values (20,'28/06/2019','28/07/2019',9000,107);
insert into credito values (9,'18/12/2017','30/12/2017',8765,112);
insert into credito values (10,'08/03/2018','30/03/2018',7687,113);
insert into credito values (11,'06/01/2015','30/03/2015',9800,114);
insert into credito values (12,'27/07/2017','30/08/2017',4000,115);
insert into credito values (1,'03/05/2017','25/05/2017',4000,116);
insert into credito values (2,'06/01/2018','24/01/2018',5600,127);
insert into credito values (3,'08/09/2019','30/09/2019',4569,123);
insert into credito values (4,'22/06/2017','27/07/2017',8765,124);
insert into credito values (5,'11/03/2017','30/05/2017',6565,117);
insert into credito values (6,'11/02/2018','20/03/2018',3900,119);
insert into credito values (13,'28/08/2017','28/09/2017',9000,130);
insert into credito values (14,'22/10/2017','28/11/2017',5678,127);
insert into credito values (15,'17/08/2019','30/12/2019',4567,103);
insert into credito values (16,'19/07/2019','30/08/2019',8765,106);
insert into credito values (7,'22/11/2017','28/11/2017',5678,129);
insert into credito values (8,'17/11/2017','30/12/2017',4567,111);
insert into credito values (17,'28/03/2015','30/03/2015',7687,109);
insert into credito values (18,'26/06/2017','30/07/2017',9800,106);

insert into articulo values (20,'carne para asar',54,1000,5,39);
insert into articulo values (21,'yogurt saw',44,900,7,12);
insert into articulo values (22,'medias dama',123,500,9,37);
insert into articulo values (23,'agenda personal',60,7000,10,20);
insert into articulo values (24,'bocadillos ads',55,800,10,24);
insert into articulo values (25,'dulces margot',134,400,9,24);
insert into articulo values (26,'yogurt wer',345,890,6,12);
insert into articulo values (27,'camisa ttts',70,3500,4,35);
insert into articulo values (28,'jabon barra ass',32,1200,4,26);
insert into articulo values (29,'jabon polvo fat',67,2000,4,26);
insert into articulo values (30,'desodorante rrr',78,3000,3,29);
insert into articulo values (12,'camisa xyz',23,3600,8,35);
insert into articulo values (13,'pantalon xyz',88,4000,8,36);
insert into articulo values (14,'televisor asa',90,30000,6,31);
insert into articulo values (15,'portatil ph',43,32000,7,33);
insert into articulo values (16,'celular ww1212',100,6000,3,34);
insert into articulo values (17,'galletas saladas',60,8000,5,22);
insert into articulo values (11,'camisa abc',67,3000,1,35);
insert into articulo values (18,'jabon uno',200,5000,6,27);
insert into articulo values (19,'desodorante waq',45,1000,4,29);
insert into articulo values (50,'carne pollo',77,1000,5,42);
insert into articulo values (51,'kumis',900,98,7,12);
insert into articulo values (52,'interiores caballero',100,500,9,37);
insert into articulo values (53,'libretas',45,7000,10,20);
insert into articulo values (54,'lecheritas',50,800,10,24);
insert into articulo values (55,'dulces saboreo',88,400,9,24);
insert into articulo values (56,'yogurt tintin',45,890,6,12);
insert into articulo values (57,'camisa albert',80,3500,4,35);
insert into articulo values (58,'jabon polvo saso',44,1200,4,26);
insert into articulo values (59,'jabon polvo arnel',33,2000,4,26);
insert into articulo values (40,'desodorante tico',33,3000,3,29);
insert into articulo values (42,'camisa eto',28,3600,8,35);
insert into articulo values (43,'pantalon eto',66,4000,8,36);
insert into articulo values (44,'televisor syno',45,30000,6,31);
insert into articulo values (45,'portatil toshi',165,32000,7,33);
insert into articulo values (46,'celular ww1221',200,6000,3,34);
insert into articulo values (47,'galletas dulces',44,8000,5,22);
insert into articulo values (41,'camisetas polito',33,3000,1,35);
insert into articulo values (48,'jabon dos',200,5000,6,27);
insert into articulo values (49,'desodorante alerta',11,1000,4,29);


insert into caja values (111, 'avenida');
insert into caja values (121, 'primer piso');
insert into caja values (131, 'segundo piso');
insert into caja values (132, 'segundo piso');
insert into caja values (142, 'sotano');
insert into caja values (153, 'puerta principal');
insert into caja values (141, 'sotano');
insert into caja values (151, 'puerta principal');
insert into caja values (152, 'puerta principal');

insert into cajero values (71, 'rosa', 'f','11/05/1982');
insert into cajero values (21, 'osman', 'm','09/08/1989');
insert into cajero values (11, 'tony', 'f','06/11/1990');
insert into cajero values (12, 'alba', 'f','19/10/1980');
insert into cajero values (41, 'pedro', 'm','20/04/1984');
insert into cajero values (91, 'jorge', 'm','09/08/1989');
insert into cajero values (51, 'mirta', 'f','12/12/1977');
insert into cajero values (61, 'luisa', 'f','25/09/1978');
insert into cajero values (81, 'rita', 'f','06/11/1990');
insert into cajero values (31, 'tatty', 'f','19/10/1980');
insert into cajero values (75, 'rosaura', 'f','11/05/1984');
insert into cajero values (25, 'osmar', 'm','09/08/1984');
insert into cajero values (14, 'tomas', 'f','06/11/1995');
insert into cajero values (87, 'albaina', 'f','19/10/1985');
insert into cajero values (43, 'peter', 'm','20/04/1985');
insert into cajero values (93, 'jorge mario', 'm','09/08/1985');
insert into cajero values (53, 'mirita', 'f','15/12/1977');
insert into cajero values (64, 'luisita', 'f','26/09/1978');
insert into cajero values (84, 'rita', 'f','06/10/1990');
insert into cajero values (34, 'tattyana', 'f','22/10/1980');

insert into ventas values (20,32,27,2,'06/02/2017');
insert into ventas values (21,33,29,3,'08/05/2019');
insert into ventas values (22,34,30,3,'18/03/2015');
insert into ventas values (23,44,21,4,'09/04/2017');
insert into ventas values (24,43,21,4,'09/03/2015');
insert into ventas values (25,45,26,2,'05/12/2017');
insert into ventas values (26,37,21,3,'08/10/2017');
insert into ventas values (27,21,11,3,'11/03/2018');
insert into ventas values (28,23,22,3,'21/08/2017');
insert into ventas values (29,21,21,2,'14/09/2017');
insert into ventas values (30,42,13,4,'09/03/2018');
insert into ventas values (10,25,26,2,'05/12/2017');
insert into ventas values (11,27,21,4,'08/01/2018');
insert into ventas values (12,28,27,5,'06/02/2018');
insert into ventas values (13,15,15,5,'05/03/2018');
insert into ventas values (14,21,22,3,'04/01/2015');
insert into ventas values (15,22,29,2,'08/02/2018');
insert into ventas values (16,24,30,3,'18/07/2017');
insert into ventas values (17,39,22,2,'06/07/2017');
insert into ventas values (18,39,23,5,'02/03/2015');
insert into ventas values (19,18,11,8,'18/01/2018');
insert into ventas values (90,24,13,4,'29/04/2017');
insert into ventas values (31,44,15,4,'19/04/2017');
insert into ventas values (58,5,46,2,'15/03/2015');
insert into ventas values (57,17,41,3,'28/10/2016');
insert into ventas values (56,11,41,3,'11/10/2019');
insert into ventas values (55,23,23,1,'21/08/2019');
insert into ventas values (53,21,19,2,'14/09/2016');
insert into ventas values (54,34,45,3,'09/03/2015');
insert into ventas values (52,35,56,2,'05/12/2020');
insert into ventas values (51,37,41,5,'02/03/2018');
insert into ventas values (50,38,47,2,'06/03/2018');
insert into ventas values (49,45,44,5,'15/08/2020');
insert into ventas values (48,41,52,3,'22/03/2015');
insert into ventas values (47,32,59,3,'11/01/2018');
insert into ventas values (46,34,52,8,'18/03/2015');
insert into ventas values (66,35,46,2,'15/12/2017');
insert into ventas values (69,27,41,3,'28/03/2018');
insert into ventas values (61,21,41,3,'11/10/2017');
insert into ventas values (62,23,11,1,'21/03/2018');
insert into ventas values (63,11,21,2,'14/09/2017');
insert into ventas values (64,24,30,3,'09/03/2018');
insert into ventas values (74,25,46,2,'05/12/2017');
insert into ventas values (75,17,41,5,'02/03/2018');
insert into ventas values (76,28,27,2,'06/03/2018');
insert into ventas values (87,32,49,3,'11/01/2018');

insert into surtidos values (1,111,15,'10/02/2015',200);
insert into surtidos values (2,777,11,'16/10/2017',330);
insert into surtidos values (3,666,14,'18/09/2017',120);
insert into surtidos values (4,777,11,'19/01/2015',230);
insert into surtidos values (5,444,21,'22/03/2018',160);
insert into surtidos values (6,444,26,'21/03/2018',170);
insert into surtidos values (7,777,11,'28/03/2018',150);
insert into surtidos values (8,666,15,'25/06/2017',130);
insert into surtidos values (9,777,12,'21/02/2018',130);
insert into surtidos values (10,333,20,'27/11/2019',35);
insert into surtidos values (11,444,26,'25/03/2019',200);
insert into surtidos values (12,345,30,'22/03/2019',190);
insert into surtidos values (13,666,15,'15/07/2016',145);
insert into surtidos values (14,634,12,'22/09/2016',134);
insert into surtidos values (15,333,20,'26/03/2018',85);
insert into surtidos values (16,454,26,'21/02/2015',170);
insert into surtidos values (17,777,42,'28/05/2017',150);
insert into surtidos values (18,111,15,'25/06/2017',130);
insert into surtidos values (19,777,12,'21/04/2017',130);
insert into surtidos values (20,888,23,'27/02/2015',35);
insert into surtidos values (21,111,15,'10/11/2019',200);
insert into surtidos values (22,345,11,'16/10/2017',330);
insert into surtidos values (23,111,14,'18/09/2017',120);
insert into surtidos values (24,777,11,'19/02/2018',230);
insert into surtidos values (25,444,21,'22/07/2017',160);
insert into surtidos values (27,777,11,'28/05/2020',150);
insert into surtidos values (28,666,15,'25/06/2017',130);
insert into surtidos values (29,777,12,'01/04/2018',130);
insert into surtidos values (30,333,20,'27/11/2017',35);
insert into surtidos values (31,444,26,'25/03/2015',200);
insert into surtidos values (32,777,11,'22/03/2017',190);
insert into surtidos values (33,111,15,'15/02/2018',145);
insert into surtidos values (34,777,12,'22/09/2017',134);
insert into surtidos values (35,345,20,'26/10/2017',85);
insert into surtidos values (43,131,44,'18/09/2019',120);
insert into surtidos values (44,131,41,'19/01/2018',230);
insert into surtidos values (45,345,51,'22/02/2015',160);
insert into surtidos values (46,444,56,'21/03/2018',170);
insert into surtidos values (47,777,41,'28/05/2020',150);
insert into surtidos values (48,666,45,'25/06/2020',130);
insert into surtidos values (49,722,42,'21/02/2018',130);
insert into surtidos values (60,722,50,'27/02/2018',35);
insert into surtidos values (61,722,56,'25/03/2016',200);
insert into surtidos values (62,345,25,'22/03/2019',190);
insert into surtidos values (63,666,15,'15/07/2016',145);
insert into surtidos values (64,634,42,'22/02/2018',134);
insert into surtidos values (65,333,50,'26/10/2017',85);
insert into surtidos values (66,454,56,'21/04/2017',170);
insert into surtidos values (67,644,30,'28/02/2018',150);
insert into surtidos values (68,855,45,'25/06/2017',130);
insert into surtidos values (69,777,42,'21/04/2017',130);
insert into surtidos values (80,445,53,'27/11/2017',35);
insert into surtidos values (81,445,45,'10/11/2017',200);
insert into surtidos values (82,442,41,'16/02/2018',330);
insert into surtidos values (83,442,24,'18/09/2017',120);
insert into surtidos values (84,644,56,'19/02/2018',230);
insert into surtidos values (95,644,42,'22/07/2017',160);
insert into surtidos values (57,233,56,'28/05/2017',150);
insert into surtidos values (58,131,56,'25/06/2020',130);
insert into surtidos values (59,131,50,'21/04/2017',130);
insert into surtidos values (90,131,40,'27/11/2017',35);
insert into surtidos values (91,828,46,'25/03/2020',200);
insert into surtidos values (72,828,51,'22/03/2017',190);
insert into surtidos values (73,727,55,'15/07/2020',145);



insert into compras values (1,116,11,5,'14/02/2018');
insert into compras values (2,123,22,3,'09/06/2017');
insert into compras values (3,125,24,6,'22/04/2017');
insert into compras values (4,127,16,7,'08/02/2018');
insert into compras values (5,116,21,3,'11/06/2017');
insert into compras values (6,117,15,1,'24/02/2015');
insert into compras values (7,114,28,1,'27/06/2019');
insert into compras values (8,118,26,5,'18/08/2019');
insert into compras values (9,113,28,2,'15/02/2015');
insert into compras values (10,112,27,4,'19/10/2019');
insert into compras values (11,111,29,3,'21/12/2019');
insert into compras values (12,114,30,8,'25/06/2020');
insert into compras values (13,121,11,5,'27/09/2019');
insert into compras values (14,127,12,6,'04/02/2018');
insert into compras values (15,128,14,3,'12/12/2019');
insert into compras values (16,112,21,5,'14/02/2018');
insert into compras values (17,113,22,3,'09/06/2017');
insert into compras values (18,115,14,6,'22/04/2017');
insert into compras values (19,107,26,7,'08/08/2016');
insert into compras values (20,106,21,3,'11/02/2018');
insert into compras values (21,107,25,1,'24/01/2015');
insert into compras values (22,104,48,1,'27/06/2016');
insert into compras values (23,108,46,5,'18/08/2017');
insert into compras values (24,115,48,2,'15/09/2017');
insert into compras values (25,112,27,4,'19/02/2018');
insert into compras values (26,121,29,3,'21/02/2018');
insert into compras values (27,124,30,8,'25/06/2020');
insert into compras values (28,121,41,5,'27/02/2018');
insert into compras values (29,107,12,6,'04/01/2018');
insert into compras values (30,128,44,3,'12/02/2018');
insert into compras values (31,126,19,5,'14/10/2017');
insert into compras values (32,113,42,3,'09/01/2018');
insert into compras values (33,115,24,6,'22/04/2017');
insert into compras values (34,127,16,7,'08/02/2018');
insert into compras values (35,116,41,3,'11/06/2019');
insert into compras values (36,117,45,1,'24/08/2019');
insert into compras values (37,114,28,1,'27/06/2020');
insert into compras values (38,128,26,5,'18/01/2018');
insert into compras values (39,113,48,2,'15/09/2019');
insert into compras values (40,112,47,4,'19/02/2018');
insert into compras values (41,121,49,3,'21/01/2018');
insert into compras values (42,114,30,8,'25/06/2020');
insert into compras values (43,121,21,5,'27/09/2017');
insert into compras values (80,213,21,3,'11/06/2017');
insert into compras values (81,422,25,1,'24/01/2018');
insert into compras values (82,521,48,1,'27/01/2018');
insert into compras values (83,521,46,5,'18/01/2018');
insert into compras values (84,530,48,2,'15/09/2017');
insert into compras values (65,530,27,4,'19/10/2017');
insert into compras values (66,512,29,3,'21/12/2019');
insert into compras values (67,512,30,8,'25/06/2020');
insert into compras values (68,909,41,5,'27/09/2019');
insert into compras values (69,414,12,6,'04/11/2019');
insert into compras values (60,909,44,3,'12/12/2019');
insert into compras values (61,808,19,5,'14/01/2018');
insert into compras values (62,808,42,3,'09/06/2017');
insert into compras values (63,701,24,6,'22/01/2018');
insert into compras values (64,706,16,7,'08/01/2018');
insert into compras values (95,701,41,3,'11/06/2017');
insert into compras values (56,213,45,1,'24/01/2015');
insert into compras values (57,213,28,1,'27/06/2020');
insert into compras values (58,422,26,5,'18/08/2017');
insert into compras values (59,521,48,2,'15/09/2017');
insert into compras values (50,319,47,4,'19/10/2017');
insert into compras values (51,319,49,3,'21/12/2017');



insert into pagos values (11,116,111,'22/01/2015','22/01/2015 12:14');
insert into pagos values (12,122,131,'21/05/2016','21/05/2016 13:15');
insert into pagos values (13,121,141,'22/07/2016','22/07/2016 18:32');
insert into pagos values (14,112,131,'23/04/2020','23/04/2020 19:15');
insert into pagos values (15,114,121,'26/12/2017','26/12/2017 09:19');
insert into pagos values (16,117,141,'27/05/2020','27/05/2020 09:58');
insert into pagos values (17,123,151,'28/05/2017','28/05/2017 15:44');
insert into pagos values (18,112,153,'24/05/2020','24/05/2020 18:22');
insert into pagos values (19,116,152,'11/01/2018','11/01/2018 14:15');
insert into pagos values (20,118,111,'05/09/2019','05/09/2019 15:23');
insert into pagos values (21,114,121,'26/12/2019','26/12/2019 08:43');
insert into pagos values (22,117,141,'27/01/2018','27/01/2018 15:56');
insert into pagos values (23,123,151,'28/05/2017','28/05/2017 08:51');
insert into pagos values (24,112,153,'24/01/2015','24/01/2015 15:12');
insert into pagos values (25,116,152,'11/11/2017','11/11/2017 08:15');
insert into pagos values (26,118,111,'05/01/2018','05/01/2018 17:16');
insert into pagos values (27,123,141,'28/05/2017','28/05/2017 14:16');
insert into pagos values (28,118,153,'24/01/2018','24/01/2018 08:11');
insert into pagos values (29,115,132,'11/11/2017','11/11/2017 15:10');
insert into pagos values (30,118,121,'05/09/2017','05/09/2017 17:15');
insert into pagos values (31,114,121,'26/12/2017','26/12/2017 14:20');
insert into pagos values (32,113,121,'27/05/2020','27/05/2020 15:31');
insert into pagos values (33,123,151,'28/01/2015','28/01/2015 08:32');
insert into pagos values (34,117,121,'24/05/2016','24/05/2016 17:54');
insert into pagos values (35,117,151,'11/11/2019','11/11/2019 08:21');
insert into pagos values (36,116,131,'05/09/2020','05/09/2020 08:43');
insert into pagos values (37,123,151,'28/01/2018','28/01/2018 17:54');
insert into pagos values (38,113,132,'24/05/2019','24/05/2019 08:15');
insert into pagos values (39,116,142,'11/01/2018','11/01/2018 14:55');
insert into pagos values (40,118,111,'05/09/2019','05/09/2019 17:45');
insert into pagos values (41,113,121,'26/03/2018','26/03/2018 20:32');
insert into pagos values (42,119,141,'27/05/2017','27/05/2017 09:56');
insert into pagos values (43,123,121,'28/01/2018','28/01/2018 08:26');
insert into pagos values (44,114,153,'24/05/2017','24/05/2017 20:15');
insert into pagos values (45,113,132,'11/03/2018','11/03/2018 16:41');
insert into pagos values (46,113,131,'05/09/2020','05/09/2020 08:24');
insert into pagos values (47,422,141,'28/05/2017','28/05/2017 14:15');
insert into pagos values (48,422,153,'24/05/2016','24/05/2016 17:23');
insert into pagos values (49,511,132,'11/11/2017','11/11/2017 08:24');
insert into pagos values (50,422,121,'05/03/2018','05/03/2018 16:33');
insert into pagos values (51,511,121,'26/01/2018','26/01/2018 08:33');
insert into pagos values (52,213,121,'27/05/2017','27/05/2017 14:15');
insert into pagos values (53,213,151,'28/05/2019','28/05/2019 19:33');
insert into pagos values (54,512,121,'24/01/2018','24/01/2018 19:15');
insert into pagos values (55,512,151,'11/01/2018','11/01/2018 08:21');
insert into pagos values (56,414,131,'05/09/2019','05/09/2019 17:21');
insert into pagos values (57,512,151,'28/01/2018','28/01/2018 16:15');
insert into pagos values (58,414,132,'24/05/2017','24/05/2017 08:38');
insert into pagos values (59,909,142,'11/11/2017','11/11/2017 17:15');
insert into pagos values (60,909,111,'05/01/2018','05/01/2018 16:24');
insert into pagos values (61,804,121,'26/12/2017','26/12/2017 08:23');
insert into pagos values (63,123,121,'28/02/2018','28/02/2018 16:15');
insert into pagos values (64,805,153,'24/05/2020','24/05/2020 14:23');

insert into atenciones values (11,51,121,'11/03/2020');
insert into atenciones values (21,41,131,'21/05/2020');
insert into atenciones values (31,61,141,'22/09/2017');
insert into atenciones values (41,41,151,'21/03/2018');
insert into atenciones values (51,71,141,'28/09/2019');
insert into atenciones values (61,12,131,'09/03/2018');
insert into atenciones values (71,81,152,'06/03/2018');
insert into atenciones values (81,91,111,'18/12/2019');
insert into atenciones values (91,11,121,'10/04/2019');
insert into atenciones values (52,41,141,'27/09/2017');
insert into atenciones values (62,51,131,'19/11/2017');
insert into atenciones values (72,31,152,'04/03/2018');
insert into atenciones values (82,81,111,'16/12/2017');
insert into atenciones values (92,71,121,'20/04/2020');
insert into atenciones values (13,31,131,'11/02/2020');
insert into atenciones values (23,41,131,'21/03/2016');
insert into atenciones values (33,31,121,'22/01/2018');
insert into atenciones values (43,41,111,'21/03/2018');
insert into atenciones values (53,71,121,'28/03/2018');
insert into atenciones values (63,21,131,'09/08/2017');
insert into atenciones values (73,81,152,'06/03/2018');
insert into atenciones values (83,51,151,'28/12/2017');
insert into atenciones values (93,61,121,'20/04/2017');
insert into atenciones values (54,81,141,'17/09/2017');
insert into atenciones values (64,51,141,'29/11/2019');
insert into atenciones values (74,91,132,'14/03/2018');
insert into atenciones values (84,81,111,'26/01/2018');
insert into atenciones values (94,21,111,'20/04/2019');
insert into atenciones values (76,84,152,'06/01/2018');
insert into atenciones values (85,34,111,'18/12/2019');
insert into atenciones values (95,71,121,'12/03/2018');
insert into atenciones values (55,43,141,'27/09/2017');
insert into atenciones values (65,53,131,'19/03/2018');
insert into atenciones values (75,34,152,'04/06/2017');
insert into atenciones values (89,81,111,'18/03/2018');
insert into atenciones values (99,53,121,'20/04/2017');
insert into atenciones values (16,64,131,'11/02/2017');
insert into atenciones values (26,43,131,'21/03/2018');
insert into atenciones values (36,43,121,'22/03/2018');
insert into atenciones values (46,25,111,'21/04/2016');
insert into atenciones values (59,14,121,'28/07/2017');
insert into atenciones values (69,14,131,'09/03/2018');
insert into atenciones values (79,87,152,'06/03/2018');
insert into atenciones values (80,31,151,'28/12/2017');
insert into atenciones values (9,71,121,'20/03/2018');
insert into atenciones values (58,71,141,'17/09/2017');
insert into atenciones values (68,31,141,'29/11/2016');

insert into premios values (15,129,433,'17/09/2017','lavadora');
insert into premios values (16,129,434,'18/11/2017','mercado gratis');
insert into premios values (17,130,432,'19/01/2018','viaje a san andres');
insert into premios values (18,130,432,'21/11/2017','viaje a cartagena');
insert into premios values (19,113,435,'22/06/2017','valor de compra gratis');
insert into premios values (32,125,431,'21/02/2018','carro ultimo modelo');
insert into premios values (33,121,431,'31/12/2017','carro ultimo modelo');
insert into premios values (42,113,432,'09/01/2018','descuento 25%');
insert into premios values (20,112,435,'22/12/2019','celular');
insert into premios values (43,111,431,'07/01/2018','descuento 20%');
insert into premios values (10,128,434,'12/03/2018','celular');
insert into premios values (11,128,432,'14/02/2018','computador portatil');
insert into premios values (45,105,433,'01/01/2018','descuento 30%');
insert into premios values (12,127,432,'14/07/2019','televisor 21 pulgadas');
insert into premios values (36,113,433,'09/02/2018','descuento 25%');
insert into premios values (13,114,435,'15/08/2017','televisor 14 pulgadas');
insert into premios values (40,119,435,'12/05/2020','descuento 20%');
insert into premios values (14,124,435,'16/08/2017','nevera 12 pies');
insert into premios values (41,124,433,'09/10/2019','descuento 30%');
insert into premios values (1,104,435,'11/06/2017','televisor 21 pulgadas');
insert into premios values (44,108,431,'01/11/2020','descuento 10%');
insert into premios values (27,108,432,'12/02/2018','viaje a san andres');
insert into premios values (35,108,431,'09/02/2018','descuento 30%');
insert into premios values (28,110,435,'05/04/2020','viaje a cartagena');
insert into premios values (29,127,434,'10/02/2018','valor de compra gratis');
insert into premios values (30,125,432,'11/09/2017','celular');
insert into premios values (37,127,435,'07/10/2019','descuento 20%');
insert into premios values (31,123,434,'12/02/2018','computador portatil');
insert into premios values (39,115,435,'01/10/2019','descuento 30%');
insert into premios values (8,125,433,'18/04/2017','viaje a cartagena');
insert into premios values (9,123,435,'19/02/2018','valor de compra gratis');
insert into premios values (2,123,432,'23/07/2017','televisor 14 pulgadas');
insert into premios values (3,130,433,'24/08/2019','televisor plasma');
insert into premios values (4,122,432,'25/09/2019','nevera 12 pies');
insert into premios values (5,111,433,'27/01/2017','lavadora');
insert into premios values (38,118,435,'01/10/2017','descuento 10%');
insert into premios values (6,116,434,'28/02/2017','mercado gratis');
insert into premios values (7,118,432,'21/03/2017','viaje a san andres');
insert into premios values (26,109,433,'12/05/2017','mercado gratis');
insert into premios values (21,104,432,'09/12/2017','computador portatil');
insert into premios values (22,103,434,'09/12/2017','televisor 14 pulgadas');
insert into premios values (23,107,432,'07/02/2018','televisor plasma');
insert into premios values (24,108,432,'01/03/2018','nevera 12 pies');
insert into premios values (25,105,433,'01/10/2017','lavadora');
insert into premios values (34,105,435,'12/06/2017','descuento 20%');
insert into premios values (46,122,435,'21/01/2018','mercado gratis');
insert into premios values (47,112,434,'11/03/2018','mercado gratis');
insert into premios values (48,111,435,'22/11/2017','mercado gratis');
insert into premios values (49,129,434,'02/03/2018','mercado gratis');
insert into premios values (50,106,435,'05/09/2017','mercado gratis');
insert into premios values (57,701,432,'19/03/2018','viaje a san andres');
insert into premios values (58,706,435,'21/03/2018','viaje a cartagena');
insert into premios values (59,805,434,'22/01/2018','valor de compra gratis');
insert into premios values (62,808,431,'31/12/2019','carro ultimo modelo');
insert into premios values (63,808,431,'31/03/2018','carro ultimo modelo');
insert into premios values (67,530,435,'09/09/2019','descuento 25%');
insert into premios values (51,530,433,'22/03/2018','celular');
insert into premios values (83,530,435,'07/08/2019','descuento 20%');
insert into premios values (80,414,434,'12/03/2018','celular');
insert into premios values (81,512,432,'14/06/2017','computador portatil');
insert into premios values (85,414,435,'01/05/2017','descuento 30%');
insert into premios values (82,213,432,'14/01/2018','televisor 21 pulgadas');
insert into premios values (86,511,435,'09/11/2017','descuento 25%');
insert into premios values (93,511,432,'15/01/2018','televisor 14 pulgadas');
insert into premios values (90,511,435,'12/01/2018','descuento 20%');
insert into premios values (94,909,431,'16/08/2017','nevera 12 pies');
insert into premios values (96,909,433,'12/05/2017','mercado gratis');
insert into premios values (91,511,432,'09/12/2017','computador portatil');
insert into premios values (92,422,434,'09/01/2018','televisor 14 pulgadas');
insert into premios values (73,521,432,'07/10/2017','televisor plasma');
insert into premios values (98,520,432,'01/10/2017','nevera 12 pies');
insert into premios values (95,319,433,'01/01/2018','lavadora');
insert into premios values (84,518,435,'12/06/2017','descuento 20%');
insert into premios values (56,317,434,'21/12/2017','mercado gratis');
insert into premios values (87,229,434,'11/05/2016','mercado gratis');