create database BuyYourBooks ;
use BuyYourBooks;

-- Create the Book table
CREATE TABLE Book (
  Bookid VARCHAR(10) PRIMARY KEY,
  Bookname VARCHAR(20),
  Category VARCHAR(20)
);

-- Create the Customer table
CREATE TABLE Customer (
  Custid VARCHAR(10) PRIMARY KEY,
  Custname VARCHAR(20)
);


-- Create the Purchase table
CREATE TABLE Purchase (
  Purchaseid VARCHAR(10) PRIMARY KEY,
  Custid VARCHAR(10) REFERENCES Customer (Custid),
  Bookid VARCHAR(10) REFERENCES Book (Bookid),
  Purchasedate DATE
);



-- Insert data into the Book table
INSERT INTO Book VALUES ('B101', 'Science Revolution', 'Journal');
INSERT INTO Book VALUES ('B102', 'Brain Teasers', 'Aptitude');
INSERT INTO Book VALUES ('B103', 'India Today', 'Magazine');
INSERT INTO Book VALUES ('B104', 'Tech World', 'Journal');
INSERT INTO Book VALUES ('B105', 'Bizz World', 'Magazine');
INSERT INTO Book VALUES ('B106', 'The Quests', 'Aptitude');


-- Insert data into the Customer table
INSERT INTO Customer VALUES ('C101', 'Jack');
INSERT INTO Customer VALUES ('C102', 'Anne');
INSERT INTO Customer VALUES ('C103', 'Jane');
INSERT INTO Customer VALUES ('C104', 'Maria');



-- Insert data into the Purchase table
INSERT INTO Purchase VALUES ('P201', 'C101', 'B102', '2019-12-12');
INSERT INTO Purchase VALUES ('P202', 'C102', 'B103', '2019-11-25');
INSERT INTO Purchase VALUES ('P203', 'C103', 'B104', '2019-12-12');
INSERT INTO Purchase VALUES ('P204', 'C104', 'B105', '2019-11-25');
INSERT INTO Purchase VALUES ('P205', 'C101', 'B101', '2019-12-11');
INSERT INTO Purchase VALUES ('P206', 'C101', 'B106', '2019-12-12');


select * from book;
select * from customer;
select * from purchase;



-- Requirement 1 :
SELECT custid, COUNT(DISTINCT purchasedate) AS Books
FROM purchase
GROUP BY custid
HAVING COUNT(DISTINCT purchasedate) > 1;

/* this query displays customer’s id and number of such purchases to be 
displayed as BOOKS for the identified purchase details
  */

-- Requirement 2 :
SELECT p.custid, b.Bookname
FROM purchase p
JOIN book b ON p.bookid = b.bookid
WHERE EXISTS (
    SELECT 1
    FROM purchase p2
    WHERE p.bookid = p2.bookid
    AND p.custid <> p2.custid
    AND p.purchasedate <> p2.purchasedate
)
ORDER BY p.custid, b.Bookname;

/*    query to display customer’s id and title of the 
book for the identified purchase details , where the books of the same category are purchased by 
different customers on different dates.
  

*/



-- Requirement 3 :
SELECT c.custname, b.Bookname
FROM purchase p
JOIN customer c ON p.custid = c.custid
JOIN book b ON p.bookid = b.Bookid
WHERE p.purchasedate = (
    SELECT purchasedate
    FROM purchase
    WHERE custid = 'C102' -- Anne's custid
)
  AND p.custid <> 'C102'; -- Exclude Anne
  
  
  /*  
  a query to display customer’s name and title of the 
book for the identified purchase details. Do NOT display details of Anne in the query result.
  */
