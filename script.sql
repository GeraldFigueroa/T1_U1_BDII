-- Crear una nueva base de datos llamada 'Vacaciones'.
USE master;
GO

-- Eliminarla si ya existe.
DROP DATABASE IF EXISTS Vacaciones;
GO

-- Creación de la base de datos.
CREATE DATABASE Vacaciones;
GO



-- Crear la tabla llamada Aerolinea
CREATE TABLE Vacaciones.Aerolinea
(
    codigo_aerolinea INT IDENTITY(1,1) NOT NULL, -- primary key
    nombre NVARCHAR(100) NOT NULL,
    descuento TINYINT CHECK (descuento >= 10) DEFAULT 10,
    CONSTRAINT PK_Aerolinea_Codigo PRIMARY KEY CLUSTERED(codigo_aerolinea) -- primary key constraint
);
GO


-- Crear la tabla llamada Cliente
CREATE TABLE Vacaciones.Cliente
(
    identidad CHAR(15) NOT NULL, -- primary key
    nombre NVARCHAR(100) NOT NULL,
    telefono CHAR(9) NOT NULL,
    CONSTRAINT PK_Cliente_id PRIMARY KEY CLUSTERED(identidad) -- primary key constraint
);
GO


-- Crear la tabla llamada Boleto
CREATE TABLE Vacaciones.Boleto
(
    codigo_boleto INT IDENTITY(1,1) NOT NULL, -- primary key
    identidad CHAR(15) NOT NULL,
    codigo_aerolinea INT NOT NULL,
    no_vuelo INT NOT NULL,
    fecha SMALLDATETIME DEFAULT CONVERT(SMALLDATETIME, GETDATE()),
    destino VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Boleto_Codigo PRIMARY KEY CLUSTERED(codigo_boleto), -- primary key constraint
    CONSTRAINT FK_Boleto_Cliente FOREIGN KEY (identidad) REFERENCES Vacaciones.Cliente(identidad), --foreign key constraint
    CONSTRAINT FK_Boleto_Aerolinea FOREIGN KEY (codigo_aerolinea) REFERENCES Vacaciones.Aerolinea(codigo_aerolinea), --foreign key constraint
    CONSTRAINT ck_destino CHECK(destino IN ('Mexico', 'Guatemala', 'Panama')) -- check constraint
);
GO


-- Crear la tabla llamada Hotel
CREATE TABLE Vacaciones.Hotel
(
    codigo_hotel INT IDENTITY(1,1) NOT NULL, -- primary key
    nombre NVARCHAR(100) NOT NULL,
    direccion NVARCHAR(200) NOT NULL
);
GO

-- Hotel primary key constraint 
ALTER TABLE Vacaciones.Hotel ADD CONSTRAINT PK_Hotel_Codigo 
PRIMARY KEY CLUSTERED (codigo_hotel);
GO 


-- Crear la tabla llamada Hotel
CREATE TABLE Vacaciones.Reservacion
(
    codigo_reservacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_hotel INT NOT NULL,
    identidad CHAR(15) NOT NULL,
    cantidad_personas TINYINT NOT NULL DEFAULT 0,
    fecha_entrada SMALLDATETIME NOT NULL,
    fecha_salida SMALLDATETIME NOT NULL
);
GO

-- Reservacion-Hotel foreign key constraint
ALTER TABLE Vacaciones.Reservacion ADD CONSTRAINT fk_reserv_hotel
FOREIGN KEY (codigo_hotel) REFERENCES Vacaciones.Hotel(codigo_hotel);
GO

-- Reservacion-Cliente foreign key constraint
ALTER TABLE Vacaciones.Reservacion ADD CONSTRAINT fk_reserv_cliente
FOREIGN KEY (identidad) REFERENCES Vacaciones.Cliente(identidad);   
GO

