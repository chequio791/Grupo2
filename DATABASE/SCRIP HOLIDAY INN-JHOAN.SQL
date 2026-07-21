-- =============================================
-- BASE DE DATOS: Sistema de Gestión de Mantenimiento de Habitaciones
-- =============================================

CREATE TABLE Rol (
    idRol INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Usuario (
    IdUsuario INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    cedula INT NOT NULL UNIQUE,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    Contrasenha VARCHAR(255) NOT NULL,
    Rol INT NOT NULL,
    FOREIGN KEY (Rol) REFERENCES Rol(idRol)
);

CREATE TABLE Habitacion (
    IdHabitacion INT PRIMARY KEY AUTO_INCREMENT,
    Numero INT NOT NULL,
    Piso INT NOT NULL,
    Tipo VARCHAR(50) NOT NULL,           -- Ej: Individual, Doble, Suite
    Estado VARCHAR(30) NOT NULL          -- Ej: Disponible, Ocupada, Mantenimiento
);

CREATE TABLE Ordenes (
    IdOrden INT PRIMARY KEY AUTO_INCREMENT,
    FechadeCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Descripcion TEXT NOT NULL,
    Estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',  -- Pendiente, En Proceso, Terminada, Cancelada
    FotoInicial VARCHAR(512),
    FotoFinal VARCHAR(512),
    Habitacion INT NOT NULL,
    idusuario INT NOT NULL,
    FOREIGN KEY (Habitacion) REFERENCES Habitacion(IdHabitacion),
    FOREIGN KEY (idusuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Evaluacion (
    IdEvaluacion INT PRIMARY KEY AUTO_INCREMENT,
    Fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Calificacion BOOLEAN NOT NULL,           -- TRUE = Aprobado, FALSE = No Aprobado
    Observaciones TEXT,
    idusuario INT NOT NULL,
    idordenes INT NOT NULL,
    FOREIGN KEY (idusuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (idordenes) REFERENCES Ordenes(IdOrden)
);

CREATE TABLE Evidencias (
    idEvidencia INT PRIMARY KEY AUTO_INCREMENT,
    tipo_Archivo VARCHAR(100) NOT NULL,
    fecha_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observaciones TEXT,
    Evaluacion INT,
    FOREIGN KEY (Evaluacion) REFERENCES Evaluacion(IdEvaluacion)
);

CREATE TABLE Reporte (
    IdReporte INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(50) NOT NULL,               -- Ej: Mantenimiento, Habitaciones, General
    FechaGeneracion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    idusuario INT,
    FOREIGN KEY (idusuario) REFERENCES Usuario(IdUsuario)
);


-- =============================================
-- INSERTS DE EJEMPLO
-- =============================================

-- ==================== ROLES ====================
INSERT INTO Rol (nombre) VALUES 
('Administrador'), ('Supervisor'), ('Operario'), ('Técnico'), ('Recepcionista');

-- ==================== USUARIOS ====================
INSERT INTO Usuario (Nombre, cedula, Correo, Contrasenha, Rol) VALUES
('Carlos Rodríguez', 12345678, 'carlos.admin@hotel.com', '$2y$10$hashadmin123', 1),
('Ana Martínez', 87654321, 'ana.supervisor@hotel.com', '$2y$10$hashsupervisor', 2),
('Luis Gómez', 11223344, 'luis.operario@hotel.com', '$2y$10$hashoperario', 3),
('María Torres', 55667788, 'maria.tecnico@hotel.com', '$2y$10$hashtecnico', 4),
('José Ramírez', 99887766, 'jose.recepcion@hotel.com', '$2y$10$hashrecepcion', 5),
('Laura Sánchez', 33445566, 'laura.operario2@hotel.com', '$2y$10$hashoperario2', 3),
('Pedro Vargas', 77889900, 'pedro.tecnico2@hotel.com', '$2y$10$hashtecnico2', 4);

-- ==================== HABITACIONES ====================
INSERT INTO Habitacion (Numero, Piso, Tipo, Estado) VALUES
(101, 1, 'Individual', 'Disponible'),
(102, 1, 'Doble', 'Mantenimiento'),
(201, 2, 'Doble', 'Ocupada'),
(202, 2, 'Suite', 'Disponible'),
(301, 3, 'Individual', 'Mantenimiento'),
(302, 3, 'Doble', 'Disponible'),
(401, 4, 'Suite', 'Ocupada'),
(402, 4, 'Doble', 'Mantenimiento'),
(501, 5, 'Individual', 'Disponible'),
(502, 5, 'Doble', 'Mantenimiento'),
(601, 6, 'Suite', 'Ocupada'),
(602, 6, 'Doble', 'Disponible'),
(701, 7, 'Individual', 'Mantenimiento'),
(702, 7, 'Doble', 'Disponible');

-- ==================== ORDENES DE TRABAJO ====================
INSERT INTO Ordenes (Descripcion, Estado, FotoInicial, Habitacion, idusuario, FechadeCreacion) VALUES
('Falla en el aire acondicionado - no enfría', 'Pendiente', 'fotos/inicial/aire601.jpg', 601, 1, '2026-03-20 08:15:00'),
('Fuga de agua en el baño principal', 'En Proceso', 'fotos/inicial/fuga202.jpg', 202, 2, '2026-03-20 09:30:00'),
('Revisión y limpieza de minibar', 'Terminada', 'fotos/inicial/minibar301.jpg', 301, 3, '2026-03-21 10:45:00'),
('Cambio de bombillos en toda la habitación', 'Terminada', 'fotos/inicial/bombillos401.jpg', 401, 1, '2026-03-21 11:20:00'),
('Problema con cerradura electrónica', 'Pendiente', 'fotos/inicial/cerradura502.jpg', 502, 4, '2026-03-22 14:10:00'),
('Ruido excesivo en el ventilador de techo', 'En Proceso', 'fotos/inicial/ventilador602.jpg', 602, 2, '2026-03-22 15:00:00'),
('Falla en la ducha (poca presión)', 'Terminada', 'fotos/inicial/ducha701.jpg', 701, 3, '2026-03-23 08:50:00'),
('Televisor sin señal', 'Terminada', 'fotos/inicial/tv102.jpg', 102, 1, '2026-03-23 09:30:00'),
('Control remoto dañado', 'Pendiente', NULL, 302, 4, '2026-03-24 10:15:00'),
('Problema eléctrico en enchufes', 'En Proceso', 'fotos/inicial/enchufe402.jpg', 402, 2, '2026-03-24 11:40:00'),
('Mantenimiento preventivo de aire acondicionado', 'Terminada', 'fotos/inicial/preventivo501.jpg', 501, 3, '2026-03-25 13:25:00'),
('Fuga en lavamanos', 'Pendiente', 'fotos/inicial/lavamanos702.jpg', 702, 1, '2026-03-25 14:50:00'),
('Revisión general de habitación', 'Terminada', 'fotos/inicial/general101.jpg', 101, 4, '2026-03-26 07:55:00'),
('Cambio de lámpara de noche', 'En Proceso', NULL, 201, 2, '2026-03-26 16:30:00'),
('Problema con puerta corrediza', 'Pendiente', 'fotos/inicial/puerta601.jpg', 601, 3, '2026-03-27 09:10:00');

-- ==================== EVALUACIONES ====================
INSERT INTO Evaluacion (Fecha, Calificacion, Observaciones, idusuario, idordenes) VALUES
('2026-03-21 17:45:00', TRUE,  'Trabajo excelente y rápido', 1, 3),
('2026-03-22 12:30:00', TRUE,  'Buen servicio, cliente satisfecho', 2, 4),
('2026-03-23 18:20:00', FALSE, 'Faltó detalle en la limpieza final', 1, 7),
('2026-03-24 15:10:00', TRUE,  'Solución efectiva', 3, 8),
('2026-03-25 19:00:00', TRUE,  'Muy buen trabajo técnico', 2, 11),
('2026-03-26 11:55:00', FALSE, 'Demora en la respuesta inicial', 4, 13),
('2026-03-27 14:40:00', TRUE,  'Todo en orden', 1, 1);

-- ==================== EVIDENCIAS ====================
INSERT INTO Evidencias (tipo_Archivo, fecha_envio, observaciones, Evaluacion) VALUES
('image/jpeg', '2026-03-21 17:50:00', 'Foto del aire acondicionado después de la reparación', 1),
('image/jpeg', '2026-03-22 12:35:00', 'Evidencia de bombillos cambiados', 2),
('image/jpeg', '2026-03-23 18:25:00', 'Ducha antes de la reparación', 3),
('image/jpeg', '2026-03-24 15:15:00', 'Televisor funcionando correctamente', 4),
('image/jpeg', '2026-03-25 19:05:00', 'Filtro de aire limpio', 5),
('application/pdf', '2026-03-26 12:00:00', 'Reporte técnico de la revisión', 6);

-- ==================== REPORTES ====================
INSERT INTO Reporte (Tipo, FechaGeneracion, idusuario) VALUES
('Mantenimiento Mensual', '2026-03-25 18:00:00', 1),
('Habitaciones en Mantenimiento', '2026-03-26 09:30:00', 2),
('Órdenes por Prioridad', '2026-03-27 17:45:00', 1),
('Evaluaciones del Mes', '2026-03-28 08:15:00', 3);
