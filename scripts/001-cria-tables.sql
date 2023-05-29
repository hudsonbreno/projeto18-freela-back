CREATE TABLE "cidades"(
    "cidadeId" SERIAL PRIMARY KEY,
    "cidadeNome" TEXT,
    "UF" VARCHAR(2)
);

CREATE TABLE "companhia"(
    "companhiaId" SERIAL PRIMARY KEY,
    "companhiaNome" TEXT NOT NULL
);

CREATE TABLE "hoteis"(
    "hotelId" SERIAL PRIMARY KEY,
    "fotoId" INT,
    "cidadeId" INT,
    "nomeHotel" TEXT,
    "caracteristicas" TEXT,
    "comodidades" TEXT,
    "valor_dia" NUMERIC(10,2)
);

CREATE TABLE "viagem"(
    "viagemId" SERIAL PRIMARY KEY,
    "cidadeDestinoId" INT NOT NULL,
    "cidadeOrigemId" INT NOT NULL,
    "horarioPartida" TIMESTAMP,
    "horarioPrevista" TIMESTAMP,
    "preco" NUMERIC(10,2),
    "companhiaId" INT NOT NULL,
    FOREIGN KEY("cidadeDestinoId") REFERENCES "cidades"("cidadeId"),
    FOREIGN KEY("cidadeOrigemId") REFERENCES "cidades"("cidadeId"),
    FOREIGN KEY("companhiaId") REFERENCES "companhia"("companhiaId")
);

CREATE TABLE "fotos"(
    "fotoId" SERIAL PRIMARY KEY,
    "hotelId" INT UNIQUE,
    "fotoUrl" VARCHAR(255),
    FOREIGN KEY("hotelId") REFERENCES "hoteis"("hotelId")
);

INSERT INTO "cidades" ("cidadeNome", "UF")
VALUES
  ('Rio de Janeiro', 'RJ'),
  ('São Paulo', 'SP'),
  ('Salvador', 'BA'),
  ('Fortaleza', 'CE'),
  ('Recife', 'PE'),
  ('Florianópolis', 'SC'),
  ('Porto Alegre', 'RS'),
  ('Manaus', 'AM'),
  ('Brasília', 'DF'),
  ('Foz do Iguaçu', 'PR'),
  ('Belo Horizonte','MG');

INSERT INTO "companhia"("companhiaNome") VALUES
("Avianca"),
("Azul"),
("GOL"),
("IBERIA"),
("LATAM"),
("TAP");


INSERT INTO "hoteis"("fotoId","cidadeId","nomeHotel","caracteristicas","comodidades","valor_dia") VALUES
(1,1, 'Hotel da tiazinha', 'Possui otimo espaço', 'piscina, area de churrasco', 200),
(2,2, 'Hotelzinho', 'tem jardim', 'quartos', 50);

INSERT INTO "viagem"("cidadeDestinoId","cidadeOrigemId","horarioPartida","horarioPrevista","preco","companhiaId")
VALUES
(1, 2, '2023-05-28 10:00', '2023-05-28 12:00', 600, 2),
(1, 2, '2023-05-28 10:00', '2023-05-28 12:00', 10000, 3),
(2, 4, '2023-05-28 10:00', '2023-05-28 12:00', 5500, 2),
(4, 2, '2023-05-28 10:00', '2023-05-28 12:00', 1500, 3),
(2, 4, '2023-05-28 10:00', '2023-05-28 12:00', 6500, 5),
(6, 1, '2023-05-28 10:00', '2023-05-28 12:00', 2000, 1),
(4, 2, '2023-05-28 10:00', '2023-05-28 12:00', 3500, 2),
(2, 4, '2023-05-28 10:00', '2023-05-28 12:00', 500, 5),
(3, 6, '2023-05-28 10:00', '2023-05-28 12:00', 10000, 2),
(4, 2, '2023-05-28 10:00', '2023-05-28 12:00', 1500, 3),
(2, 4, '2023-05-28 10:00', '2023-05-28 12:00', 6500, 5);
INSERT INTO "fotos"("hotelId","fotoUrl") VALUES 
(1,'https://s3.amazonaws.com/static-webstudio-accorhotels-usa-1.wp-ha.fastbooking.com/wp-content/uploads/sites/2/2016/11/03141015/gallery_santateresa_ACCOR_TBF2472-1200x690.jpg'),
(2,'https://hotelsaofranciscocaxambu.com.br/wp-content/gallery/simples/quarto-simples-com-duas-camas.jpg');