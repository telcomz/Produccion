-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS `emqx` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `emqx`;

-- Crear la tabla de usuarios MQTT
CREATE TABLE `mqtt_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `is_superuser` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- Insertar usuarios de ejemplo
INSERT INTO `mqtt_user` (username, password, is_superuser)
VALUES ('admin', SHA2('Control1982', 256), 1),
       ('telcomz', SHA2('Control1982', 256), 0);

-- Crear la tabla ACL (Access Control List)
CREATE TABLE `mqtt_acl` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `allow` int(1) NOT NULL COMMENT '0: deny, 1: allow',
  `ipaddr` varchar(60) DEFAULT NULL COMMENT 'IpAddress',
  `username` varchar(100) DEFAULT NULL COMMENT 'Username',
  `clientid` varchar(100) DEFAULT NULL COMMENT 'ClientId',
  `access` int(2) NOT NULL COMMENT '1: subscribe, 2: publish, 3: pubsub',
  `topic` varchar(255) NOT NULL COMMENT 'Topic Filter',
  PRIMARY KEY (`id`)
);

-- Insertar reglas ACL de ejemplo
INSERT INTO `mqtt_acl` (allow, ipaddr, username, clientid, access, topic)
VALUES 
       (1, NULL, 'admin', NULL, 3, '#'),
       (1, NULL, 'user1', NULL, 1, 'home/#'),
       (1, NULL, 'user1', NULL, 2, 'home/user1/#');
