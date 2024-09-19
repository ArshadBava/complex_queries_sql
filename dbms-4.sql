CREATE DATABASE complex_queries_db;
USE complex_queries_db;


CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    title VARCHAR(50),
    author VARCHAR(50),
    price DECIMAL(6,2),
    category VARCHAR(40),
    stock_quantity INT
);


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(20),
    customer_email VARCHAR(50),
    contact_info VARCHAR(20)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE OrderDetails (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);


INSERT INTO Book (book_id, title, author, price, category, stock_quantity) VALUES
(1, 'Alchemist', 'Paulo Coelho', 499, 'Fiction', 5),
(2, 'Aadu Jeevitham', 'Benyamin', 950, 'Life Story', 10),
(3, 'Dune', 'Frank Herbert', 650, 'SciFi', 90),
(4, 'Hobbit', 'J.R.R. Tolkien', 500, 'SciFi', 15),
(5, 'Neuromancer', 'William Gibson', 1299, 'SciFi', 30);


SELECT * FROM Book;

INSERT INTO Customers (customer_id, name, customer_email, contact_info) VALUES
(1, 'Jon', 'jon@gmail.com', '9458556336'),
(2, 'Rizwan', 'rizwan@gmail.com', '985462535'),
(3, 'Mohit', 'mohit@gmail.com', '555-5678'),
(4, 'Shiva', 'shiva@gmail.com', '555-5678'),
(5, 'Arshad', 'arshad@gmail.com', '555-5678');


INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2024-09-01'),
(2, 2, '2024-09-02'),
(3, 3, '2024-09-01'),
(4, 4, '2024-09-01');


INSERT INTO OrderDetails (order_id, book_id, quantity) VALUES
(1, 1, 2),  
(2, 2, 5),  
(3, 3, 3), 
(4, 4, 5);


SELECT SUM(od.quantity * b.price) AS total_revenue
FROM OrderDetails od
JOIN Book b ON od.book_id = b.book_id;


select c.customer_id, c.name
from customers c
join orders o on c.customer_id = o.customer_id
join orderdetails od on o.order_id = od.order_id
group by c.customer_id , c.name, o.order_id
having sum(od.quantity)>1;

SELECT c.customer_id, c.name, SUM(od.quantity * b.price) AS total_spent
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Book b ON od.book_id = b.book_id
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;


SELECT COUNT(DISTINCT customer_id) AS distinct_customers
FROM Orders;


SELECT DISTINCT o.order_id, o.order_date,c.customer_id,c.name
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Book b ON od.book_id = b.book_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE b.category = 'SciFi';
