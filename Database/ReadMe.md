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

