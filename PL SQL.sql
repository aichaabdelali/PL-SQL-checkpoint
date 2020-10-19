CREATE TABLE Product(
    Product_id VARCHAR2(20) CONSTRAINT pk_product PRIMARY KEY,
    product_name VARCHAR2(20) CONSTRAINT cons_product NOT NULL,
    Price NUMBER CONSTRAINT check_price CHECK (Price>0),
);

CREATE TABLE Orders(
    Customer_id VARCHAR2(20) CONSTRAINT pk_customer PRIMARY KEY,
    Product_id VARCHAR2(20),
    quantity NUMBER,
    total_amount NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (Customer_id) REFERENCES Customers (Customer_id),
    CONSTRAINT fk_product FOREIGN KEY (Product_id) REFERENCES Product (Product_id)
);

CREATE TABLE Customers(
    Customer_id VARCHAR2(20),
    Customer_name VARCHAR2(20) CONSTRAINT cons_customer NOT NULL,
    Customer_Tel NUMBER,
    
);

Alter TABLE Product ADD Category VARCHAR2(20);
Alter TABLE Orders ADD OrderDate DATE(SYSDATE);

DECLARE 
Customer_id VARCHAR2
Customer_name VARCHAR2
Customer_Tel NUMBER
BEGIN 
SELECT * FROM Customers
END;

CREATE PROCEDURE PS_Customer_Prodcuts(product_name, Customer_id) IS CURSOR cur IS SELECT product_id, Customer_id FROM Orders
BEGIN
FOR rec IN cur LOOP
		dbms_output.put_line(rec.product_id||' '||rec.Customer_id);
	END LOOP;
END PS_Customer_Prodcuts

CREATE FUNCTION FN_Customer_Orders RETURN number IS
	nb_orers number;
BEGIN
	SELECT count(*) into nb_orders FROM Orders;
	RETURN nb_orders;
END;

CREATE TRIGGER TRIG_INS_ORDERS 
AFTER INSERT OR UPDATE ON Orders
BEGIN
	INSERT INTO log(table_name, v_date, action)
	VALUES ('Orders', SYSDATE,
	INSERT on Orders) ;
END;