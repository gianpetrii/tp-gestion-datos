USE [GD1C2024]
GO

PRINT '**** Comenzando Migracion  ****';

GO

DECLARE @DropTables NVARCHAR(max) = ''

SELECT @DropTables += 'DROP TABLE DATA_BRIGADE. ' + QUOTENAME(TABLE_NAME)

FROM INFORMATION_SCHEMA.TABLES

WHERE TABLE_SCHEMA = 'DATA_BRIGADE' and TABLE_TYPE = 'BASE TABLE'

EXECUTE sp_executesql @DropTables;

PRINT '**** TABLAS dropeadas correctamente ****';

GO


/********* Drop de Stored Procedures *********/
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_estados_reclamos')
DROP PROCEDURE DATA_BRIGADE.Migrar_estados_reclamos;
GO

/*agregar faltantes*/

PRINT '**** SPs dropeados correctamente ****';

go


--DROP PREVENTIVO DE TABLAS-------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'tipo_medio_pago')
DROP TABLE DATA_BRIGADE.tipo_medio_pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'medio_pago')
DROP TABLE DATA_BRIGADE.medio_pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'categoria')
DROP TABLE data_brigade.categoria
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'sub_categoria')
DROP TABLE data_brigade.sub_categoria
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'marca')
DROP TABLE data_brigade.marca
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'producto_x_promocion')
DROP TABLE data_brigade.producto_x_promocion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'producto')
DROP TABLE data_brigade.producto
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'regla')
DROP TABLE data_brigade.regla
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'promocion')
DROP TABLE data_brigade.promocion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ticket_det_x_promocion')
DROP TABLE data_brigade.ticket_det_x_promocion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ticket_det')
DROP TABLE data_brigade.ticket_det
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'estado_envio')
DROP TABLE data_brigade.estado_envio
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'envio')
DROP TABLE data_brigade.envio
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'tipo_caja')
DROP TABLE data_brigade.tipo_caja
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'caja')
DROP TABLE data_brigade.caja
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'sucursal')
DROP TABLE data_brigade.sucursal
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'supermercado')
DROP TABLE data_brigade.supermercado
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'empleado')
DROP TABLE data_brigade.empleado
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'ticket')
DROP TABLE data_brigade.ticket
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'descuento')
DROP TABLE data_brigade.descuento
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'medio_pago_descuento_aplicado')
DROP TABLE data_brigade.medio_pago_descuento_aplicado
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'detalle_pago')
DROP TABLE data_brigade.detalle_pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'pago')
DROP TABLE data_brigade.pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'cliente')
DROP TABLE data_brigade.cliente
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'localidad')
DROP TABLE data_brigade.localidad
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'provincia')
DROP TABLE data_brigade.provincia
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'direccion')
DROP TABLE data_brigade.direccion

/*agregar faltantes*/

PRINT '**** Tablas dropeados correctamente ****';

--DROP PREVENTIVO DE SCHEMA-------------------------
IF EXISTS (SELECT name FROM sys.schemas WHERE name = 'DATA_BRIGADE')
DROP SCHEMA DATA_BRIGADE
GO

--CREACION DE SCHEMA--------------------------------
CREATE SCHEMA DATA_BRIGADE;
GO

--CREACION DE TABLAS--------------------------------
CREATE TABLE DATA_BRIGADE.sucursal(
    ID_SUCURSAL int IDENTITY PRIMARY KEY,
    SUCURSAL_NOMBRE nvar
    SUPER_CUIT int Rchar(255) null,EFERENCES DATA_BRIGADnot null,
    ID_DIRECCION int REFERENCES DATA_BRIGADE.direccion E.supermercado 
);
CREATE TABLE DATA_BRIGADE.caja(
    CAJA_NUMERO int IDENTITY PRIMARY KEY,

CREATE TABLE DATA_BRIGADE.tipo_medio_pago(
	ID_TIPO_MEDIO_PAGO int IDENTITY PRIMARY KEY,
	NOMBRE nvarchar(255) null, 
);

CREATE TABLE DATA_BRIGADE.medio_pago (
	ID_MEDIO_PAGO int IDENTITY PRIMARY KEY,
	NOMBRE nvarchar(255) null,
    ID_TIPO_MEDIO_PAGO int REFERENCES DATA_BRIGADE.tipo_medio_pago not null,
);

CREATE TABLE DATA_BRIGADE.pago (
	ID_PAGO int IDENTITY PRIMARY KEY,
    PAGO_FECHA datetime2(3),
    PAGO_DETALLE nvarchar(255) null,
    ID_MEDIO_PAGO int REFERENCES DATA_BRIGADE.medio_pago
    TICKET_NUMERO int REFERENCES DATA_BRIGADE.ticket not null,

);

    ID_CAJA_TIPO int REFERENCES DATA_BRIGADE.tipo_caja,
    ID_SUCURSAL int IDENTITY PRIMARY KEY REFERENCES DATA_BRIGADE.sucursal 
);
CREATE TABLE DATA_BRIGADE.empleado(
    ID_EMPLEADO int IDENTITY PRIMARY KEY,
  
CREATE TABLE DATA_BRIGADE.tipo_caja(
	ID_CAJA_TIPO int IDENTITY PRIMARY KEY,
	CAJA_TIPO_NOMBRE nvarchar(255) null,
);
  EMPLEADO_DNI int null,
    EMPLEADO_NOMBRE nvarchar(255) null,
    EMPLEADO_APELLIDO nvarchar(255) null,
    EMPLEADO_FECHA_REGISTRO datetime2(3) null,
    EMPLEADO_TELEFONO int,
    EMPLEADO_EMAIL nvarchar(255) null,
    EMPLEADO_FECHA_NACIMIENTO datetime2(3) null,
    ID_SUCURSAL int IDENTITY PRIMARY KEY REFERENCES DATA_BRIGADE.sucursal 
);
CREATE TABLE DATA_BRIGADE.envio(
    CAJA_NUMERO int IDENTITY PRIMARY KEY,
    ID_CAJA_TIPO int REFERENCES DATA_BRIGADE.tipo_caja,
    ID_SUCURSAL int IDENTITY PRIMARY KEY REFERENCES DATA_BRIGADE.sucursal 
);
CREATE TABLE DATA_BRIGADE.ticket(
	TICKET_NUMERO int IDENTITY PRIMARY KEY,
	T
CREATE TABLE DATA_BRIGADE.estado_envio(
    ID_ESTADO int IDENTITY PRIMARY KEY,
    ESTADO nvarchar(255) null
);ICKET_FECHA_HORA nvarchar(255) null,
	TICKET_TIPO_COMPROBANTE nvarchr(255) null,
    ID_PAGO int REFERENCES DATA_BRIGADE.pago not null,
	TICudESCUENTO_APLICADO_MP decimal(18,2) null,
	TICID_ENVIOT_TOTAL_ENVIO decimal(18,2) null,
	TICENVIO_COSTOCdecimal(18,2) null
	ID_ENVIO_FECHA_PROGRAMADA datetime2(3) null,
    ENVeESTADO int REFERENCES DATA_BRIGADE.estado_envioIO_HORA_NICIdatTtime2 nul,ENV null,
    ID_IO_HORA_FIN datatime2(3) null,
    ENVIO_FECHA_ENTREGA datetime2(3)
    CAJA_NUMERO int REFERENCES DATA_BRIGADE.caja not null,
    CLIENTE_DNI int null,
    ID_ENVIO int REFERENCES DATA_BRIGADE.envio not null,
);

CREATE TABLE DATA_BRIGADE.ticket_det(
	ID_TICKET_DET int IDENTITY PRIMARY KEY,
	TICKET_DET_CANTIDAD int null,
    TICKET_DET_PRECIO decimal(18,2),
    TICKET_DET_TOTAL decimal(18,2),
    TICKET_NUMERO int REFERENCES DATA_BRIGADE.ticket not null, 
    ID_PRODUCTO int REFERENCES DATA_BRIGADE.producto not null
);

CREATE TABLE DATA_BRIGADE.tipo_medio_pago(
	ID_TIPO_MEDIO_PAGO int IDENTITY PRIMARY KEY,
	NOMBRE nvarchar(255) null, 
);

CREATE TABLE DATA_BRIGADE.tipo_caja(
	ID_CAJA_TIPO int IDENTITY PRIMARY KEY,

CREATE TABLE DATA_BRIGADE.supermercado(
	ID_SUPER int IDENTITY PRIMARY KEY,
    SUPER_NOMBRE nvarchar(50) null,
    SUPER_RAZON_SOC nvarchar(50) null,
    SUPER_RAZON_SOC nvarchar(50) null,

	TICKET_DET_CANTIDAD int null,
    TICKET_DET_PRECIO decimal(18,2),
    TICKET_DET_TOTAL decimal(18,2),
    TICKET_NUMERO int REFERENCES DATA_BRIGADE.ticket not null, 
    ID_PRODUCTO int REFERENCES DATA_BRIGADE.producto not null
);

/********* Creacion de StoredProcedures para migracion *********/
--Estado Reclamo
create procedure NO_SE_BAJA_NADIE.Migrar_estados_reclamos
as
begin 
insert into NO_SE_BAJA_NADIE.estado_reclamo(ESTADO)
select distinct M.RECLAMO_ESTADO
from gd_esquema.Maestra as M
	--where M.RECLAMO_ESTADO is not null
end
go
