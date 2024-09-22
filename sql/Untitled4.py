#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import pyodbc

# Establish a connection to the database
connection_string = 'Driver={SQL Server};Server=localhost;Database=BuyYourBooks;Trusted_Connection=yes;'
connection = pyodbc.connect(connection_string)


# Create a cursor object to execute queries
cursor = connection.cursor()

# Execute the queries
cursor.execute("SELECT p.custid, COUNT(DISTINCT p.purchasedate) AS BOOKS FROM purchase p GROUP BY p.custid HAVING COUNT(DISTINCT p.purchasedate) > 1;")
result1 = cursor.fetchall()

cursor.execute("SELECT p.custid, b.Bookname FROM purchase p JOIN book b ON p.bookid = b.Bookid JOIN (SELECT b1.Category, p1.purchasedate FROM purchase p1 JOIN book b1 ON p1.bookid = b1.Bookid GROUP BY b1.Category, p1.purchasedate HAVING COUNT(DISTINCT p1.custid) > 1) sub ON b.Category = sub.Category AND p.purchasedate = sub.purchasedate;")
result2 = cursor.fetchall()

cursor.execute("SELECT c.custname, b.Bookname FROM purchase p JOIN book b ON p.bookid = b.Bookid JOIN customer c ON p.custid = c.custid WHERE p.purchasedate = (SELECT purchasedate FROM purchase JOIN customer ON purchase.custid = customer.custid WHERE customer.custname = 'Anne') AND c.custname <> 'Anne';")
result3 = cursor.fetchall()

# Print the query results
print("Requirement 1:")
for row in result1:
    print("Customer ID:", row[0])
    print("Number of Purchases:", row[1])
    print()

print("Requirement 2:")
for row in result2:
    print("Customer ID:", row[0])
    print("Book Title:", row[1])
    print()

print("Requirement 3:")
for row in result3:
    print("Customer Name:", row[0])
    print("Book Title:", row[1])
    print()

# Close the cursor and connection
cursor.close()
connection.close()


# In[ ]:




