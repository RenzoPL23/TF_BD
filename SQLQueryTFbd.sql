CREATE TABLE Propietario(
	CodPropietario CHAR(5) NOT NULL PRIMARY KEY,
	Nombre VARCHAR(20),
	Apellido VARCHAR (20),
	Direccion VARCHAR (50),
	Telefono INT,
	DNI INT,
	email VARCHAR (50)
)

CREATE TABLE TipoVehiculo(
	CodTipoVehiculo CHAR(5) NOT NULL PRIMARY KEY,
	NombreTipoVehiculo VARCHAR(20)
)

CREATE TABLE Empleado(
	CodEmpleado CHAR(10) NOT NULL PRIMARY KEY,
	Nombre VARCHAR (20),
	Apellido VARCHAR (20),
	Dirección VARCHAR (50),
	telefono INT,
	DNI INT,
)

CREATE TABLE IngSupervisor(
	CodIngsup CHAR(10) NOT NULL PRIMARY KEY,
	CodEmpleado CHAR(10) NOT NULL FOREIGN KEY REFERENCES Empleado,
	NumAcreditacion INT NOT NULL,
	HoraIngeniero INT 
)
CREATE TABLE Operario(
	CodOperario CHAR(10) NOT NULL PRIMARY KEY,
	CodEmpleado CHAR(10) NOT NULL FOREIGN KEY REFERENCES Empleado,
	HoraOperario INT
)
CREATE TABLE Area(
	CodArea CHAR(10) NOT NULL PRIMARY KEY,
	nombre VARCHAR(10)
)

CREATE TABLE Equipo(
	CodEquipo CHAR(5) NOT NULL PRIMARY KEY,
	CodArea CHAR(10) FOREIGN KEY REFERENCES Area,
	TipoEquipo VARCHAR (20),
	NombreEquipo VARCHAR (20)
)

CREATE TABLE [Equipo Operario](
	CodOperario CHAR(10) NOT NULL REFERENCES Operario,
	CodEquipo CHAR(5) NOT NULL REFERENCES Equipo,
	PRIMARY KEY (CodOperario,CodEquipo) 
)

CREATE TABLE Vehiculo(
	Placa CHAR(6) NOT NULL PRIMARY KEY,
	CodTipoVehiculo CHAR(5) FOREIGN KEY REFERENCES TipoVehiculo,
	CodPropietario CHAR(5) FOREIGN KEY REFERENCES Propietario,
	Categoria VARCHAR(20),
	Marca VARCHAR(20),
	Modelo VARCHAR (20),
	AñoFabricacion INT,
	Kilometraje INT,
	Combustible VARCHAR (20),
	NumSerie VARCHAR(20),
	NumMotor VARCHAR(20),
	Carroceria VARCHAR(20),
	NumEjes INT,
	Ruedas INT,
	Asientos_Pasajeros VARCHAR(10),
	Largo_Ancho_Alto VARCHAR(20),
	Color VARCHAR (20),
	PesoNeto INT,
	PesoBruto INT,
	CargaUtil INT
)

CREATE TABLE InformeInspeccion(
	CodInspeccion CHAR(5) NOT NULL PRIMARY KEY,
	CodPruebaLuces CHAR(5),
	CodSusp CHAR,
	CodPropietario CHAR(5),
	Placa CHAR(6) FOREIGN KEY REFERENCES Vehiculo,
	FechaInspeccion DATE
)

CREATE TABLE [Prueba de Neumaticos](
	CodPruebaNeumaticos CHAR(5) NOT NULL PRIMARY KEY,
	CodInspeccion CHAR(5)
	FOREIGN KEY (CodInspeccion) REFERENCES InformeInspeccion
)

CREATE TABLE InformeEquipo(
	CodEquipo CHAR(5) FOREIGN KEY REFERENCES Equipo,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion
)

CREATE TABLE [Prueba de Luces](
	CodPruebaLuces CHAR(5) NOT NULL PRIMARY KEY,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion
)

CREATE TABLE [Prueba de Emision](
	CodPruebaEmision CHAR(5) NOT NULL PRIMARY KEY,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion
)

CREATE TABLE Gases(
	CodPruebaEmision CHAR(5) FOREIGN KEY REFERENCES [Prueba de Emision],
	TAceite INT,
	RPM INT,
	Opacidad INT,
	CoRalenti INT,
	CoCo2Ralenti INT,
	HCRalenti INT,
	CoAcel INT,
	CoCo2Acel INT,
	HcAcel INT,
	ResultadoGases BINARY
)

CREATE TABLE Observacion(
	CodObs CHAR(5) NOT NULL,
	IntepretaciónDefecto VARCHAR(50),
	Calificacion VARCHAR(50),
	PRIMARY KEY (CodObs)
)

CREATE TABLE InspeccionObservacion(
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	CodObs CHAR(5) FOREIGN KEY REFERENCES Observacion
)

CREATE TABLE Eje(
	#Eje INT NOT NULL,
	Peso INT NOT NULL,
	PRIMARY KEY (#Eje)
)

CREATE TABLE ProfNeumaticos (
	CodProfNeumatico INT NOT NULL IDENTITY (1,1),
	NumEje INT FOREIGN KEY REFERENCES Eje, 
	CodPruebaNeumaticos CHAR(5) FOREIGN KEY REFERENCES [Prueba de Neumaticos],
	MedidaObtenida INT, 
	Resultado VARCHAR(50),
	PRIMARY KEY (CodProfNeumatico) 
)

CREATE TABLE [Prueba de Alineamiento](
	CodPAlineamiento INT NOT NULL IDENTITY (1,1),
	NumEje INT FOREIGN KEY REFERENCES Eje, 
	CodPruebaNeumaticos CHAR(5) FOREIGN KEY REFERENCES [Prueba de Neumaticos],
	Desviacion INT,
	Resultado VARCHAR(50)
)

CREATE TABLE Seccion(
	CodSeccion INT,
	NomSeccion VARCHAR (50),
	PRIMARY KEY (CodSeccion)
)

CREATE TABLE [Prueba de Freno](
	CodPruebaFreno INT IDENTITY (1,1),
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	PRIMARY KEY (CodPruebaFreno)
)

CREATE TABLE DetallePruebadeFreno(
	CodPruebaFreno INT FOREIGN KEY REFERENCES [Prueba de Freno],
	CodSeccion INT FOREIGN KEY REFERENCES Seccion,
	CodInspeccion CHAR(5) REFERENCES InformeInspeccion,
	FuerzaFrenadoD INT,
	FuerzaFrenadoI INT,
	Eficiencia INT,
	Desequilibrado INT, 
	Resultado VARCHAR(50)
)

CREATE TABLE Posicion(
	CodPosicion	 CHAR(5) NOT NULL,
	NomPosicion	 VARCHAR(40) NOT NULL,
	Izquierda VARCHAR(10),
	Derecha	VARCHAR(10),
	Desviacion VARCHAR(25),
	Resultado VARCHAR(25),
	PRIMARY KEY (CodPosicion)
)

CREATE TABLE [Prueba de Suspencion](
	CodSusp	 CHAR(5) NOT NULL PRIMARY KEY,
	ResultadoFinal	BINARY NOT NULL,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	CodPosicion CHAR(5) FOREIGN KEY REFERENCES Posicion
)

CREATE TABLE [Tipo Luz](
  CodTipoLuces	CHAR(5) NOT NULL PRIMARY KEY,
  NomTipoL	VARCHAR(20)
)

CREATE TABLE [Detalle Prueba de Luces](
	CodTipoL CHAR(5) NOT NULL,
	MedidaObtenidaDer DECIMAL,
	MedidaObtenidaIzq DECIMAL,
	Alineamiento BINARY,
	Resultado BINARY,
	PRIMARY KEY (CodTipoL),
	CodPruebaLuces CHAR(5) FOREIGN KEY REFERENCES [Prueba de Luces],
	CodTipoLuces CHAR(5) FOREIGN KEY REFERENCES [Tipo Luz]
)

CREATE TABLE TipoCertificado(
	CodTipoCertificado INT NOT NULL ,
	NombreCertificado VARCHAR(50),
	PRIMARY KEY (CodTipoCertificado)
)

CREATE TABLE Certificado(
	CodCertificado INT NOT NULL,
	Placa CHAR(6) FOREIGN KEY REFERENCES Vehiculo, 
	CodPropietario CHAR(5) FOREIGN KEY REFERENCES Propietario,
	CodTipoCertificado INT FOREIGN KEY REFERENCES TipoCertificado,
	Resultado VARCHAR(10),
	VigenciaCertificado VARCHAR(10),
	FecProxInspección DATE,
	CodInspeccion CHAR(5) FOREIGN KEY REFERENCES InformeInspeccion,
	CodEmpleado CHAR(10) FOREIGN KEY REFERENCES Empleado,
	PRIMARY KEY (CodCertificado)
)