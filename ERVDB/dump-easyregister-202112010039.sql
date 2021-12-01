-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: easyregister
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adminconjunto`
--

DROP TABLE IF EXISTS `adminconjunto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminconjunto` (
  `identificacion` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  PRIMARY KEY (`identificacion`),
  UNIQUE KEY `adminconjunto_un` (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `apartamentos`
--

DROP TABLE IF EXISTS `apartamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartamentos` (
  `nApartamento` int NOT NULL,
  `propietario` varchar(100) NOT NULL,
  `residente` varchar(100) DEFAULT NULL,
  `torre` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `datafono` int DEFAULT NULL,
  `piso` varchar(100) NOT NULL,
  PRIMARY KEY (`nApartamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autorizacion`
--

DROP TABLE IF EXISTS `autorizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autorizacion` (
  `idAutorizacion` int NOT NULL AUTO_INCREMENT,
  `Autorizacion` varchar(100) NOT NULL,
  PRIMARY KEY (`idAutorizacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `idDireccion` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(100) NOT NULL,
  PRIMARY KEY (`idDireccion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `infoherramientas`
--

DROP TABLE IF EXISTS `infoherramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infoherramientas` (
  `idVisita` int NOT NULL,
  `herramientas_ingreso` varchar(100) DEFAULT NULL,
  `herramientas_salida` varchar(100) DEFAULT NULL,
  `empresa` varchar(100) NOT NULL,
  PRIMARY KEY (`idVisita`),
  CONSTRAINT `contratista_FK` FOREIGN KEY (`idVisita`) REFERENCES `visitas` (`idVisita`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoingreso`
--

DROP TABLE IF EXISTS `tipoingreso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoingreso` (
  `idTipoIngreso` int NOT NULL AUTO_INCREMENT,
  `tipoIngreso` varchar(100) NOT NULL,
  PRIMARY KEY (`idTipoIngreso`),
  UNIQUE KEY `tipoingreso_un` (`tipoIngreso`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipopersona`
--

DROP TABLE IF EXISTS `tipopersona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipopersona` (
  `idPersona` int NOT NULL AUTO_INCREMENT,
  `persona` varchar(100) NOT NULL,
  PRIMARY KEY (`idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculo` (
  `idVehiculo` int NOT NULL,
  `matricula_ingreso` longblob NOT NULL,
  `luces_ingreso` longblob NOT NULL,
  `espejos_ingreso` longblob NOT NULL,
  `pintura_ingreso` longblob NOT NULL,
  `matricula_salida` longblob,
  `luces_salida` longblob,
  `pintura_salida` longblob,
  `espejos_salida` longblob,
  `observaciones` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idVehiculo`),
  CONSTRAINT `vehiculo_FK` FOREIGN KEY (`idVehiculo`) REFERENCES `visitas` (`idVisita`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vigilantes`
--

DROP TABLE IF EXISTS `vigilantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vigilantes` (
  `identificacion` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  PRIMARY KEY (`identificacion`),
  UNIQUE KEY `vigilantes_un` (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visitas`
--

DROP TABLE IF EXISTS `visitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitas` (
  `idVisita` int NOT NULL AUTO_INCREMENT,
  `identificacion` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `destino` int NOT NULL,
  `tipoIngreso` int NOT NULL,
  `tarjetaVehiculo` varchar(100) DEFAULT NULL,
  `idAutorizacion` int NOT NULL,
  `ingreso` varchar(26) NOT NULL,
  `salida` varchar(26) DEFAULT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  `tipoPersona` int NOT NULL,
  PRIMARY KEY (`idVisita`),
  KEY `visitas_FK` (`destino`),
  KEY `visitas_FK_1` (`tipoPersona`),
  KEY `visitas_FK_2` (`tipoIngreso`),
  CONSTRAINT `visitas_FK` FOREIGN KEY (`destino`) REFERENCES `apartamentos` (`nApartamento`),
  CONSTRAINT `visitas_FK_1` FOREIGN KEY (`tipoPersona`) REFERENCES `tipopersona` (`idPersona`),
  CONSTRAINT `visitas_FK_2` FOREIGN KEY (`tipoIngreso`) REFERENCES `tipoingreso` (`idTipoIngreso`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'easyregister'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-01  0:39:14
