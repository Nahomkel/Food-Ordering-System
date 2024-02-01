-- DROP TABLES
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE restaurant CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE category_restaurant CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE dish CASCADE CONSTRAINTS;
DROP TABLE cart_detail CASCADE CONSTRAINTS;
DROP TABLE customer_order CASCADE CONSTRAINTS;
DROP TABLE order_dish CASCADE CONSTRAINTS;
DROP TABLE discount CASCADE CONSTRAINTS;
DROP TABLE sales_tax CASCADE CONSTRAINTS;
DROP TABLE customer_discount CASCADE CONSTRAINTS;
DROP TABLE message CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;

--TABLES

-- Customer Table
CREATE TABLE customer (
	csid INT,
	csname VARCHAR(88),
	csaddress VARCHAR(88),
	csstate VARCHAR(88),
	cszip INT,
	csemail VARCHAR(88),
	credit INT,
	PRIMARY KEY (csid)
);


-- Restaurant Table
CREATE TABLE restaurant (
	rsid INT,
	rsname VARCHAR(88),
	rsstatus VARCHAR(88),
	rsphoneNumber INT,
	rsaddress VARCHAR(88),
	rszip INT,
	rsstate VARCHAR(88),
	waitTime DECIMAL(4, 2),
	avgScore DECIMAL(3, 1),
	PRIMARY KEY(rsid)
);

-- Category Table
CREATE TABLE category (
	ctid INT,
	ctname VARCHAR(88),
	PRIMARY KEY (ctid)
);

-- Category_restaurant Table
CREATE TABLE category_restaurant (
	ctid INT,
	rsid INT,
	PRIMARY KEY(ctid, rsid), 
	FOREIGN KEY (ctid) REFERENCES category (ctid),
FOREIGN KEY (rsid) REFERENCES restaurant (rsid)
);

-- Cart Table
CREATE TABLE cart ( 
	cid INT,
	csid INT,
	rsid INT,
	PRIMARY KEY (cid),
	FOREIGN KEY (csid) REFERENCES customer (csid),
	FOREIGN KEY (rsid) REFERENCES restaurant (rsid)
);

-- Dish Table
CREATE TABLE dish (
	did INT,
	rsid INT,
	dname VARCHAR(88),
	price DECIMAL(4, 2),
	PRIMARY KEY(did),
	FOREIGN KEY(rsid) REFERENCES restaurant(rsid)
);

-- Cart Detail Table
CREATE TABLE cart_detail (
	cdid INT,
	cid INT,
	did INT,
	quantity INT,
	PRIMARY KEY (cdid),
	FOREIGN KEY (cid) REFERENCES cart (cid),
	FOREIGN KEY (did) REFERENCES dish (did)
);

-- Customer Order Table
CREATE TABLE Customer_order (
	oid INT,
	csid INT,
	rsid INT,
	ordertime TIMESTAMP,
	estimatetime DECIMAL(4, 2),
	deliverytime DECIMAL(4, 2),
	ostatus number,
	opayment VARCHAR(88),
	totalcost DECIMAL(4, 2),
	PRIMARY KEY (oid),
	FOREIGN KEY (csid) REFERENCES customer (csid),
	FOREIGN KEY (rsid) REFERENCES restaurant (rsid)
);


-- Order_dish table
CREATE TABLE order_dish (
	oid INT,
did INT,
PRIMARY KEY(oid, did),
FOREIGN KEY (oid) REFERENCES customer_order (oid),
	FOREIGN KEY (did) REFERENCES dish (did)
);

-- Discount Table
CREATE TABLE discount (
	dcid INT,
	ddesc VARCHAR(88),
	dtype INT,
	damount DECIMAL(4, 2),
	PRIMARY KEY (dcid)
);

-- Sales Tax Table
CREATE TABLE sales_tax (
	stid INT,
	stname VARCHAR(88),
	tax DECIMAL(4, 2),
	PRIMARY KEY (stid)
);

-- Customer Discount Table
CREATE TABLE customer_discount (
	cdcid INT,
	csid INT,
	dcid INT,
	startdate DATE,
	enddate DATE,
	PRIMARY KEY (cdcid),
	FOREIGN KEY (csid) REFERENCES customer (csid),
	FOREIGN KEY (dcid) REFERENCES discount (dcid)
);


-- Message Table
CREATE TABLE message (
	mid INT,
	csid INT,
	msgtime TIMESTAMP,
	msgbody VARCHAR(100),
	PRIMARY KEY (mid),
	FOREIGN KEY (csid) REFERENCES customer (csid)
);

-- Payment Table
CREATE TABLE payment (
	pid INT,
	csid INT,
	oid INT,
	paytime TIMESTAMP,
	method VARCHAR(100),
	amount DECIMAL(4, 2),
	PRIMARY KEY (pid),
	FOREIGN KEY (csid) REFERENCES customer (csid),
	FOREIGN KEY (oid) REFERENCES customer_order (oid)
);

-- Review Table
CREATE TABLE review (
	rid INT,
	csid INT,
	rsid INT,
	rdate TIMESTAMP,
	rscore DECIMAL(2, 1),
	comments VARCHAR(100),
	PRIMARY KEY (rid),
	FOREIGN KEY (csid) REFERENCES customer (csid),
	FOREIGN KEY (rsid) REFERENCES restaurant (rsid)
);


-- INSERTS

-- Customer Inserts
INSERT INTO customer VALUES 
(1, 'John Bottle', '881 Franklin Drive', 'Maryland', 13324, 'johnbottle81@gmail.com', 0);
INSERT INTO customer VALUES 
(2, 'Mandy Shrimp', '9643 Sycamore Drive', 'Ohio', 34789, 'mandyshrimp99@yahoo.com', 19.99);
INSERT INTO customer VALUES 
(3, 'Greg Watson', '883 Mountainview Avenue', 'California', 45667, 'gregwatson01@gmail.com', 11.99);

-- Restaurant Inserts
INSERT INTO restaurant VALUES 
(1, 'The Crystal Dome', 'closed', 5057282970, '214 Rockwell Street', 67987, 'Ohio', NULL, 3.5);
INSERT INTO restaurant VALUES 
(2, 'Whisperwind', 'open', 3865679262, '8809 Henry Smith Court', 45389, 'Maryland', 10.50, 3.0);
INSERT INTO restaurant VALUES 
(3, 'The Eclipse', 'open', 2562343868, '341 Broad Street', 98356, 'California', 20.25, 4.0);

-- Category Inserts
INSERT INTO category VALUES 
(1, 'Fine Dining' );
INSERT INTO category VALUES 
(2, 'Fast Food');
INSERT INTO category VALUES 
(3, 'Buffet');

-- Category_restaurant Inserts
INSERT INTO category_restaurant VALUES 
(1, 1);
INSERT INTO category_restaurant VALUES 
(2, 2);
INSERT INTO category_restaurant VALUES 
(3, 3);



-- Cart Inserts
INSERT INTO cart VALUES 
(1, 1, 1);
INSERT INTO cart VALUES 
(2, 2, 2);
INSERT INTO cart VALUES 
(3, 3, 3);

-- Dish Inserts
INSERT INTO dish VALUES 
(1, 1, 'Sushi', 15);
INSERT INTO dish VALUES 
(2, 2, 'Pizza', 18);
INSERT INTO dish VALUES 
(3, 3, 'Crab Legs', 10);

-- Cart Detail Inserts
INSERT INTO cart_detail VALUES 
(1, 1, 1, 1);
INSERT INTO cart_detail VALUES 
(2, 2, 2, 2);
INSERT INTO cart_detail VALUES 
(3, 3, 3, 3);

-- Customer Order Inserts
INSERT INTO customer_order VALUES 
(1, 1, 1, TIMESTAMP '2023-02-25 11:05:07.22', 20.22, 4.55, 1, 'paid', 19.99);
INSERT INTO customer_order VALUES 
(2, 2, 2, TIMESTAMP '2022-02-17 16:45:42.78', 6.77, 3.22, 2, 'paid', 29.99);
INSERT INTO customer_order VALUES 
(3, 3, 3, TIMESTAMP '2023-01-22 9:29:55.00', 12.22, 8.56, 3, 'not paid', 30.21);

-- Order_dish inserts
INSERT INTO order_dish VALUES 
(1, 1);
INSERT INTO order_dish VALUES 
(2, 2);
INSERT INTO order_dish VALUES 
(3, 3);

-- Discount Inserts
INSERT INTO discount VALUES 
(1, 'Free delivery', 1, NULL);
INSERT INTO discount VALUES 
(2, '20 percent off', 2, 0.1);
INSERT INTO discount VALUES 
(3, '10 dollar off', 3, 5);

-- Sales Tax Inserts
INSERT INTO sales_tax VALUES 
(1, 'Ohio', 7.22);
INSERT INTO sales_tax VALUES 
(2, 'Maryland', 6);
INSERT INTO sales_tax VALUES 
(3, 'California', 8.82);

-- Customer Discount Inserts
INSERT INTO customer_discount VALUES 
(1, 1, 1, DATE '2022-01-01', DATE '2022-02-01');
INSERT INTO customer_discount VALUES 
(2, 2, 2, DATE '2022-01-01', DATE '2022-03-01');
INSERT INTO customer_discount VALUES 
(3, 3, 3, DATE '2022-05-01', DATE '2022-07-01');

-- Message Inserts
INSERT INTO message VALUES 
(1, 1, TIMESTAMP '2023-02-25 19:30:08.55', 'the client already exists');
INSERT INTO message VALUES 
(2, 2,  TIMESTAMP '2022-02-17 20:40:31.40', 'the client does not exist');
INSERT INTO message VALUES 
(3, 3,  TIMESTAMP '2023-01-22 15:12:29.30', 'the client does not exist');

-- Payment Inserts
INSERT INTO payment VALUES 
(1, 1, 1, TIMESTAMP '2022-02-17 12:30:54.90', 'credit/debit', 19.99);
INSERT INTO payment VALUES 
(2, 2, 2, TIMESTAMP '2022-02-17 17:20:37.50', 'paypal', 29.99);
INSERT INTO payment VALUES 
(3, 3, 3, TIMESTAMP '2023-01-22 10:33:48.10', 'apple pay', 30.21);

-- Review Inserts
INSERT INTO review VALUES 
(1, 1, 1, TIMESTAMP '2022-02-18 9:30:54.90', 3.5, 'The food was fine, just did not like how long it took to get to me');
INSERT INTO review VALUES 
(2, 2, 2, TIMESTAMP '2022-02-18 11:20:37.50', 4.5, 'I loved all the food');
INSERT INTO review VALUES 
(3, 3, 3, TIMESTAMP '2023-01-23 12:33:48.10', 5.0, 'The delivery time was fast and the food was tasty as always');

COMMIT;




--  Features

DROP PROCEDURE new_customer;
DROP PROCEDURE get_customer_profile;
DROP PROCEDURE search_restaurant;
DROP PROCEDURE show_dishes;
DROP PROCEDURE show_cart_details;
DROP PROCEDURE remove_dish;
DROP PROCEDURE update_order_status;
DROP PROCEDURE enter_review;
DROP PROCEDURE restaurant_reviews;
DROP PROCEDURE add_cart;

--  Feature 1:
DROP SEQUENCE csid_seq;
--Assuming that we already have 3 customers within the database, otherwise the sequence would start with 1
CREATE SEQUENCE csid_seq START WITH 4;

create or replace procedure new_customer (cs_name customer.csname%type, cs_add customer.csaddress%type, cs_state customer.csstate%type, cs_zip customer.cszip%type, cs_email customer.csemail%type)
as
    new_ID number;
    v_count number;
BEGIN

    select count(*) into v_count from customer where csemail = cs_email;
    
    if v_count = 1 then 
        --Print message:
        dbms_output.put_line('the client already exists');
        
        --Updates the address, state, and zip of the preexisting customer
        UPDATE customer
        set csaddress = cs_add, csstate = cs_state, cszip = cs_zip
        where csemail = cs_email;
    else
        insert into customer values(csid_seq.nextval, cs_name, cs_add, cs_state, cs_zip, cs_email, 0);
    end if;
END;
/
BEGIN
    --Before Adding Customer:
      Select * from customer;
    --Normal Case:
    EXEC new_customer('Brian', '111 Test Drive', 'Maryland', 49851, 'bpham3@umbc.edu');
Select * from customer;
    
    --Special Case for adding a customer with the same email:
    EXEC new_customer('John Bottle', '657 Millers Road', 'Maryland', 21006, 'johnbottle81@gmail.com');
    Select * from customer;

END;




-- Feature 2
Create or replace 
    procedure get_customer_profile (cs_email in customer.csemail%type) is
v_csid customer.csid%type;
v_csname customer.csname%type;
v_csaddress customer.csaddress%type;
v_csstate customer.csstate%type;
v_cszip customer.cszip%type;
v_csemail customer.csemail%type;
v_credit customer.credit%type;
v_ostatus customer_order.ostatus%type;
v_totalcost customer_order.totalcost%type;
Begin
    --> Check if there's a customer exist
    select csid, csname, csaddress, csstate, cszip, csemail, credit into
    v_csid, v_csname, v_csaddress, v_csstate, v_cszip, v_csemail, v_credit
    from customer
    where csemail = cs_email;
        --> Get # of delivered orders and the totalcost
        Select count(*), sum(totalcost) into
        v_ostatus, v_totalcost
        from customer_order
        where csid = v_csid
        and ostatus = 2 --> Order status 'delivered'
        and ordertime <= add_months (sysdate, -6);
            -->Print Customer Profile along with the status of order and total cost
            dbms_output.put_line ('Customer id is: ' || v_csid);
            dbms_output.put_line ('Customer name is: ' || v_csname);
            dbms_output.put_line ('Customer address is: ' || v_csaddress);
            dbms_output.put_line ('Customer state is: ' || v_csstate);
            dbms_output.put_line ('Customer zip is: ' || v_cszip);
            dbms_output.put_line ('Customer email is: ' || v_csemail);
            dbms_output.put_line ('Customer credit is: ' || v_credit);
            dbms_output.put_line ('Number of delivered orders in the last six months is: ' || v_ostatus);
            dbms_output.put_line ('Total amount spent in the last six months is: ' || v_totalcost);
exception
    when no_data_found then
        dbms_output.put_line ('No such customer exist');
end;
/
Begin
    get_customer_profile ('mandyshrimp99@yahoo.com');
    dbms_output.put_line ('/'); --> Test case for if the email does not exist down below 
    get_customer_profile ('something36@gmail.com');
end;




-- Feature 3

-- creating the input parameter to get the category name and search for
CREATE OR REPLACE PROCEDURE search_restaurant (
  p_ctname IN VARCHAR
)
AS
  -- Declare variables to hold the selected restaurant information
  v_rsname restaurant.rsname%TYPE;
  v_avgscore restaurant.avgscore%TYPE;
  v_waittime restaurant.waittime%TYPE;
  v_rszip restaurant.rszip%TYPE;
BEGIN
  --  Looping through restaurant data to find a match
  FOR c_restaurant IN (
    SELECT rsname, avgscore, waittime, rszip
    FROM restaurant
    WHERE rsstatus = 'open' AND rsid IN (
      SELECT rsid FROM category_restaurant
      WHERE ctid IN (
        SELECT ctid FROM category WHERE ctname = p_ctname
      )
    )
  ) LOOP
    -- Assign the selected data to variables
    v_rsname := c_restaurant.rsname;
    v_avgscore := c_restaurant.avgscore;
    v_waittime := c_restaurant.waittime;
    v_rszip := c_restaurant.rszip;
    
    -- Output the selected data
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_rsname || ', Avg. Review score: ' || v_avgscore || ', avg. wait time: ' || v_waittime || ', Zip code: ' || v_rszip);
  END LOOP;
END;
/
EXEC search_restaurant('Fast Food');

EXEC search_restaurant('Buffet');



-- Feature 4

CREATE OR REPLACE PROCEDURE show_dishes (v_res INT)
    IS CURSOR res IS SELECT dname, price FROM dish
    WHERE rsid = v_res;
    v_count INT;
BEGIN
    SELECT count(*) INTO v_count FROM restaurant
    WHERE rsid = v_res;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid restaurant ID');
    ELSE
        FOR resdish IN res LOOP
            DBMS_OUTPUT.PUT_LINE('Name: ' || resdish.dname);
            DBMS_OUTPUT.PUT_LINE('Price: $' || resdish.price);
        END LOOP;
    END IF;
    
END;
/
-- NORMAL CASE
EXEC show_dishes(1);
EXEC show_dishes(2);

-- SPECIAL CASE
EXEC show_dishes(100);



-- Feature 5


create or replace procedure show_cart_details (c_id cart.cid%type)
as
Cursor c1 is select d.dname, cd.quantity, d.price 
                        from dish d, cart_detail cd, cart c 
                        where d.did = cd.did and c.cid = cd.cid and c.cid = c_id;
v_count number;
BEGIN
    select count(*) into v_count from cart where cid = c_id;

    if v_count = 0 then dbms_output.put_line('Invalid cart ID');
    else
        dbms_output.put_line('                ');
        For curr_dish in c1 loop
            dbms_output.put_line('Dish: ' || curr_dish.dname || '   |  Quantity: ' || curr_dish.quantity || '  |   Total Price:  $' || curr_dish.price * curr_dish.quantity);
        End loop;
    End if;
END;
/
DECLARE
    cid_test1 number := 2; --Used for the normal case
    cid_test2 number := 999; --Used for the special case
BEGIN
     -- Normal case:
    show_cart_details(cid_test1);
    dbms_output.put_line('');  --Justed used for spacing
    -- Special case:
    show_cart_details(cid_test2);
END;



-- Feature 6

create or replace procedure remove_dish(v_did int, v_cid int)
is
v_count_did  int;
V_count_quantity int;
Begin
--select statement for check did (handled by exception) and check quantity
select count(*) into v_count_did from cart_detail cd where cd.cid = v_cid and cd.did = v_did;
dbms_output.put_line(v_count_did);
select quantity into v_count_quantity from cart_detail cd where cd.cid = v_cid and cd.did = v_did;

--if quantity = 1 then delete record
if v_count_quantity = 1 then
Delete from cart_detail where cid = v_cid and did = v_did and quantity = 1;
dbms_output.put_line('dish removed');

-- if more than 1 then reduce quantity by updating record
Elsif v_count_quantity > 1 then

Update cart_detail
Set quantity = quantity - 1
Where cid = v_cid and did = v_did;
dbms_output.put_line('quantity reduced');
end if;
exception when no_data_found then
dbms_output.put_line('input invalid');

end;
/
Select * from cart_detail;
-- Normal Case should ( Run each statement individually)
Exec remove_dish(2,2);
Select * from cart_detail;

Exec remove_dish(2,2);
Select * from cart_detail;

-- Case 1 error check for did not in cart 
Exec remove_dish(4,2);


--show cart_detail
Select * from cart_detail;


-- Feature 7


--> Create sequence for the payment tables
drop sequence message_seq;
drop sequence payment_seq;
create sequence message_seq start with 4 increment by 1;
create sequence payment_seq start with 4 increment by 1;

create or replace procedure update_order_status (o_id customer_order.oid%type, 
o_status customer_order.ostatus%type, o_rdertime timestamp) as
    v_csid customer.csid%type;
    v_totalcost customer_order.totalcost%type;
    v_method payment.method%type;
Begin

    --> Checks if OrderID exist
    Select totalcost, csid
    into v_totalcost, v_csid
    from customer_order
    where oid =  o_id and ostatus != o_status;

    -->update the input status
    update customer_order
    set ostatus = o_status
    where oid = o_id;

    if o_status = 2 then
        --> Insert message for delivered status
        insert into message values (message_seq.nextval, v_csid, o_rdertime, 
        'Your order ' || o_id || ' has been delivered!');
    elsif o_status = 3 then
        --> Update status to cancelled
        update customer_order
        set ostatus = 3
        where oid = o_id;
        --> insert message for cancelled order
        insert into message values (message_seq.nextval, v_csid, o_rdertime, 
        'Your order ' || o_id || ' has been cancelled and a refund has been issued!');
        
        --> Check payment method   
        select method into v_method  --into v_method
        from payment
        where oid  = 3;
            
        --> Insert refund record into payment table with new payment ID
        insert into payment values (payment_seq.nextval, v_csid, o_id, 
        o_rdertime, v_method, -1 * v_totalcost); --> creates negative payment from refund
    end if;
exception
--> If order ID is invalid
    when no_data_found then
        dbms_output.put_line ('Invalid Order ID');      
end;
/
--> Regular Cases to show both results ( Appear in message table )
select * from message;
select * from payment;
Exec update_order_status (2, 3, systimestamp);
Exec update_order_status (1, 2, systimestamp);
select * from message;
select * from payment;
--> Special Case:
Exec update_order_status (4, 2, systimestamp);



-- Feature 8


--sequence required for feature 8
DROP SEQUENCE review_sequence;
CREATE SEQUENCE review_sequence START WITH 4
INCREMENT BY 1;

--feature 8 - Thaddeus
create or replace procedure enter_review(v_csid int, v_rsid int, v_rdate date, v_rscore float, v_comment varchar)
is
v_count_csid  int;
v_count_rsid  int;

Begin
--select statements for check if customer id and restaurant id are valid
select count(*)  into v_count_csid from customer where csid = v_csid;
select count(*)  into v_count_rsid from restaurant where rsid = v_rsid;

--check if csid valid
if v_count_csid = 0 then
dbms_output.put_line('invalid customer ID');

--check if rsid valid
Elsif v_count_rsid = 0 then
dbms_output.put_line('invalid restaurant ID');

--if valid cid and rsid, insert new review
Elsif v_count_rsid != 0 and v_count_csid != 0 then

Insert into review
Values (review_sequence.NEXTVAL, v_csid, v_rsid, v_rdate, v_rscore, v_comment);

-- update restaurant avg score
Update restaurant
Set avgScore = (avgScore + v_rscore) / 2
Where rsid = v_rsid;
end if;
end;
/
set serveroutput on;
--show reviews
Select * from review;
--show restaurant 
Select * from restaurant;

--Normal Case
Exec  enter_review(1, 1, TIMESTAMP '2022-02-08 10:30:54.90', 1, 'Food Stinky. Do not eat.');

--to show added record
Select * from review;
--to show change in average score
Select * from restaurant;

--Case 1 check invalid csid
Exec enter_review(0, 1, TIMESTAMP '2022-02-08 10:30:54.90', 0, 'Review not even needed tbh.');
--Case 2 check invalid rsid
Exec  enter_review(1, 0, TIMESTAMP '2022-02-08 10:30:54.90', 5, 'I stole 36 mints and the cashiers wallet. Good service');

--show reviews
Select * from review;
--show restaurant 
Select * from restaurant;



-- Feature 9


CREATE OR REPLACE PROCEDURE RESTAURANT_REVIEWS (p_rsid IN restaurant.rsid%TYPE) IS
    v_count NUMBER(10);
     i int := 0;
    Cursor c1 is SELECT rdate, rscore, comments FROM review WHERE rsid = p_rsid;
BEGIN
    SELECT COUNT(*) INTO v_count FROM restaurant WHERE rsid = p_rsid;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid restaurant ID');
    ELSE
        
        FOR r IN c1 LOOP
            i  := i + 1; -- Used to number each review of the specified restaurant
            DBMS_OUTPUT.PUT_LINE('Review #' || i || '');
            DBMS_OUTPUT.PUT_LINE('Review Date: ' || r.rdate);
            DBMS_OUTPUT.PUT_LINE('Score: ' || r.rscore);
            DBMS_OUTPUT.PUT_LINE('Comments: ' || r.comments);
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
        END LOOP;
    END IF;
END;
/
-- regular case
EXEC RESTAURANT_REVIEWS (2);

-- special case
EXEC RESTAURANT_REVIEWS (999);



-- Feature 10


DROP SEQUENCE new_dish;
DROP SEQUENCE new_cart;
CREATE SEQUENCE new_dish START WITH 4 INCREMENT BY 1;
CREATE SEQUENCE new_cart START WITH 4 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE add_cart (v_custID INT, v_resID INT, v_dishID INT)
    IS
    CURSOR resstatus IS SELECT rsstatus FROM restaurant
    WHERE rsid = v_resID;
    CURSOR dish_select IS SELECT rsid FROM dish
    WHERE did = v_dishID;
    CURSOR cust_cart IS SELECT cid, quantity FROM cart_detail
    WHERE cid = v_custID;
    v_cust INT;
    v_res INT;
    v_dish INT;
    v_resstatus restaurant.rsstatus%TYPE;
    v_dish_res INT;
    v_cust_cart INT;
    v_new_quantity INT;
BEGIN
    -- Checks if customer ID exists
    SELECT count(*) INTO v_cust FROM customer
    WHERE csid = v_custID;
    
    -- Checks if restaurant ID exists
    SELECT count(*) INTO v_res FROM restaurant
    WHERE rsid = v_resID;
    
    -- If customer doesn't exist
    IF v_cust = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid customer ID');
    
    -- If customer exists
    ELSE
        -- If restaurant doesn't exist
        IF v_res = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Invalid restaurant ID');
            
        -- If restaurant exists
        ELSE
            -- Checks the status of restaurant
            FOR res IN resstatus LOOP
                v_resstatus := res.rsstatus;
            END LOOP;
            
            -- If restaurant is closed
            IF v_resstatus = 'closed' THEN
                DBMS_OUTPUT.PUT_LINE('Restaurant is currently closed');
                
            -- If restaurant is open
            ELSE
                -- Checks if dish belongs to the restaurant
                SELECT count(*) INTO v_dish FROM dish
                WHERE did = v_dishID;
                
                FOR dish_res in dish_select LOOP
                    v_dish_res := dish_res.rsid;
                END LOOP;
                
                
                -- If dish doesn't belong to the restaurant
                IF v_dish_res != v_resID THEN
                        DBMS_OUTPUT.PUT_LINE('Wrong restaurant');
                
                -- If dish is in the restaurant
                ELSE
                    -- Checks if customer has cart
                    SELECT count(*) INTO v_cust_cart FROM cart
                    WHERE csid = v_custID;
                    
                    -- If customer doesn't have a cart
                    IF v_cust_cart = 0 THEN
                        INSERT INTO cart VALUES (new_dish.nextval ,v_custID , v_resID);
                        INSERT INTO cart_detail VALUES (new_cart.nextval, new_dish.nextval, v_dishID, 1);
                        
                        -- Extracts cart ID and quantity
                        For cart_detail in cust_cart LOOP
                            v_cust_cart := cart_detail.cid;
                            v_new_quantity := cart_detail.quantity;
                        END LOOP;
                        
                        DBMS_OUTPUT.PUT_LINE('New cart created for customer');
                        DBMS_OUTPUT.PUT_LINE('Cart ID: ' || v_cust_cart || ' Quantity: ' || v_new_quantity);
                    
                    -- If customer has a cart
                    ELSE
                        UPDATE cart_detail
                        SET quantity = quantity + 1
                        WHERE cid = v_custID;
                        
                        -- Extracts cart ID and quantity
                        For detail in cust_cart LOOP
                            v_cust_cart := detail.cid;
                            v_new_quantity := detail.quantity;
                        END LOOP;
                        
                        DBMS_OUTPUT.PUT_LINE('Existing cart for customer');
                        DBMS_OUTPUT.PUT_LINE('Cart ID: ' || v_cust_cart || ' Quantity: ' || v_new_quantity);
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
END;
/
-- Normal Case (adds to cart twice)
EXEC add_cart(1, 2, 2);
EXEC add_cart(1, 2, 2);

-- Special Case

-- Invalid Customer ID
EXEC add_cart(100, 1, 1);

-- Invalid Restaurant ID
EXEC add_cart(1, 100, 1);

-- Restaurant closed
EXEC add_cart(1, 1, 1);

