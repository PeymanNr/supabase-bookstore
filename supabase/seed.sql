CREATE TABLE IF NOT EXISTS authors (
    author_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS books (
    book_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    price INTEGER NOT NULL,
    author_id INTEGER REFERENCES authors(author_id),
    publish_date timestamp with time zone default now()
);

INSERT INTO authors (name, country) VALUES
  ('author1', 'iran'),
  ('author2', 'iran'),
  ('author3', 'iran');

INSERT INTO books (title, price, author_id, publish_date) VALUES
  ('test1', 13000, 1, now()),
  ('test2', 15000, 2, now()),
  ('test3', 16000, 3, now());
