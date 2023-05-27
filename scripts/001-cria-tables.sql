CREATE TABLE "cidades"(
    "cidadeId" SERIAL PRIMARY KEY,
    "cidadeNome" TEXT
);

CREATE TABLE "companhia"(
    "companhiaId" SERIAL PRIMARY KEY,
    "companhiaNome" TEXT NOT NULL
);


CREATE TABLE "hoteis"(
    "hotelId" SERIAL PRIMARY KEY,
    "fotoId" INT,
    "nomeHotel" TEXT,
    "caracteristicas" TEXT,
    "comodidades" TEXT
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



