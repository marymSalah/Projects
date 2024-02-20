# Car Rental System 
## Introduction - Oracle SQL
This project is a database system designed for a car rental company developed using Oracle SQL. It serves as a centralized solution to store information about the company, cars, locations, manufacturers, and rentals. The system streamlines various functions and automates processes in the car rental workflow, making it easier for employees to track, monitor, and report on data.

### Entity-Relationship Diagram (ERD)
The ERD comprises 10 entities, including Car Rental, Rental Status, Location, Customer, Car, Car Category, Model, Manufacturer, Extra Equipment, and Rental Equipment. These entities are interconnected to represent the relationships within the system.

### Relationships between Entities
The relationships between entities are established through foreign keys, ensuring data integrity. Examples include relationships between Car and Model, Model and Manufacturer, Car Category and Car, Car Rental and Car, and more.

### Triggers
Triggers, such as status_update_trigger and update_equipment_quantity, are implemented to automate status updates, equipment quantity adjustments, and other dynamic processes within the database.

### Functions
Several functions are provided for calculating profit, revenue by category, retrieving rental status descriptions, and checking available cars by model.

### Procedures
Procedures, like Add_Customer, Count_Rentals_Per_Month, Add_Car, and UpdateWorkingHours, enable the addition of customers, counting rentals, adding cars, and updating manufacturer working hours.

### Packages
The rentals package contains functions and procedures related to rental operations, offering functionalities like counting rentals per month, calculating profit, revenue, and retrieving rental status descriptions.

### Views
Views such as popular_car_models_by_location and Rental_Amounts_June_2022 provide insights into popular car models by location and rental amounts for June 2022.

### DDL Commands
DDL commands include the creation of tables, indexes, sequences, and views necessary for the project.

### DCL Commands
Role-based access control is implemented with roles like admin_CAR and manager_car, granting specific permissions to different roles.

### DML Commands 
DML Commands were used to add sample data into the database.

#### Visual representation 
+----------------+          +--------------+        +------------------+
| Manufacturer   |          | Model        |        | ExtraEquipment   |
+----------------+          +--------------+        +------------------+
| Manufacturer_ID|----|     | Model_ID     |        | Extra_Equipment_ID|
| m_Name         |    |     | Engine_Size  |        | equipment_Type   |
| Phone_Number   |    |     | Make         |        | Quantity         |
| Office_address |    |     | Model_Name   |        | colour           |
| Working_hours  |    |     | model_Option |        | Price            |
+----------------+    |     | Fuel         |        +------------------+
                      |     | model_Size   |
                      |     | Manufacturer_ID|
                      |     +--------------+
                      |
                      |
+----------------+    |
| Customer       |    |    +------------------+
+----------------+    |    | Rental_status    |
| Customer_ID    |-----|    +------------------+
| Nationality    |    |    | status_id        |
| First_name     |    |    | Return_Time      |
| Phone_Number   |    |    | complications   |
| Address        |    |    | status_description|
| house_number   |    |    +------------------+
| Road           |    |
| add_Block      |    |
| Gender         |    |
| DOB            |    |
| Email          |    |
| CPR_Passport   |    |
+----------------+    |
                      |
                      |    +--------------+
                      |    | Car          |
                      |    +--------------+
                      |    | Car_ID       |
                      |    | Registration_due_date|
                      |    | Insured      |
                      |    | Colour       |
                      |    | Mileage      |
                      |    | Status       |
                      |    | Daily_hire_rate|
                      |    | return_penalty|
                      |    | Car_Category_ID|
                      |    | Model_ID     |
                      |    +--------------+
                      |
                      |
                      |    +--------------+
                      |    | Location     |
                      |    +--------------+
                      |    | location_ID  |
                      |    | phone_number |
                      |    | Building     |
                      |    | City         |
                      |    | Address      |
                      |    +--------------+
                      |
                      |    +--------------+
                      |    | Car_Rental   |
                      |    +--------------+
                      |    | Car_Rental_ID|
                      |----| Car_category |
                           | rent_Duration |
                           | rent_Cost     |
                           | rent_Penalty  |
                           | Car_ID        |
                           | Customer_ID   |
                           | status_id     |
                           | location_ID   |
                           | pickup_date   |
                           +--------------+
                           |
                           +---------------------+
                           | Rental_Equipement   |
                           +---------------------+
                           | Car_Rent_ID         |
                           | Car_Rental_ID       |
                           | Extra_Equipment_ID  |
                           | Quantity            |
                           +---------------------+
                           


