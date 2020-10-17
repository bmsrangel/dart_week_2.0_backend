create database pizza_delivery;

use pizza_delivery;

CREATE TABLE IF NOT EXISTS usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  senha VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_usuario))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cardapio_grupo (
  id_cardapio_grupo INT NOT NULL AUTO_INCREMENT,
  nome_grupo VARCHAR(45) NULL,
  PRIMARY KEY (id_cardapio_grupo))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cardapio_grupo_item (
  id_cardapio_grupo_item INT NOT NULL AUTO_INCREMENT,
  id_cardapio_grupo INT NOT NULL,
  nome VARCHAR(200) NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_cardapio_grupo_item),
  INDEX fk_cardapio_groupo_item_cardapio_grupo_idx (id_cardapio_grupo ASC),
  CONSTRAINT fk_cardapio_groupo_item_cardapio_grupo
    FOREIGN KEY (id_cardapio_grupo)
    REFERENCES cardapio_grupo (id_cardapio_grupo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS pedido (
  id_pedido INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  forma_pagamento ENUM('debito', 'credito', 'dinheiro') NOT NULL,
  endereco_entrega TEXT NOT NULL,
  PRIMARY KEY (id_pedido),
  INDEX fk_pedido_usuario1_idx (id_usuario ASC),
  CONSTRAINT fk_pedido_usuario1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS pedido_item (
  id_pedido_item INT NOT NULL AUTO_INCREMENT,
  id_pedido INT NOT NULL,
  id_cardapio_grupo_item INT NOT NULL,
  PRIMARY KEY (id_pedido_item),
  INDEX fk_pedido_item_pedido2_idx (id_pedido ASC),
  INDEX fk_pedido_item_cardapio_grupo_item1_idx (id_cardapio_grupo_item ASC),
  CONSTRAINT fk_pedido_item_pedido2
    FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_pedido_item_cardapio_grupo_item1
    FOREIGN KEY (id_cardapio_grupo_item)
    REFERENCES cardapio_grupo_item (id_cardapio_grupo_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;