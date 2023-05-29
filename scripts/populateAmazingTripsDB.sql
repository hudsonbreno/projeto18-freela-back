INSERT INTO airlines (airline_id, airline_name)
VALUES
  (1, 'LATAM Airlines Brasil'),
  (2, 'Gol Linhas Aéreas'),
  (3, 'Azul Linhas Aéreas'),
  (4, 'Avianca Brasil'),
  (5, 'Passaredo Linhas Aéreas'),
  (6, 'MAP Linhas Aéreas'),
  (7, 'TwoFlex'),
  (8, 'Voepass'),
  (9, 'TAM Airlines'),
  (10, 'Webjet Linhas Aéreas');

ALTER TABLE cities
ADD COLUMN city_uf VARCHAR(2);

INSERT INTO cidades ("cidadeNome", "UF")
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
  ('Foz do Iguaçu', 'PR');

INSERT INTO flights (airline_id, departure_city_id, destination_city_id, departure_time, arrival_time, price)
SELECT
  airlines.airline_id,
  departure_cities.city_id AS departure_city_id,
  destination_cities.city_id AS destination_city_id,
  CASE
    WHEN EXTRACT(ISODOW FROM generate_series) IN (6, 7) THEN generate_series + (INTERVAL '30 minutes' * (ROW_NUMBER() OVER () - 1))
    ELSE generate_series + (INTERVAL '30 minutes' * (ROW_NUMBER() OVER () - 1))
  END AS departure_time,
  CASE
    WHEN EXTRACT(ISODOW FROM generate_series) IN (6, 7) THEN generate_series + INTERVAL '1 hour'
    ELSE generate_series + INTERVAL '1 hour'
  END AS arrival_time,
  100 AS price
FROM
  generate_series('2023-06-01'::TIMESTAMP, '2023-12-31'::TIMESTAMP, INTERVAL '1 day') AS generate_series,
  (SELECT airline_id FROM airlines) AS airlines,
  (SELECT city_id, city_name FROM cities) AS departure_cities,
  (SELECT city_id, city_name FROM cities) AS destination_cities
WHERE
  departure_cities.city_id <> destination_cities.city_id;
  
CREATE TABLE time_travel (
  departure_city_id INT,
  destination_city_id INT,
  travel_time_minutes INT
);

INSERT INTO time_travel (departure_city_id, destination_city_id, travel_time_minutes)
VALUES
  (1, 1, 0),
  (1, 2, 60),
  (1, 3, 125),
  (1, 4, 190),
  (1, 5, 165),
  (1, 6, 95),
  (1, 7, 120),
  (1, 8, 255),
  (1, 9, 110),
  (1, 10, 130),
  (2, 1, 60),
  (2, 2, 0),
  (2, 3, 140),
  (2, 4, 200),
  (2, 5, 185),
  (2, 6, 70),
  (2, 7, 105),
  (2, 8, 230),
  (2, 9, 105),
  (2, 10, 70),
  (3, 1, 125),
  (3, 2, 140),
  (3, 3, 0),
  (3, 4, 110),
  (3, 5, 75),
  (3, 6, 240),
  (3, 7, 285),
  (3, 8, 400),
  (3, 9, 115),
  (3, 10, 240),
  (4, 1, 190),
  (4, 2, 200),
  (4, 3, 110),
  (4, 4, 0),
  (4, 5, 75),
  (4, 6, 315),
  (4, 7, 360),
  (4, 8, 205),
  (4, 9, 160),
  (4, 10, 345),
  (5, 1, 165),
  (5, 2, 185),
  (5, 3, 75),
  (5, 4, 75),
  (5, 5, 0),
  (5, 6, 310),
  (5, 7, 330),
  (5, 8, 235),
  (5, 9, 155),
  (5, 10, 315),
  (6, 1, 95),
  (6, 2, 70),
  (6, 3, 240),
  (6, 4, 315),
  (6, 5, 310),
  (6, 6, 0),
  (6, 7, 210),
  (6, 8, 360),
  (6, 9, 130),
  (6, 10, 190),
  (7, 1, 120),
  (7, 2, 105),
  (7, 3, 285),
  (7, 4, 360),
  (7, 5, 330),
  (7, 6, 210),
  (7, 7, 0),
  (7, 8, 450),
  (7, 9, 180),
  (7, 10, 75),
  (8, 1, 255),
  (8, 2, 230),
  (8, 3, 400),
  (8, 4, 205),
  (8, 5, 235),
  (8, 6, 360),
  (8, 7, 450),
  (8, 8, 0),
  (8, 9, 175),
  (8, 10, 225),
  (9, 1, 110),
  (9, 2, 105),
  (9, 3, 115),
  (9, 4, 160),
  (9, 5, 155),
  (9, 6, 130),
  (9, 7, 180),
  (9, 8, 175),
  (9, 9, 0),
  (9, 10, 110),
  (10, 1, 130),
  (10, 2, 70),
  (10, 3, 240),
  (10, 4, 345),
  (10, 5, 315),
  (10, 6, 190),
  (10, 7, 75),
  (10, 8, 225),
  (10, 9, 110),
  (10, 10, 0);

UPDATE flights
SET arrival_time = departure_time + (time_travel.travel_time_minutes * INTERVAL '1 minute'),
    price = (time_travel.travel_time_minutes * 8 * (0.75 + random() * (1 - 0.75)))
FROM time_travel
WHERE
  flights.departure_city_id <> flights.destination_city_id
  AND flights.departure_city_id = time_travel.departure_city_id
  AND flights.destination_city_id = time_travel.destination_city_id;