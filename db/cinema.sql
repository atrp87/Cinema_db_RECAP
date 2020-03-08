DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(50),
  price INT
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  funds INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  films_id INT REFERENCES films(id) ON DELETE CASCADE,
  customers_id INT REFERENCES customers(id) ON DELETE CASCADE,
  fee INT
);
