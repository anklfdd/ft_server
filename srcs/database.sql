CREATE USER 'gavril'@'localhost' IDENTIFIED BY 'gavril';
CREATE DATABASE ft_database;
GRANT ALL PRIVILEGES ON ft_database.* TO 'gavril'@'localhost'; 
FLUSH PRIVILEGES;