-- CREATION OF FILES
Create table Car_Category 
(Car_category_ID Numeric(10) primary key,
Category_type VARCHAR2(30));

--Create tables --
CREATE TABLE Manufacturer (
                Manufacturer_ID NUMERIC(10) NOT NULL PRIMARY KEY,
                m_Name VARCHAR2(25) NOT NULL,
                Phone_Number VARCHAR2(15) NOT NULL,
                Office_address VARCHAR2(30) NOT NULL,
                Working_hours VARCHAR2(20) NOT NULL
);

CREATE TABLE Model (
                Model_ID NUMERIC(10) NOT NULL PRIMARY KEY,
                Engine_Size VARCHAR2(15) NOT NULL,
                Make VARCHAR2(15) NOT NULL,
                Model_Name VARCHAR2(15) NOT NULL,
                model_Option VARCHAR2(15) NOT NULL,
                Fuel VARCHAR2(15) NOT NULL,
                model_Size VARCHAR2(15) NOT NULL,
                Manufacturer_ID NUMERIC(10) NOT NULL,
                Constraint man_fk FOREIGN KEY (Manufacturer_ID) REFERENCES Manufacturer (Manufacturer_ID)
);

CREATE TABLE ExtraEquipment (
                Extra_Equipment_ID NUMERIC(10) NOT NULL PRIMARY KEY,
                equipment_Type VARCHAR2(30) NOT NULL,
                Quantity NUMERIC(5) NOT NULL,
                colour VARCHAR2(15) NOT NULL,
                Price NUMBER(10,2) NOT NULL
);

CREATE TABLE Customer (
                Customer_ID NUMERIC(10) NOT NULL PRIMARY KEY,
                Nationality VARCHAR2(15) NOT NULL,
                First_name VARCHAR2(25) NOT NULL,
                Phone_Number VARCHAR2(15) NOT NULL,
                Address VARCHAR2(35) NOT NULL,
                house_number NUMERIC(10) NOT NULL,
                Road NUMERIC(5) NOT NULL,
                add_Block NUMERIC(5) NOT NULL,
                Gender VARCHAR2(10) NOT NULL,
                DOB DATE NOT NULL,
                Email VARCHAR2(30) NOT NULL,
                CPR_Passport NUMERIC(20) NOT NULL
);
CREATE TABLE Rental_status (
                status_id NUMERIC(5) NOT NULL PRIMARY KEY,
                Return_Time VARCHAR2(20) NOT NULL,
                complications VARCHAR2(20) NOT NULL,
                status_description VARCHAR2(10) NOT NULL
);

CREATE TABLE Car (
                Car_ID NUMERIC(10) NOT NULL PRIMARY KEY,
                Registration_due_date DATE NOT NULL,
                Insured VARCHAR2(15) NOT NULL,
                Colour VARCHAR2(15) NOT NULL,
                Mileage NUMBER(5,2) NOT NULL,
                Status VARCHAR2(15) NOT NULL,
                Daily_hire_rate NUMBER(5,2) NOT NULL,
                return_penalty NUMBER(5,2) NOT NULL,
                Car_Category_ID NUMERIC(10) NOT NULL,
                Model_ID NUMERIC(10) NOT NULL,
                Constraint model_fk FOREIGN KEY (Model_ID) REFERENCES Model (Model_ID),
                Constraint category_fk FOREIGN KEY (Car_Category_ID) REFERENCES Car_category (Car_Category_ID)
);

CREATE TABLE Location (
                location_ID NUMERIC(10) NOT NULL PRIMARY KEY,
                phone_number VARCHAR2(15) NOT NULL,
                Building VARCHAR2(15) NOT NULL,
                City VARCHAR2(20) NOT NULL,
                Address VARCHAR2(15) NOT NULL
);


CREATE TABLE Car_Rental (
                Car_Rental_ID NUMERIC(10) NOT NULL PRIMARY KEY,
                Car_category VARCHAR2(25) NOT NULL,
                rent_Duration VARCHAR2(25) NOT NULL,
                rent_Cost NUMBER(5,2) NOT NULL,
                rent_Penalty NUMBER(5,2) NOT NULL,
                Car_ID NUMERIC(10) NOT NULL,
                Customer_ID NUMERIC(10) NOT NULL,
                status_id NUMERIC NOT NULL,
                location_ID NUMERIC(10) NOT NULL,
                pickup_date DATE NOT NULL,
                Constraint car_fk FOREIGN KEY (Car_ID) REFERENCES car (Car_ID),
                Constraint cust_fk FOREIGN KEY (Customer_ID) REFERENCES customer (Customer_ID),
                Constraint status_fk FOREIGN KEY (status_id) REFERENCES rental_status (status_id),
                Constraint location_fk FOREIGN KEY (location_ID) REFERENCES location (location_ID)
          
);

CREATE TABLE Rental_Equipement (
                Car_Rent_ID NUMERIC(10) NOT NULL,
                Car_Rental_ID NUMERIC(10) NOT NULL,
                Extra_Equipment_ID NUMERIC(10) NOT NULL,
                Quantity NUMERIC(2) NOT NULL,
                CONSTRAINT Car_Rent_ID PRIMARY KEY (Car_Rent_ID, Car_Rental_ID, Extra_Equipment_ID));
                

-- CREATE AND GRAND ROLES 
create role admin_CAR;
create role manager_car;

grant select,insert,delete,update on MANUFACTURER to admin_car;
grant select,insert,delete,update on MODEL to admin_Car;
grant select,insert,delete,update on EXTRAEQUIPMENT to admin_car;
grant select,insert,delete,update on CAR_CATEGORY to admin_car;
grant select,insert,delete,update on CUSTOMER to admin_car;
grant select,insert,delete,update on RENTAL_STATUS to admin_car;
grant select,insert,delete,update on CAR to admin_car;
grant select,insert,delete,update on LOCATION to admin_car;
grant select,insert,delete,update on CAR_RENTAL to admin_car;
grant select,insert,delete,update on RENTAL_EQUIPEMENT to admin_car;

grant select on customer to manager_car;
grant select on Car_rental to manager_car;
grant select on EXTRAEQUIPMENT to manager_car;
grant select on RENTAL_STATUS to manager_car;

Commit;


-- creation of indexes
create sequence MANUFACTURER_seq start with 1 increment by 1 nocycle;
create sequence EXTRA_EQUIPMENT_seq start  with 1  increment by 1 nocycle;
create sequence CUSTOMER_seq start with 1 increment by 1 nocycle;
create sequence RENTAL_STATUS_seq start with 1 increment by 1 nocycle;
create sequence LOCATION_seq start with 1 increment by 1 nocycle;
create sequence CAR_RENTAL_seq start with 1 increment by 1 nocycle;
create sequence RENTAL_EQUIPEMENT_seq start with 1 increment by 1 nocycle;


--creation of indexes 
create INDEX MODEL_index on MODEL (make, model_name);
create INDEX EXTRAEQUIPMENT_index on EXTRAEQUIPMENT (equipment_type);
create INDEX CUSTOMER_index on CUSTOMER(cpr_passport, first_name);
create INDEX CAR_index on CAR (car_id, model_id, status, car_category_id);
create INDEX CAR_RENTAL_index on CAR_RENTAL(customer_id, rent_cost,car_id);

-- creation of triggers

--t1
CREATE OR REPLACE TRIGGER status_update_trigger
AFTER INSERT OR UPDATE ON rental_status
FOR EACH ROW
BEGIN
  IF :NEW.status_description = 'Completed' THEN
    UPDATE car
    SET status = 'Available'
    WHERE car_id = (select car_id from car_rental where status_id = :NEW.status_id);
  ELSIF :NEW.status_description = 'Incomplete' THEN
    UPDATE car
    SET status = 'Rented'
    WHERE car_id = (select car_id from car_rental where status_id = :NEW.status_id);
    DBMS_OUTPUT.PUT_LINE('car status set to rented');
  END IF;
END;
/

-- to test 
update rental_status set status_description= 'Incomplete' where status_id =2;

--t2
CREATE OR REPLACE TRIGGER update_equipment_quantity
AFTER INSERT OR UPDATE ON Rental_Equipement
FOR EACH ROW
DECLARE
  v_status_description Rental_status.status_description%TYPE;
BEGIN
  -- Get the current status_description
  SELECT status_description INTO v_status_description
  FROM Rental_status
  WHERE status_id = :new.Car_Rental_ID;
  
  -- Subtract the Quantity from Rental_Equipement from the Quantity in ExtraEquipment
  IF INSERTING THEN
    UPDATE ExtraEquipment
    SET Quantity = Quantity - :new.Quantity
    WHERE Extra_Equipment_ID = :new.Extra_Equipment_ID;
  END IF;
  
  -- Add the Quantity from ExtraEquipment to the Quantity in Rental_Equipement if status_description is 'complete'
  IF UPDATING('status_id') AND v_status_description = 'complete' THEN
    UPDATE Rental_Equipement
    SET Quantity = Quantity + (SELECT Quantity FROM ExtraEquipment WHERE Extra_Equipment_ID = :new.Extra_Equipment_ID)
    WHERE Car_Rent_ID = :new.Car_Rent_ID
      AND Car_Rental_ID = :new.Car_Rental_ID
      AND Extra_Equipment_ID = :new.Extra_Equipment_ID;
  END IF;
END;
/

--t3
CREATE OR REPLACE TRIGGER calculate_rental_cost
BEFORE INSERT OR UPDATE ON Car_Rental
FOR EACH ROW
DECLARE
  equipment_cost NUMBER := 0;
  daily_hire_rate NUMBER;
BEGIN
  -- Calculate the cost of extra equipment based on the rental equipment and quantity
  FOR equip IN (SELECT Extra_Equipment_ID, Quantity 
                FROM Rental_Equipement 
                WHERE Car_Rental_ID = :new.Car_Rental_ID)
  LOOP
    SELECT Price INTO equipment_cost
    FROM ExtraEquipment 
    WHERE Extra_Equipment_ID = equip.Extra_Equipment_ID;
    
    equipment_cost := equipment_cost + (equip.Quantity * equipment_cost);
  END LOOP;

  -- Fetch the daily hire rate for the car
  SELECT Daily_hire_rate INTO daily_hire_rate
  FROM Car
  WHERE Car_ID = :new.Car_ID;

  -- Calculate the total rental cost
  :new.rent_Cost := (:new.rent_Duration * daily_hire_rate) + equipment_cost + :new.rent_Penalty;
END;
/

-- t4
CREATE OR REPLACE TRIGGER Insert_Rental_Status
BEFORE INSERT ON Car_Rental
FOR EACH ROW
DECLARE
  v_Status_ID NUMBER;
BEGIN
  -- Generate a new status ID
  SELECT Rental_Status_SEQ.NEXTVAL INTO v_Status_ID FROM DUAL;
  
  -- Insert a new rental status record
  INSERT INTO Rental_Status (status_id, Return_Time, complications, status_description)
  VALUES (v_Status_ID, 'Return Time', 'Complications', 'Incomplete');
  
  -- Set the status ID for the new rental agreement
  :NEW.status_id := v_Status_ID;
END;
/

-- PROCEDURES

-- p1
create or replace procedure add_new_car(
car_id1 in number,
red_due_date in date,
insured1 in varchar2,
color in varchar2,
mil in number,
status in varchar2,
d_hire in number,
return1 in number,
car_cat in number,
model1 in number
)
as 
begin
insert into car (
car_id,
REGISTRATION_DUE_DATE,
INSURED,
COLOUR,
MILEAGE,
STATUS,
DAILY_HIRE_RATE,
RETURN_PENALTY,
CAR_CATEGORY_ID,
MODEL_ID
)
values(
car_id1,
red_due_date,
insured1,
color,
mil,
status,
d_hire,
return1,
car_cat,
model1
);
commit;
DBMS_OUTPUT.PUT_LINE('car added sucessfully');
end;
/
--block to call it 
DECLARE
  car_id1 NUMBER := 23 ;  
  red_due_date DATE := SYSDATE;
  insured1 VARCHAR2(100) := 'yes';
  color VARCHAR2(50) := 'red';
  mil NUMBER := 50;
  status VARCHAR2(50) := 'available';
  d_hire NUMBER := 50;
  return1 NUMBER := 20;
  car_cat NUMBER := 1;
  model1 NUMBER := 2;
BEGIN
  add_new_car(
    car_id1,red_due_date,insured1,color,mil,status,d_hire,return1,car_cat,model1
  );
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--p2
CREATE OR REPLACE PROCEDURE Add_Customer(
  p_Nationality IN VARCHAR2,
  p_First_Name IN VARCHAR2,
  p_Phone_Number IN VARCHAR2,
  p_Address IN VARCHAR2,
  p_House_Number IN NUMBER,
  p_Road IN NUMBER,
  p_Add_Block IN NUMBER,
  p_Gender IN VARCHAR2,
  p_DOB IN DATE,
  p_Email IN VARCHAR2,
  p_CPR_Passport IN NUMBER
)
AS
BEGIN
  INSERT INTO Customer(
    Customer_ID,
    Nationality,
    First_Name,
    Phone_Number,
    Address,
    House_Number,
    Road,
    Add_Block,
    Gender,
    DOB,
    Email,
    CPR_Passport
  )
  VALUES(
   CUSTOMER_seq.NEXTVAL,
    p_Nationality,
    p_First_Name,
    p_Phone_Number,
    p_Address,
    p_House_Number,
    p_Road,
    p_Add_Block,
    p_Gender,
    p_DOB,
    p_Email,
    p_CPR_Passport
  );
END;
/
-- block to call it
DECLARE 
  v_Nationality VARCHAR2(100) := ('&Nationality');
  v_First_Name VARCHAR2(100) := ('&firstname');
  v_Phone_Number VARCHAR2(100) := ('&phone');
  v_Address VARCHAR2(100) := ('&address');
  v_House_Number NUMBER := (&housenumber);
  v_Road NUMBER := (&road);
  v_Add_Block NUMBER := (&block);
  v_Gender VARCHAR2(100) := ('&Gender');
  v_DOB DATE := TO_DATE(('&date'), 'YYYY-MM-DD');
  v_Email VARCHAR2(100) := ('&email');
  v_CPR_Passport NUMBER := (&passport);
BEGIN 

    ADD_CUSTOMER( v_Nationality,v_First_Name,v_Phone_Number,v_Address,v_House_Number,v_Road,v_Add_Block,v_Gender,v_DOB,v_Email,v_CPR_Passport);

END;
/

-- p3
CREATE OR REPLACE PROCEDURE Count_Rentals_Per_Month(
  p_Year IN NUMBER,
  p_Month IN NUMBER,
  p_Num_Rentals OUT NUMBER
)
AS
BEGIN
  SELECT COUNT(*) INTO p_Num_Rentals
  FROM Car_Rental
  WHERE EXTRACT(YEAR FROM pickup_date) = p_Year
    AND EXTRACT(MONTH FROM pickup_date) = p_Month;
END;
/

-- block to call it 
set serveroutput on;
DECLARE
    p_Year number := 2022;
    p_Month number := 6;
    p_Num_Rentals number;
BEGIN 
    Count_Rentals_Per_Month(p_Year,p_Month,p_Num_Rentals);
    dbms_output.put_line(p_Num_Rentals);
END;
/


--p4

CREATE OR REPLACE PROCEDURE UpdateWorkingHours(
    Manufacturer_ID1 IN NUMBER,
    NewWorkingHours IN VARCHAR2
) AS
BEGIN
    UPDATE Manufacturer
    SET Working_hours = NewWorkingHours
    WHERE Manufacturer_ID = Manufacturer_ID1;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Working hours updated successfully.');
     DBMS_OUTPUT.PUT_LINE('your new working hours are: '|| NewWorkingHours ||' for manufacturor no: '||Manufacturer_ID1 );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Manufacturer not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating working hours: ' || SQLERRM);
END;
/
set SERVEROUTPUT on;

-- block to call it 
BEGIN
    UpdateWorkingHours(1, '9:00 AM - 5:00 PM');
END;
/

-- Function 

--f1
CREATE OR REPLACE FUNCTION Calculate_Profit_Per_Month(p_Year IN NUMBER, p_Month IN NUMBER)
  RETURN NUMBER
AS
  v_Start_Date DATE := TO_DATE(p_Year || '-' || p_Month || '-01', 'YYYY-MM-DD');
  v_End_Date DATE := LAST_DAY(v_Start_Date);
  v_Profit NUMBER := 0;
BEGIN
  SELECT SUM(rent_Cost) INTO v_Profit
  FROM Car_Rental
  WHERE pickup_date >= v_Start_Date AND pickup_date <= v_End_Date;
  
  RETURN v_Profit;
END;
/

-- block to call it 
set serveroutput on;
DECLARE 
    V_RESULT NUMBER;
BEGIN 
    V_RESULT := Calculate_Profit_Per_Month(2022,6);
    dbms_output.put_line(v_result || ' profit in june 2022');
END;
/
-- f2
CREATE OR REPLACE FUNCTION CalculateRevenueByCategory(
    category_id IN NUMBER
) RETURN NUMBER
IS
    total_revenue NUMBER;
BEGIN
    SELECT SUM(rent_Cost) INTO total_revenue
    FROM Car_Rental r, car c 
    where r.car_id = c.car_id 
    and c.Car_category_id = category_id;
    
    RETURN total_revenue;
END;
/

-- Block to call it 
DECLARE 
    V_RESULT NUMbER;
    V_result2 number;
    V_result3 number;
BEGIN 
    V_RESULT := CalculateRevenueByCategory(1);
    v_result2 := CalculateRevenueByCategory(2);
    v_result3 := CalculateRevenueByCategory(3);
    DBMS_OUTPUT.PUT_LINE(V_RESULT || ' total revenue by category 1');
    DBMS_OUTPUT.PUT_LINE(V_RESULT2 || ' total revenue by category 2');
    DBMS_OUTPUT.PUT_LINE(V_RESULT3 || ' total revenue by category 3');
END;
/
--f3
CREATE OR REPLACE FUNCTION GetRentalStatusDescription(p_status_id IN NUMBER)
    RETURN VARCHAR2
IS
    status_description VARCHAR2(20);
BEGIN
    SELECT status_description INTO status_description
    FROM Rental_status
    WHERE status_id = p_status_id;

    RETURN status_description;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

--block to call it
set serveroutput on;
DECLARE 
    status_id number := (&status_id);
    res varchar2(100);
BEGIN 
    res := GetRentalStatusDescription(status_id);
    dbms_output.put_line(res);
END;
/

--f4
CREATE OR REPLACE FUNCTION GetAvailableCarsByModel(mode_id IN NUMBER) RETURN NUMBER
AS
  num_available_cars NUMBER;
BEGIN
  SELECT COUNT(*) INTO num_available_cars
  FROM Car
  WHERE Model_ID = mode_id
    AND Status = 'Available';

  RETURN num_available_cars;
END;
/

--Block to call it
DECLARE 
    res number;
    model_id number:=(&model_id);
BEGIN 
    res:= GETAVAILABLECARSBYMODEL(model_id);
    dbms_output.put_line(res || ' available cars');
END;
/

-- Package --
CREATE OR REPLACE PACKAGE rentals
IS
  PROCEDURE CountRentalsPerMonth(month IN NUMBER, year IN NUMBER, rental_count OUT NUMBER);
  
 
  
  FUNCTION CalculateProfitPerMonth(month IN NUMBER, year IN NUMBER) RETURN NUMBER;
  
  FUNCTION CalculateRevenueByCategory(category_id IN NUMBER) RETURN NUMBER;
   
  FUNCTION GetRentalStatusDescription(status_id IN NUMBER) RETURN VARCHAR2;
  
END rentals;
/
--package body
CREATE OR REPLACE PACKAGE BODY rentals 
IS 
  PROCEDURE Count_Rentals_Per_Month(
  p_Year IN NUMBER,
  p_Month IN NUMBER,
  p_Num_Rentals OUT NUMBER
)
AS
BEGIN
  SELECT COUNT(*) INTO p_Num_Rentals
  FROM Car_Rental
  WHERE EXTRACT(YEAR FROM pickup_date) = p_Year
    AND EXTRACT(MONTH FROM pickup_date) = p_Month;
END;

    FUNCTION Calculate_Profit_Per_Month(p_Year IN NUMBER, p_Month IN NUMBER)
  RETURN NUMBER
    AS
  v_Start_Date DATE := TO_DATE(p_Year || '-' || p_Month || '-01', 'YYYY-MM-DD');
  v_End_Date DATE := LAST_DAY(v_Start_Date);
  v_Profit NUMBER := 0;
    BEGIN
  SELECT SUM(rent_Cost) INTO v_Profit
  FROM Car_Rental
  WHERE pickup_date >= v_Start_Date AND pickup_date <= v_End_Date;
  
  RETURN v_Profit;
    END;

FUNCTION CalculateRevenueByCategory(
    category_id IN NUMBER
) RETURN NUMBER
IS
    total_revenue NUMBER;
BEGIN
    SELECT SUM(rent_Cost) INTO total_revenue
    FROM Car_Rental r, car c 
    where r.car_id = c.car_id 
    and c.Car_category_id = category_id;
    
    RETURN total_revenue;
END;

FUNCTION GetRentalStatusDescription(p_status_id IN NUMBER)
    RETURN VARCHAR2
IS
    status_description VARCHAR2(20);
BEGIN
    SELECT status_description INTO status_description
    FROM Rental_status
    WHERE status_id = p_status_id;

    RETURN status_description;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;

    
END;



-- sample data

INSERT INTO Car_Category (Car_category_ID, Category_type) VALUES (1, 'Economy');

INSERT INTO Car_Category (Car_category_ID, Category_type) VALUES (2, 'SUV');

INSERT INTO Car_Category (Car_category_ID, Category_type) VALUES (3, 'LUX');

-- Manufacturer 
INSERT INTO Manufacturer (Manufacturer_ID, m_Name, Phone_Number, Office_address, Working_hours) VALUES (MANUFACTURER_seq.NEXTVAL, 'Toyota', '17787888', 'Tubli Toyota Office', '8:00 AM - 5:00 PM'); 

INSERT INTO Manufacturer (Manufacturer_ID, m_Name, Phone_Number, Office_address, Working_hours) VALUES (MANUFACTURER_seq.NEXTVAL, 'Ford', '17737373', 'Sitra office', '8:00 AM - 4:00 PM');

INSERT INTO Manufacturer (Manufacturer_ID, m_Name, Phone_Number, Office_address, Working_hours) VALUES (MANUFACTURER_seq.NEXTVAL, 'Lexus', '17771777', 'Euromotors office', '8:00 AM - 5:00 PM'); 

INSERT INTO Manufacturer (Manufacturer_ID, m_Name, Phone_Number, Office_address, Working_hours) VALUES (MANUFACTURER_seq.NEXTVAL, 'Geely', '1773723', 'Sitra office', '7:30 AM - 3:30 PM');

INSERT INTO Manufacturer (Manufacturer_ID, m_Name, Phone_Number, Office_address, Working_hours) VALUES (MANUFACTURER_seq.NEXTVAL, 'Hyundai', '1773722', 'Sitra office', '9:00 AM - 5:00 PM');

-- Model table 
INSERT INTO Model (Model_ID, Engine_Size, Make, Model_Name, model_Option, Fuel, model_Size, Manufacturer_ID) VALUES (1, '1.6L', 'Toyota', 'Corolla', 'Full option', 'Mumtaz/Jaid', 'Sedan', 1); 

INSERT INTO Model (Model_ID, Engine_Size, Make, Model_Name, model_Option, Fuel, model_Size, Manufacturer_ID) VALUES (2, '2.0L', 'Geely', 'Geely Binyue', 'low option', 'Mumtaz/Jaid', 'Midsize', 4);

INSERT INTO Model (Model_ID, Engine_Size, Make, Model_Name, model_Option, Fuel, model_Size, Manufacturer_ID) VALUES (3, '1.6L', 'Lexus', 'Lexus IS', 'Full option', 'Mumtaz/Jaid', 'Sedan', 3); 


INSERT INTO Model (Model_ID, Engine_Size, Make, Model_Name, model_Option, Fuel, model_Size, Manufacturer_ID) VALUES (4, '2.0L', 'Ford', 'Ford Expedition', 'Full option', 'Mumtaz/Jaid', 'Midsize', 2);

INSERT INTO Model (Model_ID, Engine_Size, Make, Model_Name, model_Option, Fuel, model_Size, Manufacturer_ID) VALUES (5, '2.0L', 'hyundai', 'SUV', 'Full option', 'Mumtaz/Jaid', 'Sedan', 5);

-- ExtraEquipment table 
INSERT INTO ExtraEquipment (Extra_Equipment_ID, equipment_Type, Quantity, colour, Price) VALUES (EXTRA_EQUIPMENT_seq.NEXTVAL, 'GPS Navigation', 10, 'Black', 20.00); 
INSERT INTO ExtraEquipment (Extra_Equipment_ID, equipment_Type, Quantity, colour, Price) VALUES (EXTRA_EQUIPMENT_seq.NEXTVAL, 'Child Car Seat', 5, 'Red', 15.00);

-- Customer table 
INSERT INTO Customer (Customer_ID, Nationality, First_name, Phone_Number, Address, house_number, Road, add_Block, Gender, DOB, Email, CPR_Passport) VALUES (CUSTOMER_seq.NEXTVAL, 'Bahraini', 'Hasan', '33443434', 'Boori', 1789, 5234, 752, 'Male', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'Hasan90@gmail.com', 900512309); 

INSERT INTO Customer (Customer_ID, Nationality, First_name, Phone_Number, Address, house_number, Road, add_Block, Gender, DOB, Email, CPR_Passport) VALUES (CUSTOMER_seq.NEXTVAL, 'Bahraini', 'Marya', '39895698', 'Jurdab', 32, 432, 815, 'Female', TO_DATE('2000-10-20', 'YYYY-MM-DD'), 'Marya001@hotmail.com', 0010543210);

INSERT INTO Customer (Customer_ID, Nationality, First_name, Phone_Number, Address, house_number, Road, add_Block, Gender, DOB, Email, CPR_Passport) VALUES (CUSTOMER_seq.NEXTVAL, 'Bahraini', 'Mustafa', '35343434', 'Manama', 453, 5234, 735, 'Male', TO_DATE('1998-07-04', 'YYYY-MM-DD'), 'Moos98@gmail.com', 980712309); 

INSERT INTO Customer (Customer_ID, Nationality, First_name, Phone_Number, Address, house_number, Road, add_Block, Gender, DOB, Email, CPR_Passport) VALUES (CUSTOMER_seq.NEXTVAL, 'Bahraini', 'Zainab', '39999698', 'Jufair', 34, 123, 523, 'Female', TO_DATE('1987-01-06', 'YYYY-MM-DD'), 'zainaby@hotmail.com', 9801543210);

INSERT INTO Customer (Customer_ID, Nationality, First_name, Phone_Number, Address, house_number, Road, add_Block, Gender, DOB, Email, CPR_Passport) VALUES (CUSTOMER_seq.NEXTVAL, 'Bahraini', 'Afaf', '39992345', 'Barbar', 500, 2621, 526, 'Female', TO_DATE('2001-01-06', 'YYYY-MM-DD'), 'afaf00@hotmail.com', 0101543210);


-- Car table 

--Camry
INSERT INTO Car (Car_ID, Registration_due_date, Insured, Colour, Mileage, Status, Daily_hire_rate, return_penalty, Car_Category_ID, Model_ID) VALUES (1, To_date('2024-12-31','YYYY-MM--DD'), 'Yes', 'Brown', 50, 'Available', 13.00, 20.00, 1, 1); 

--geely 
INSERT INTO Car (Car_ID, Registration_due_date, Insured, Colour, Mileage, Status, Daily_hire_rate, return_penalty, Car_Category_ID, Model_ID) VALUES (2, to_Date('2024-01-01','YYYY-MM--DD'), 'Yes', 'White', 100, 'Rented', 15.00, 20.00, 2, 2);

--Lexus 
INSERT INTO Car (Car_ID, Registration_due_date, Insured, Colour, Mileage, Status, Daily_hire_rate, return_penalty, Car_Category_ID, Model_ID) VALUES (3, to_Date('2023-11-01','YYYY-MM--DD'), 'Yes', 'Black', 100, 'Rented', 25.00, 30.00, 3, 3);

--Hyundai
INSERT INTO Car (Car_ID, Registration_due_date, Insured, Colour, Mileage, Status, Daily_hire_rate, return_penalty, Car_Category_ID, Model_ID) VALUES (4, to_Date('2024-05-05','YYYY-MM--DD'), 'Yes', 'Grey', 100, 'Rented', 12.00, 20.00, 1, 5);

--Ford Expedition
INSERT INTO Car (Car_ID, Registration_due_date, Insured, Colour, Mileage, Status, Daily_hire_rate, return_penalty, Car_Category_ID, Model_ID) VALUES (5, to_Date('2024-03-02','YYYY-MM--DD'), 'Yes', 'Red', 100, 'Rented', 16.00, 20.00, 2, 4);


-- Locations
INSERT INTO Location (location_ID, phone_number, Building, City, Address) VALUES (LOCATION_seq.NEXTVAL, '17177171', 'Building 34', 'Manama', 'Souq al manama'); 
INSERT INTO Location (location_ID, phone_number, Building, City, Address) VALUES (LOCATION_seq.NEXTVAL, '17711771', 'Building 19', 'Muharraq', 'Hidd Road');
INSERT INTO Location (location_ID, phone_number, Building, City, Address) VALUES (LOCATION_seq.NEXTVAL, '17891789', 'Building 5', 'Isa Town', 'Isa town road');

-- Rental_equp 
INSERT INTO Rental_Equipement (Car_Rent_ID, Car_Rental_ID, Extra_Equipment_ID, Quantity) VALUES (RENTAL_EQUIPeMENT_seq.nextval, 2, 2, 1);

INSERT INTO Rental_Equipement (Car_Rent_ID, Car_Rental_ID, Extra_Equipment_ID, Quantity) VALUES (RENTAL_EQUIPeMENT_seq.NEXTVAL, 3, 1, 1); 

INSERT INTO Rental_Equipement (Car_Rent_ID, Car_Rental_ID, Extra_Equipment_ID, Quantity) VALUES (RENTAL_EQUIPeMENT_seq.NEXTVAL, 4, 2, 1);

INSERT INTO Rental_Equipement (Car_Rent_ID, Car_Rental_ID, Extra_Equipment_ID, Quantity) VALUES (RENTAL_EQUIPeMENT_seq.NEXTVAL, 5, 1, 1); 



-- car_Rental
-- Car_Rental table
--Camry
INSERT INTO Car_Rental (Car_Rental_ID, Car_category, rent_Duration, rent_Cost, rent_Penalty, Car_ID, Customer_ID, status_id, location_ID, pickup_date) VALUES (CAR_RENTAL_seq.NEXTVAL, 'Economy', 3,39, 0, 1, 1, 1, 1, TO_DATE('2022-06-01', 'YYYY-MM-DD')); 

--geely 
INSERT INTO Car_Rental (Car_Rental_ID, Car_category, rent_Duration, rent_Cost, rent_Penalty, Car_ID, Customer_ID, status_id, location_ID, pickup_date) VALUES (CAR_RENTAL_seq.NEXTVAL, 'SUV', 5, 75, 0, 2, 2, 2, 2, TO_DATE('2022-06-02', 'YYYY-MM-DD'));


--lexus
INSERT INTO Car_Rental (Car_Rental_ID, Car_category, rent_Duration, rent_Cost, rent_Penalty, Car_ID, Customer_ID, status_id, location_ID, pickup_date) VALUES (CAR_RENTAL_seq.NEXTVAL, 'LUX', 5,125, 0, 3, 3, 3, 3, TO_DATE('2022-07-02', 'YYYY-MM-DD'));


--Hyundai 
INSERT INTO Car_Rental (Car_Rental_ID, Car_category, rent_Duration, rent_Cost, rent_Penalty, Car_ID, Customer_ID, status_id, location_ID, pickup_date) VALUES (CAR_RENTAL_seq.NEXTVAL, 'Economy', 5, 60, 0, 4, 4, 4, 2, TO_DATE('2022-06-02', 'YYYY-MM-DD'));

--Ford
INSERT INTO Car_Rental (Car_Rental_ID, Car_category, rent_Duration, rent_Cost, rent_Penalty, Car_ID, Customer_ID, status_id, location_ID, pickup_date) VALUES (CAR_RENTAL_seq.NEXTVAL, 'SUV', 5, 80, 0, 5, 5, 5, 3, TO_DATE('2022-06-02', 'YYYY-MM-DD'));




COMMIT;

-- VIEWS
--Most popular cars by locations
CREATE OR REPLACE VIEW popular_car_models_by_location AS
SELECT 
    cr.location_ID,c.Model_ID,
    COUNT(*) AS number_of_rentals
FROM Car_Rental cr JOIN Car c ON cr.Car_ID = c.Car_ID
GROUP BY cr.location_ID, c.Model_ID
HAVING COUNT(*) = (
  SELECT MAX(number_of_rentals) FROM (
    SELECT COUNT(*) AS number_of_rentals
    FROM Car_Rental cr2
    JOIN Car c2 ON cr2.Car_ID = c2.Car_ID
    GROUP BY cr2.location_ID, c2.Model_ID
  ) subquery
);

SELECT * FROM popular_car_models_by_location;

--june 2022
CREATE OR REPLACE VIEW Rental_Amounts_June_2022 AS
SELECT cr.location_id, l.city, SUM(cr.rent_cost) AS total_rental_amount
FROM Car_Rental cr, location l 
WHERE cr.location_id = l.location_id
AND cr.pickup_date >= DATE '2022-06-01' AND cr.pickup_date < DATE '2022-07-01'
GROUP BY cr.location_id, l.city;

select * from Rental_Amounts_June_2022;


