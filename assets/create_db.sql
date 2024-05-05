CREATE TABLE IF NOT EXISTS Clientes (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT, 
    nome TEXT, 
    telefone INTEGER, 
    cpfcnpj INTEGER
);

CREATE TABLE IF NOT EXISTS Vendas (
    id_venda INTEGER PRIMARY KEY AUTOINCREMENT, 
    data_venda DATE, 
    preco REAL, 
    quantidade REAL, 
    desconto REAL, 
    total REAL, 
    id_cliente INTEGER, 
    FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente)
);

CREATE TABLE IF NOT EXISTS Abatimentos (
    id_abatimento INTEGER PRIMARY KEY AUTOINCREMENT, 
    data_abatimento DATE, 
    valor_abatido REAL, 
    id_venda INTEGER, 
    FOREIGN KEY (id_venda) REFERENCES Vendas (id_venda)
);

INSERT INTO Clientes (nome, telefone, cpfcnpj) 
VALUES ('RUA', 92999999999, 99999999999),
	('Jose Costa Larga', 92991235963, 12365478965),
	('Paula Tejano', 92991235333, 32165498785),
	('Cuca Beludo', 92991235222, 35715968474),
    ('Dayde Costa', 92991235963, 45698732165),
    ('Melbi Lau', 92991235698, 33698521478556);

INSERT INTO Vendas (data_venda, preco, quantidade, desconto, total, id_cliente) 
VALUES ('2023-01-01', 12.00, 299.00, 0.0, 3588.00, 2),
	('2023-01-27', 12.00, 13.50, 0.0, 162.00, 5),
	('2023-01-28', 12.00, 81.00, 0.0, 972.00, 1),
    ('2023-01-31', 12.00, 8.70, 0.0, 104.40, 6),
    ('2023-01-31', 12.00, 4.50, 0.0, 54.00, 1),
    ('2023-02-05', 12.00, 80.00, 0.0, 960.00, 2),
    ('2023-02-07', 12.00, 85.00, 0.0, 1020.00, 5),
    ('2023-02-10', 12.00, 4.70, 0.0, 56.40, 5),
    ('2023-02-14', 12.00, 150.00, 0.0, 1800.00, 4),
    ('2023-02-15', 12.00, 67.00, 0.0, 804.00, 6),
    ('2023-02-15', 12.00, 58.00, 0.0, 696.00, 1),
    ('2023-02-19', 12.00, 26.00, 0.0, 312.00, 6),
    ('2023-02-19', 12.00, 4.50, 0.0, 54.00, 4),
    ('2023-02-22', 12.00, 48.00, 0.0, 576.00, 1),
    ('2023-02-28', 12.00, 24.60, 0.20, 295.00, 1);

insert into Abatimentos (data_abatimento, valor_abatido, id_venda) 
values ('2023-01-01', 1200.00, 1),
	('2023-01-08', 800.00, 1),
    ('2023-01-01', 1200.00, 1),
    ('2023-01-28', 972.00, 3),
    ('2023-01-31', 54.00, 5),
    ('2023-02-15', 480.00, 6),
    ('2023-02-18', 480.00, 6),
    ('2023-02-13', 350.00, 7),
    ('2023-02-21', 240.00, 7),
    ('2023-02-12', 18.80, 8),
    ('2023-02-14', 18.80, 8),
    ('2023-02-22', 900.00, 9),
    ('2023-02-25', 400, 10),
    ('2023-02-15', 696.00, 11),
    ('2023-02-28', 100.00, 12),
    ('2023-03-05', 54.00, 13),
    ('2023-02-22', 576.00, 14),
    ('2023-01-01', 295.00, 15);