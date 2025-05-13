# db-project

 # Project title: Library Management System

## Description

This project implements a complete database management system for a library using MySQL. It allows for the management of members, authors, genres, books, and the tracking of loans. The system ensures data integrity through the use of primary keys, foreign keys, and various constraints.

## How to Run/Setup the Project (or import SQL)

1.  **Install MySQL:** Ensure you have MySQL server installed on your local machine.
2.  **Access MySQL:** Open your MySQL client (e.g., MySQL Workbench, Dbeaver, command-line client).
3.  **Create Database (Optional):** You can optionally create a database named `library_management` before importing. If you don't, the `CREATE TABLE` statements will implicitly create the tables in the default database.
    ```sql
    CREATE DATABASE IF NOT EXISTS library_management;
    USE library_management;
    ```
4.  **Import SQL:** Execute the contents of the `library_management.sql` file in your MySQL client. This will create the necessary tables and their relationships. You can do this by opening the `.sql` file in your client and running the script, or by using the command line:
    ```bash
    mysql -u <your_username> -p < library_management.sql
    ```
    (Replace `<your_username>` with your MySQL username and you'll be prompted for your password).


## Entity-Relationship Diagram (ERD)

+------------+      +-------------+       +----------+       +------------+
| members    |----->| loans       |&lt;------| loan_items |----->| books      |
+------------+      +-------------+       +----------+       +------------+
| member_id  |  1:M | member_id   |   1:M | loan_id  |   1:1 | book_id    |
| first_name |      | loan_id     |       | book_id  |       | isbn       |
| last_name  |      | loan_date   |       | loan_item_id (PK)| title      |
| email      |      | due_date    |       +----------+       | ...        |
| ...        |      | return_date |                              | genre_id (FK)|
+------------+      +-------------+                              +------------+
^
| 1:M
|
+----------+
| genres   |
+----------+
| genre_id |
| genre_name|
+----------+

+---------+     +--------------+
| books   |&lt;----| book_authors |----->| authors      |
+---------+     +--------------+       +--------------+
| book_id | 1:M | book_id      | M:1  | author_id    |
| ...     |     | author_id    |      | first_name   |
+---------+     +--------------+      | last_name    |

+--------------+


![image](https://github.com/user-attachments/assets/e7733930-c749-4b6b-9941-13a434298484)
