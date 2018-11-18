CREATE TABLE Propietario(
	CodPropietario INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nombre		   VARCHAR(20),
	Apellido	   VARCHAR(20),
	Direccion	   VARCHAR(50),
	Telefono	   INT CHECK(Telefono <= 999999999 and Telefono >100000000),
	DNI			   INT CHECK(DNI <= 99999999 and DNI >10000000),
)

CREATE TABLE Categoria(
	CodCategoria INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	NombreCategoria VARCHAR(20)
)

CREATE TABLE Empleado(
	CodEmpleado			INT NOT NULL IDENTITY(100, 1) PRIMARY KEY,
	Nombre				VARCHAR (20),
	Apellido			VARCHAR (20),
	Dirección			VARCHAR (50),
	Telefono			INT CHECK(Telefono <= 999999999 and Telefono >100000000),
	DNI					INT CHECK(DNI <= 99999999 and DNI > 10000000),
	Cargo				BIT,
	[Sueldo/Hora (S/.)]	INT
)

CREATE TABLE Equipo(
	CodEquipo    CHAR(5) NOT NULL PRIMARY KEY,
	NombreEquipo VARCHAR (20)
)

CREATE TABLE [Equipo Operario](
	CodOperario INT NOT NULL REFERENCES Empleado,
	CodEquipo   CHAR(5) NOT NULL REFERENCES Equipo,
	PRIMARY KEY (CodOperario,CodEquipo) 
)

CREATE TABLE Vehiculo(
	Placa			    CHAR(6) NOT NULL PRIMARY KEY,
	Categoria	        INT FOREIGN KEY REFERENCES Categoria,
	CodPropietario      INT FOREIGN KEY REFERENCES Propietario,
	Marca			    VARCHAR(20),
	Modelo			    VARCHAR(20),
	[Año de fab.]       INT,
	Kilometraje		    INT,
	Combustible		    VARCHAR(20),
	[VIN/N° de serie]   VARCHAR(20),
	[N° de motor]	    VARCHAR(20),
	Carroceria		    VARCHAR(20),
	[N° ejes]		    INT,
	[N° ruedas]	        INT,
	[N° asientos]		INT,
	[N° pasajeros]		INT,
	[Largo (m)]			DECIMAL,
	[Ancho (m)]			DECIMAL,
	[Alto  (m)]			DECIMAL,
	[Color(es)]			VARCHAR(20),
	[Peso Neto (kg.)]	INT,
	[Peso bruto	(kg.)]	INT,
	[Carga útil (kg.)]	INT
)

CREATE TABLE [Tipo Luz](
    CodTipoLuces CHAR(5) NOT NULL PRIMARY KEY,
    NomTipoL	 VARCHAR(20)
)

CREATE TABLE [Prueba de Luces](
	CodPruebaLuces CHAR(5) NOT NULL PRIMARY KEY,
	MedidaObtenidaDer DECIMAL,
	MedidaObtenidaIzq DECIMAL,
	Alineamiento BIT,
	Resultado BIT NOT NULL,
	CodTipoLuces CHAR(5) FOREIGN KEY REFERENCES [Tipo Luz]
)

CREATE TABLE Eje(
	CodEje INT IDENTITY (1,1) NOT NULL,
	#Eje INT NOT NULL,
	Peso INT NOT NULL,
	PRIMARY KEY (CodEje)
)

CREATE TABLE [Prof de Neumaticos] (
	CodProfNeumatico	INT NOT NULL IDENTITY (1,1),
	CodEje				INT FOREIGN KEY REFERENCES Eje,
	MedidaObtenida		DECIMAL, 
	Resultado			BIT NOT NULL,
	PRIMARY KEY (CodProfNeumatico, CodEje) 
)

CREATE TABLE [Prueba de Alineamiento](
	CodAlineamiento INT NOT NULL IDENTITY (1,1),
	CodEje INT FOREIGN KEY REFERENCES Eje,
	Desviacion DECIMAL,
	Resultado BIT NOT NULL,
	PRIMARY KEY (CodAlineamiento, CodEje)
)

CREATE TABLE [Emisiones de Gases](
	CodEmisionGases  CHAR(5) NOT NULL PRIMARY KEY,
	TAceite			 INT,
	RPM				 INT,
	Opacidad		 INT,
	CoRalenti		 DECIMAL,
	CoCo2Ralenti     DECIMAL,
	HCRalenti		 DECIMAL,
	CoAcel			 DECIMAL,
	CoCo2Acel		 DECIMAL,
	HcAcel			 DECIMAL,
	Resultado	     BIT
)

CREATE TABLE [Emisiones Sonoras](
	CodEmisionSonoras CHAR(5) NOT NULL PRIMARY KEY,
	[Sonometro (dB)] DECIMAL,
	Resultado BIT
)

CREATE TABLE Seccion(
	CodSeccion INT,
	NomSeccion VARCHAR (50),
	PRIMARY KEY (CodSeccion)
)

CREATE TABLE [Prueba de Freno](
	CodPruebaFreno INT NOT NULL,
	CodSeccion	   INT FOREIGN KEY REFERENCES Seccion,
	CodEje		   INT FOREIGN KEY REFERENCES Eje,
	FuerzaFrenadoD DECIMAL,
	FuerzaFrenadoI DECIMAL,
	Eficiencia	   DECIMAL,
	Desequilibrio  DECIMAL, 
	Resultado	   VARCHAR(50)
	CONSTRAINT PK_PruebaFreno PRIMARY KEY (CodPruebaFreno, CodSeccion, CodEje)
)

CREATE TABLE Posicion(
	CodPosicion	CHAR(2) NOT NULL,
	NomPosicion	VARCHAR(20) NOT NULL,
	PRIMARY KEY (CodPosicion)
)

CREATE TABLE [Prueba de Suspencion](
	CodSusp			CHAR(5) NOT NULL,
	CodPosicion		CHAR(2) NOT NULL FOREIGN KEY REFERENCES Posicion,
	Izquierda	DECIMAL(4),
	Derecha		DECIMAL(4),
	Desviacion	DECIMAL(4),
	Resultado   DECIMAL(4),
	PRIMARY KEY (CodSusp, CodPosicion)
)

CREATE TABLE Observacion(
	CodObs				 CHAR(5) NOT NULL,
	IntepretaciónDefecto VARCHAR(50),
	Calificacion		 VARCHAR(50),
	PRIMARY KEY (CodObs)
)

CREATE TABLE InformeInspeccion(
	CodInspeccion		CHAR(5) NOT NULL PRIMARY KEY,
	CodPruebaLuces		CHAR(5) FOREIGN KEY REFERENCES [Prueba de Luces],
	CodEmisionGases		CHAR(5) FOREIGN KEY REFERENCES [Emisiones de Gases],
	CodEmisionSonoras   CHAR(5) FOREIGN KEY REFERENCES [Emisiones Sonoras],
	CodPropietario		INT FOREIGN KEY REFERENCES Propietario,
	Placa				CHAR(6)	FOREIGN KEY REFERENCES Vehiculo,
	FechaInspeccion		DATE
)

CREATE TABLE [Observacion Inspeccion](
	CodObs CHAR(5) FOREIGN KEY REFERENCES Observacion,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
)

CREATE TABLE [PruebaSuspencion Inspeccion](
	CodSusp	CHAR(5) NOT NULL,
	CodPosicion	CHAR(2) NOT NULL,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	FOREIGN KEY (CodSusp, CodPosicion) REFERENCES [Prueba de Suspencion]
)

CREATE TABLE [PruebaFreno Inspeccion](
	CodPruebaFreno		INT NOT NULL,
	CodSeccion			INT NOT NULL,
	CodEje				INT,
	CodInspeccion		CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	FOREIGN KEY (CodPruebaFreno,CodSeccion,CodEje) REFERENCES [Prueba de Freno]
)

CREATE TABLE [Alineamiento Inspeccion](
	CodAlineamiento INT NOT NULL,
	CodEje INT NOT NULL,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	FOREIGN KEY (CodAlineamiento, CodEje) REFERENCES [Prueba de Alineamiento]
)

CREATE TABLE [PNeumaticos Inspeccion](
	CodProfNeumatico INT NOT NULL,
	CodEje INT NOT NULL,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	FOREIGN KEY (CodProfNeumatico, CodEje) REFERENCES [Prof de Neumaticos]
)

CREATE TABLE [Inspeccion Equipo](
	CodEquipo     CHAR(5) FOREIGN KEY REFERENCES Equipo,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion
)

CREATE TABLE TipoCertificado(
	CodTipoCertificado INT NOT NULL ,
	NombreCertificado  VARCHAR(50),
	PRIMARY KEY (CodTipoCertificado)
)

CREATE TABLE Certificado(
	CodCertificado	    INT NOT NULL,
	Placa CHAR(6)	    FOREIGN KEY REFERENCES Vehiculo, 
	CodPropietario	    INT FOREIGN KEY REFERENCES Propietario,
	CodTipoCertificado  INT FOREIGN KEY REFERENCES TipoCertificado,
	Resultado		    VARCHAR(10),
	VigenciaCertificado VARCHAR(10),
	FecProxInspección   DATE,
	CodInspeccion		CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	CodEmpleado			INT FOREIGN KEY REFERENCES Empleado,
	PRIMARY KEY (CodCertificado)
)
