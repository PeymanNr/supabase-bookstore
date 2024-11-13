-- Function 1: Retrieve authors who have published more than a specified number of books.
-- This function accepts an integer parameter (min_books) and returns authors' details if their
-- total published books exceed the provided threshold.
CREATE OR REPLACE FUNCTION get_authors_with_min_books(min_books INT)
RETURNS TABLE(author_id INT, name TEXT, book_count INT) AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.author_id::INT,
        a.name::TEXT,
        COUNT(b.book_id)::INT AS book_count
    FROM
        authors a
    JOIN
        books b ON a.author_id = b.author_id
    GROUP BY
        a.author_id, a.name
    HAVING
        COUNT(b.book_id) > min_books;
END;
$$ LANGUAGE plpgsql;

-- Function 2: Calculate the average book price for each country based on the authors' countries.
-- This function returns the country and the average price of books from authors in that country.
CREATE OR REPLACE FUNCTION get_average_book_price_per_country()
RETURNS TABLE(country TEXT, average_price DECIMAL) AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.country::TEXT,
        AVG(b.price)::DECIMAL AS average_price
    FROM
        authors a
    JOIN
        books b ON a.author_id = b.author_id
    GROUP BY
        a.country;
END;
$$ LANGUAGE plpgsql;

-- Function 3: Retrieve a list of books with author names, sorted by price in descending order.
-- This function accepts a minimum publish date (min_publish_date) and returns books with authors
-- whose publication date is after the specified date. The results are sorted by price in descending order.
CREATE OR REPLACE FUNCTION get_books_sorted_by_price(min_publish_date DATE)
RETURNS TABLE(book_id INT, title TEXT, author_name TEXT, price DECIMAL, publish_date DATE) AS $$
BEGIN
    RETURN QUERY
    SELECT
        b.book_id::INT,
        b.title::TEXT,
        a.name::TEXT AS author_name,
        b.price::DECIMAL,
        b.publish_date::DATE
    FROM
        books b
    JOIN
        authors a ON b.author_id = a.author_id
    WHERE
        b.publish_date >= min_publish_date
    ORDER BY
        b.price DESC;
END;
$$ LANGUAGE plpgsql;

-- Execution Notes:
-- Each function can be run independently in Supabase's SQL Editor to view the response.
-- For example:
-- SELECT * FROM get_authors_with_min_books(2);
-- SELECT * FROM get_average_book_price_per_country();
-- SELECT * FROM get_books_sorted_by_price('2020-01-01');
