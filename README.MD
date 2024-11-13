
# Supabase RESTful API Project

This project implements a RESTful API using [Deno](https://deno.land/) and [Supabase](https://supabase.com/). The API provides book data with optional filtering by author and supports pagination and sorting by publication date or other specified fields.

## Project Structure

- **Main file**: `index.js`
- **Technology stack**:
  - Deno for server-side runtime.
  - Supabase client for database interactions.

## Features

- **GET /books**: Retrieves a paginated list of books.
  - Accepts optional query parameters:
    - `author_id`: Filters books by the given author ID.
    - `sort_by`: Sorts results by the specified column (default: `publish_date`).
    - `page`: Specifies the page number (default: 1).
    - `limit`: Number of books per page (default: 10).
- Secure access using environment variables for the Supabase URL and key.

## Environment Variables

Ensure to set the following environment variables in a `.env` file or your hosting environment:

- `SUPABASE_URL`: The URL of your Supabase project.
- `SUPABASE_KEY`: The API key for your Supabase project.

**Note**: Do not expose sensitive environment variables in public repositories.

## Installation and Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/PeymanNr/supabase-bookstore.git
   cd your-repo
   ```

2. **Create a `.env` file**:
   ```bash
   SUPABASE_URL=your-supabase-url
   SUPABASE_KEY=your-supabase-api-key
   ```

3. **Run the project**:
   Make sure you have Deno installed. Start the server with:
   ```bash
   deno run --allow-env --allow-net index.js
   ```

## API Endpoints

### GET /books

**Description**: Fetches a list of books, with optional filtering by author, sorting, and pagination.

**Query Parameters**:
- `author_id` (optional): Filter by author ID.
- `sort_by` (optional): Field to sort by (default: `publish_date`).
- `page` (optional): Page number (default: 1).
- `limit` (optional): Number of books per page (default: 10).

**Response**:
- Returns an array of books and associated author names in JSON format.
- If an error occurs, returns a JSON response with an error message.

**Example Request**:
```bash
curl --location 'https://tumueonqqmelnndwgupq.supabase.co/functions/v1/BookDB?author_id=3&sort_by=price&limit=5'
```

## Security Notes

- Ensure the `SUPABASE_KEY` is kept secure and not shared publicly.
- Use a `.gitignore` to exclude your `.env` file:
  ```bash
  .env
  ```
