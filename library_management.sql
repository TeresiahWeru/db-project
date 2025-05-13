-- Database: library_management

-- Drop existing tables if they exist to start fresh
DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS book_genres;
DROP TABLE IF EXISTS loan_items;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS members;

-- Table: members
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: authors
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Table: genres
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

-- Table: books
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    publication_year INT,
    publisher VARCHAR(100),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

-- Table: book_authors (Many-to-Many relationship between books and authors)
CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Table: book_genres (One-to-Many relationship - already handled in books table, can be expanded for multiple genres per book if needed)
-- For simplicity, we've linked one genre per book in the 'books' table.
-- If multiple genres per book are required, you'd create a separate 'book_genres' table similar to 'book_authors'.

-- Table: loans
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    loan_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- Table: loan_items (Tracks individual book copies within a loan - in case of multiple copies borrowed)
CREATE TABLE loan_items (
    loan_item_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE RESTRICT -- Prevent deleting a book if it's currently on loan
);

-- Sample Data (Optional - for testing)
INSERT INTO members (first_name, last_name, email, phone_number, address) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '123-456-7890', '123 Main St'),
('Bob', 'Johnson', 'bob.johnson@example.com', '987-654-3210', '456 Oak Ave');

INSERT INTO authors (first_name, last_name) VALUES
('Jane', 'Austen'),
('George', 'Orwell');

INSERT INTO genres (genre_name) VALUES
('Fiction'),
('Science Fiction'),
('Classics');

INSERT INTO books (isbn, title, publication_year, publisher, total_copies, available_copies, genre_id) VALUES
('978-0141439518', 'Pride and Prejudice', 1813, 'T. Egerton', 5, 5, 1),
('978-0451524935', 'Nineteen Eighty-Four', 1949, 'Secker & Warburg', 3, 3, 2);

INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 2);

INSERT INTO loans (member_id, due_date) VALUES
(1, '2025-05-20'),
(2, '2025-05-25');

INSERT INTO loan_items (loan_id, book_id) VALUES
(1, 1),
(2, 2);
