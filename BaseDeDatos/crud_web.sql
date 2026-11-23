-- =====================================================
--  Base de datos para el ejemplo CRUD (ASP.NET + MySQL)
--  Cómo ejecutarlo:
--    * MySQL Workbench: abrir este archivo y presionar el rayo
--    * Consola:  mysql -u root -p < crud_web.sql
--  OJO: borra y vuelve a crear las tablas (se pierden los datos).
-- =====================================================

-- 1. Crear la base de datos (solo si no existe)
CREATE DATABASE IF NOT EXISTS crud_web
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 2. Indicar que vamos a trabajar con ella
USE crud_web;

-- 3. Borrar las tablas si ya existían (al borrar una tabla se borran sus triggers)
DROP TABLE IF EXISTS auditoria;
DROP TABLE IF EXISTS estudiantes;

-- 4. Tabla principal: estudiantes
CREATE TABLE estudiantes (
    id       INT AUTO_INCREMENT PRIMARY KEY,  -- se genera solo: 1, 2, 3...
    nombre   VARCHAR(50)  NOT NULL,
    apellido VARCHAR(50)  NOT NULL,
    correo   VARCHAR(100) NOT NULL,
    carrera  VARCHAR(100) NOT NULL,
    edad     INT          NOT NULL,

    -- Fechas de auditoría: MySQL las llena SOLO, no hay que enviarlas desde C#
    fecha_creacion      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 5. Tabla de auditoría: guarda el HISTORIAL de todo lo que pasa
CREATE TABLE auditoria (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    accion        VARCHAR(20)  NOT NULL,   -- CREAR, ACTUALIZAR o ELIMINAR
    estudiante_id INT          NOT NULL,   -- a qué estudiante le pasó
    descripcion   VARCHAR(255) NOT NULL,   -- texto para mostrar
    fecha         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 6. TRIGGERS: se ejecutan SOLOS después de cada INSERT, UPDATE o DELETE
--    NEW = la fila nueva     OLD = la fila como estaba antes
CREATE TRIGGER trg_estudiantes_crear AFTER INSERT ON estudiantes
FOR EACH ROW
    INSERT INTO auditoria (accion, estudiante_id, descripcion)
    VALUES ('CREAR', NEW.id, CONCAT('Se registró a ', NEW.nombre, ' ', NEW.apellido));

CREATE TRIGGER trg_estudiantes_actualizar AFTER UPDATE ON estudiantes
FOR EACH ROW
    INSERT INTO auditoria (accion, estudiante_id, descripcion)
    VALUES ('ACTUALIZAR', NEW.id, CONCAT('Se actualizó a ', NEW.nombre, ' ', NEW.apellido));

CREATE TRIGGER trg_estudiantes_eliminar AFTER DELETE ON estudiantes
FOR EACH ROW
    INSERT INTO auditoria (accion, estudiante_id, descripcion)
    VALUES ('ELIMINAR', OLD.id, CONCAT('Se eliminó a ', OLD.nombre, ' ', OLD.apellido));

-- 7. Algunos datos de ejemplo (los triggers ya los anotan en la auditoría)
INSERT INTO estudiantes (nombre, apellido, correo, carrera, edad) VALUES
('Ana',   'Gómez', 'ana.gomez@correo.com',   'Ingeniería en Sistemas', 20),
('Luis',  'Pérez', 'luis.perez@correo.com',  'Administración',         22),
('María', 'López', 'maria.lopez@correo.com', 'Diseño Gráfico',         19);

-- 8. Comprobar que todo quedó bien
SELECT * FROM estudiantes;
SELECT * FROM auditoria;
