--1. Find the Top 5 Most Popular Genres by Total Sales

SELECT g.name AS genre_name, SUM(il.unit_price * il.quantity) AS total_sales
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN invoice_line il ON t.track_id = il.track_id
JOIN invoice i ON il.invoice_id = i.invoice_id
GROUP BY g.name
ORDER BY total_sales DESC
LIMIT 5;
--2. Calculate the Average Invoice Total by Country
SELECT c.country, AVG(i.total) AS average_invoice_total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
GROUP BY c.country
ORDER BY average_invoice_total DESC;
--3. Identify the Top 3 Most Valued Customers Based on the Total Sum of Invoices
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 3;

--4. Generate a Report Listing All Employees Who Have Sold Over a Specified Amount
SELECT e.employee_id, e.first_name, e.last_name, SUM(il.unit_price * il.quantity) AS total_sales
FROM invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN customer c ON i.customer_id = c.customer_id
JOIN employee e ON c.support_rep_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
HAVING SUM(il.unit_price * il.quantity) > 1000
ORDER BY total_sales DESC;
