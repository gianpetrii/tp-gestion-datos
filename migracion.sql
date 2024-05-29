USE [GD1C2024]
GO

PRINT '**** Comenzando Migracion  ****';

-- GO

-- DECLARE @DropTables NVARCHAR(max) = ''

-- SELECT @DropTables += 'DROP TABLE DATA_BRIGADE. ' + QUOTENAME(TABLE_NAME)

-- FROM INFORMATION_SCHEMA.TABLES

-- WHERE TABLE_SCHEMA = 'DATA_BRIGADE' and TABLE_TYPE = 'BASE TABLE'

-- EXECUTE sp_executesql @DropTables;

-- PRINT '**** TABLAS eliminadas correctamente ****';

-- GO


/********* Drop de Stored Procedures *********/
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'migrar_tipo_medio_pago')
DROP PROCEDURE DATA_BRIGADE.migrar_tipo_medio_pago;
GO


PRINT '**** SPs dropeados correctamente ****';

go


--DROP PREVENTIVO DE TABLAS-------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'producto_x_promocion')
DROP TABLE data_brigade.producto_x_promocion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ticket_det_x_promocion')
DROP TABLE data_brigade.ticket_det_x_promocion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ticket_det')
DROP TABLE data_brigade.ticket_det
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'producto')
DROP TABLE data_brigade.producto
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'sub_categoria')
DROP TABLE data_brigade.sub_categoria
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'categoria')
DROP TABLE data_brigade.categoria
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'marca')
DROP TABLE data_brigade.marca
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'regla')
DROP TABLE data_brigade.regla
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'promocion')
DROP TABLE data_brigade.promocion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ticket')
DROP TABLE data_brigade.ticket
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'pago')
DROP TABLE data_brigade.pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'medio_pago_descuento_aplicado')
DROP TABLE data_brigade.medio_pago_descuento_aplicado
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'medio_pago')
DROP TABLE DATA_BRIGADE.medio_pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'tipo_medio_pago')
DROP TABLE DATA_BRIGADE.tipo_medio_pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'envio')
DROP TABLE data_brigade.envio
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'estado_envio')
DROP TABLE data_brigade.estado_envio
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'caja')
DROP TABLE data_brigade.caja
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'tipo_caja')
DROP TABLE data_brigade.tipo_caja
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'empleado')
DROP TABLE data_brigade.empleado
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'sucursal')
DROP TABLE data_brigade.sucursal
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'supermercado')
DROP TABLE data_brigade.supermercado
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'descuento')
DROP TABLE data_brigade.descuento
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'detalle_pago')
DROP TABLE data_brigade.detalle_pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'cliente')
DROP TABLE data_brigade.cliente
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'direccion')
DROP TABLE data_brigade.direccion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'localidad')
DROP TABLE data_brigade.localidad
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'provincia')
DROP TABLE data_brigade.provincia

/*agregar faltantes*/

PRINT '**** Tablas eliminadas correctamente ****';

--DROP PREVENTIVO DE SCHEMA-------------------------
IF EXISTS (SELECT name FROM sys.schemas WHERE name = 'DATA_BRIGADE')
DROP SCHEMA DATA_BRIGADE
--CREACION DE SCHEMA--------------------------------
PRINT '**** Creando SCHEMA ****';

GO
CREATE SCHEMA DATA_BRIGADE;
GO


--CREACION DE TABLAS--------------------------------
PRINT '**** Creando TABLAS ****';
PRINT 'Creando tabla provincia';
CREATE TABLE DATA_BRIGADE.provincia (
    ID_PROVINCIA int IDENTITY PRIMARY KEY,
    PROVINCIA_NOMBRE nvarchar(255) null
);
PRINT 'Creando tabla localidad';
CREATE TABLE DATA_BRIGADE.localidad (
    ID_LOCALIDAD int IDENTITY PRIMARY KEY,
    LOCALIDAD_NOMBRE nvarchar(255) null,
    ID_PROVINCIA int REFERENCES DATA_BRIGADE.provincia
);
PRINT 'Creando tabla direccion';
CREATE TABLE DATA_BRIGADE.direccion (
    ID_DIRECCION int IDENTITY PRIMARY KEY,
    DIRECCION_NOMBRE nvarchar(255) null,
    ID_LOCALIDAD int REFERENCES DATA_BRIGADE.localidad
);
PRINT 'Creando tabla cliente';
CREATE TABLE DATA_BRIGADE.cliente (
    ID_CLIENTE int IDENTITY PRIMARY KEY,
    CLIENTE_NOMBRE nvarchar(255) null,
    CLIENTE_APELLIDO nvarchar(255) null,
    CLIENTE_DNI nvarchar(255) null,
    CLIENTE_TELEFONO nvarchar(255) null,
    CLIENTE_FECHA_REGISTRO datetime2(3) null,
    CLIENTE_EMAIL nvarchar(255) null,
    CLIENTE_FECHA_NACIMIENTO datetime2(3) null,
    ID_DIRECCION int REFERENCES DATA_BRIGADE.direccion
);
PRINT 'Creando tabla detalle_pago';
CREATE TABLE DATA_BRIGADE.detalle_pago (
    ID_DETALLE_PAGO int IDENTITY PRIMARY KEY,
    ID_CLIENTE int REFERENCES DATA_BRIGADE.cliente,
    PAGO_TARJETA_NRO nvarchar(255) null,
    PAGO_TARJETA_CUOTAS nvarchar(255) null,
    PAGO_TARJETA_FECHA_VENC datetime2(3) null
);
PRINT 'Creando tabla descuento';
CREATE TABLE DATA_BRIGADE.descuento (
    ID_DESCUENTO int IDENTITY PRIMARY KEY,
    DESCUENTO_DESCRIPCION nvarchar(255) null,
    DESCUENTO_PORCENTAJE decimal(18,2) null
);
PRINT 'Creando tabla supermercado';
CREATE TABLE DATA_BRIGADE.supermercado (
    ID_SUPERMERCADO int IDENTITY PRIMARY KEY,
    SUPERMERCADO_NOMBRE nvarchar(255) null
);
PRINT 'Creando tabla sucursal';
CREATE TABLE DATA_BRIGADE.sucursal (
    ID_SUCURSAL int IDENTITY PRIMARY KEY,
    SUCURSAL_NOMBRE nvarchar(255) null,
    SUPER_CUIT int REFERENCES DATA_BRIGADE.supermercado,
    ID_DIRECCION int REFERENCES DATA_BRIGADE.direccion
);
PRINT 'Creando tabla empleado';
CREATE TABLE DATA_BRIGADE.empleado (
    ID_EMPLEADO int IDENTITY PRIMARY KEY,
    EMPLEADO_DNI int null,
    EMPLEADO_NOMBRE nvarchar(255) null,
    EMPLEADO_APELLIDO nvarchar(255) null,
    EMPLEADO_FECHA_REGISTRO datetime2(3) null,
    EMPLEADO_TELEFONO int null,
    EMPLEADO_EMAIL nvarchar(255) null,
    EMPLEADO_FECHA_NACIMIENTO datetime2(3) null,
    ID_SUCURSAL int REFERENCES DATA_BRIGADE.sucursal
);
PRINT 'Creando tabla tipo_caja';
CREATE TABLE DATA_BRIGADE.tipo_caja (
    ID_CAJA_TIPO int IDENTITY PRIMARY KEY,
    CAJA_TIPO_NOMBRE nvarchar(255) null
);
PRINT 'Creando tabla caja';
CREATE TABLE DATA_BRIGADE.caja (
    ID_CAJA int IDENTITY PRIMARY KEY,
    ID_CAJA_TIPO int REFERENCES DATA_BRIGADE.tipo_caja,
    ID_SUCURSAL int REFERENCES DATA_BRIGADE.sucursal
);
PRINT 'Creando tabla estado_envio';
CREATE TABLE DATA_BRIGADE.estado_envio (
    ID_ESTADO_ENVIO int IDENTITY PRIMARY KEY,
    ESTADO_ENVIO_NOMBRE nvarchar(255) null
);
PRINT 'Creando tabla envio';
CREATE TABLE DATA_BRIGADE.envio (
    ID_ENVIO int IDENTITY PRIMARY KEY,
    ID_ESTADO_ENVIO int REFERENCES DATA_BRIGADE.estado_envio,
    FECHA_ENVIO datetime2(3) null
);
PRINT 'Creando tabla tipo_medio_pago';
CREATE TABLE DATA_BRIGADE.tipo_medio_pago (
    ID_TIPO_MEDIO_PAGO int IDENTITY PRIMARY KEY,
    NOMBRE nvarchar(255) null
);
PRINT 'Creando tabla medio_pago';
CREATE TABLE DATA_BRIGADE.medio_pago (
    ID_MEDIO_PAGO int IDENTITY PRIMARY KEY,
    NOMBRE nvarchar(255) null,
    ID_TIPO_MEDIO_PAGO int REFERENCES DATA_BRIGADE.tipo_medio_pago
);
PRINT 'Creando tabla medio_pago_descuento_aplicado';
CREATE TABLE DATA_BRIGADE.medio_pago_descuento_aplicado (
    ID_MEDIO_PAGO int REFERENCES DATA_BRIGADE.medio_pago,
    ID_DESCUENTO int REFERENCES DATA_BRIGADE.descuento
);
PRINT 'Creando tabla pago';
CREATE TABLE DATA_BRIGADE.pago (
    ID_PAGO int IDENTITY PRIMARY KEY,
    PAGO_FECHA datetime2(3) null,
    ID_DETALLE_PAGO int REFERENCES DATA_BRIGADE.detalle_pago,
    ID_MEDIO_PAGO int REFERENCES DATA_BRIGADE.medio_pago
);
PRINT 'Creando tabla ticket';
CREATE TABLE DATA_BRIGADE.ticket (
    ID_TICKET int IDENTITY PRIMARY KEY,
    TICKET_FECHA_HORA datetime2(3) null,
    TICKET_TIPO_COMPROBANTE nvarchar(255) null,
    ID_PAGO int REFERENCES DATA_BRIGADE.pago not null,
    TICKET_TOTAL_DESCUENTO_APLICADO_MP decimal(18,2) null,
    TICKET_TOTAL_ENVIO decimal(18,2) null,
    TICKET_TOTAL_TICKET decimal(18,2) null,
    ID_EMPLEADO int REFERENCES DATA_BRIGADE.empleado not null,
    ID_CAJA int REFERENCES DATA_BRIGADE.caja not null,
    CLIENTE_DNI int null,
    ID_ENVIO int REFERENCES DATA_BRIGADE.envio not null
);
PRINT 'Creando tabla promocion';
CREATE TABLE DATA_BRIGADE.promocion (
    ID_PROMOCION int IDENTITY PRIMARY KEY,
    PROMOCION_DESCRIPCION nvarchar(255) null,
    PROMO_APLICADA_DESCUENTO decimal(18,2) null,
    PROMOCION_FECHA_INICIO datetime2(3) null,
    PROMOCION_FECHA_FIN datetime2(3) null
);
PRINT 'Creando tabla regla';
CREATE TABLE DATA_BRIGADE.regla (
    ID_REGLA int IDENTITY PRIMARY KEY,
    REGLA_DESCRIPCION nvarchar(255) null,
    REGLA_VALOR decimal(18,2) null
);
PRINT 'Creando tabla marca';
CREATE TABLE DATA_BRIGADE.marca (
    ID_MARCA int IDENTITY PRIMARY KEY,
    MARCA_NOMBRE nvarchar(255) null
);
PRINT 'Creando tabla categoria';
CREATE TABLE DATA_BRIGADE.categoria (
    ID_CATEGORIA int IDENTITY PRIMARY KEY,
    CATEGORIA_NOMBRE nvarchar(255) null
);
PRINT 'Creando tabla subcategoria';
CREATE TABLE DATA_BRIGADE.sub_categoria (
    ID_SUB_CATEGORIA int IDENTITY PRIMARY KEY,
    SUB_CATEGORIA_NOMBRE nvarchar(255) null,
    ID_CATEGORIA int REFERENCES DATA_BRIGADE.categoria
);
PRINT 'Creando tabla producto';
CREATE TABLE DATA_BRIGADE.producto(
    ID_PRODUCTO int IDENTITY PRIMARY KEY,
    PRODUCTO_NOMBRE nvarchar(255) null,
    PRODUCTO_DESCRIPCION nvarchar(255) null,
    PRODUCTO_PRECIO nvarchar(255) null,
    ID_MARCA int REFERENCES DATA_BRIGADE.marca,
    ID_SUB_CATEGORIA int REFERENCES DATA_BRIGADE.sub_categoria
);
PRINT 'Creando tabla ticket_detalle';
CREATE TABLE DATA_BRIGADE.ticket_det (
    ID_TICKET_DET int IDENTITY PRIMARY KEY,
    TICKET_DET_CANTIDAD int null,
    TICKET_DET_PRECIO decimal(18,2),
    TICKET_DET_TOTAL decimal(18,2),
    ID_TICKET int REFERENCES DATA_BRIGADE.ticket not null,
    ID_PRODUCTO int REFERENCES DATA_BRIGADE.producto not null
);
PRINT 'Creando tabla producto_x_promocion';
CREATE TABLE DATA_BRIGADE.producto_x_promocion(
    ID_PRODUCTO int REFERENCES DATA_BRIGADE.producto,
    ID_PROMOCION int REFERENCES DATA_BRIGADE.promocion 
);
PRINT 'Creando tabla ticket_det_x_promocion';
CREATE TABLE DATA_BRIGADE.ticket_det_x_promocion (
    ID_TICKET_DET int REFERENCES DATA_BRIGADE.ticket_det,
    ID_PROMOCION int REFERENCES DATA_BRIGADE.promocion,
    PRIMARY KEY (ID_TICKET_DET, ID_PROMOCION)
);

/********* Creacion de StoredProcedures para migracion *********/
--tipo medio pago
GO
create procedure DATA_BRIGADE.migrar_tipo_medio_pago
as
begin 
insert into DATA_BRIGADE.tipo_medio_pago(NOMBRE)
    select distinct M.PAGO_TIPO_MEDIO_PAGO
    from gd_esquema.Maestra as M
    where M.PAGO_TIPO_MEDIO_PAGO is not null
end
PRINT '**** Creando PROCEDURES ****';
go

/********* Ejecucion de StoredProcedures para migracion *********/

--Tablas sin FKs (tienen que ir primero porque el resto de las tablas depende de estas)
PRINT '**** ejecutando PROCEDURES ****';
PRINT '**** ejecutando tipo_medio_pago ****';
EXECUTE DATA_BRIGADE.migrar_tipo_medio_pago

--Tablas con FKs (a tablas sin FKs)

IF (
    EXISTS (select * from DATA_BRIGADE.tipo_medio_pago)
)
    PRINT 'Migracion completada correctamente'

ELSE
    PRINT 'Error en la migracion'

GO
--Tablas con FKs (a tablas con FKs)