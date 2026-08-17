-- ============================================
-- OLA BOOKING ANALYTICS
-- SQL ANALYSIS
-- ============================================

create database Ola;
 
create table Bookings(
    Booking_ID varchar(20),
    `Date` varchar(50),     
    `Time` varchar(50),     
    Booking_Status varchar(20),
    Customer_ID varchar(20),
    Vehicle_Type varchar(50),
    Pickup_Location varchar(255),
    Drop_Location varchar(255),
    V_TAT varchar(50),
    C_TAT varchar(50),
    Canceled_Rides_by_Customer varchar(100),
    Canceled_Rides_by_Driver varchar(100),
    Incomplete_Rides varchar(10),
    Incomplete_Rides_Reason varchar(255),
    Booking_Value int,
    Payment_Method varchar(50),
    Ride_Distance decimal(5,2),
    Driver_Ratings varchar(50),   
    Customer_Rating varchar(50),
    Vehicle_Images varchar(250)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bookings.csv' 
INTO TABLE Bookings
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
(`Date`, `Time`, Booking_ID, Booking_Status, Customer_ID,
Vehicle_Type, Pickup_Location, Drop_Location, V_TAT,
C_TAT, Canceled_Rides_by_Customer, Canceled_Rides_by_Driver,
Incomplete_Rides, Incomplete_Rides_Reason, Booking_Value,
Payment_Method, Ride_Distance, Driver_Ratings, Customer_Rating,
Vehicle_Images);


Use OLa;
select * from bookings;

-- Q1. Retrieve All Successful Bookings
Create View  Successful_Bookings as
select * from 
bookings where Booking_Status = 'Success';

-- Answer 1
select * from Successful_Bookings;


-- Q2. Average Ride Distance for Each Vehicle Type

Create View ride_distance_for_each_vehicle as
select Vehicle_Type, Avg(Ride_distance)
as avg_distance from bookings
group by Vehicle_Type;

-- Answer 
select * from ride_distance_for_each_vehicle;


-- Q3. Total Number of Cancelled Rides by Customers
Create view Canceled_Rides_by_Customer as
Select count(*) 
from bookings where Booking_status = 'Canceled_Rides_by_Customer';

-- Answer
select * from  Canceled_Rides_by_Customer;


-- Q4. Top 5 Customers by Number of Rides Booked
Create View  Total_Rides as
Select Customer_ID, Count(Booking_ID) as Total_Rides
from bookings
group by Customer_ID
order by  Total_Rides desc Limit 5;

-- Answer
select * from  Total_Rides;


-- Q5. Rides Cancelled by Drivers Due to Personal and Car-Related Issues
Create view cancelled_by_drivers_P_C_Issues as
Select count(*) from bookings 
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

-- Answer
select * from cancelled_by_drivers_P_C_Issues;


-- Q6. Maximum and Minimum Driver Ratings for Prime Sedan Bookings
create view maximum_and_minimum_driver_ratings as
select Max(Driver_Ratings) as Max_rating,
Min(Driver_Ratings) as Min_rating
from bookings where Vehicle_Type = 'Prime Sedan';

-- Answer
select * from maximum_and_minimum_driver_ratings;


-- Q7. Rides Where Payment Was Made Using UPI
Create view rides_payment_using_UPI as
select count(Payment_Method) from bookings 
where Payment_Method = 'UPI';

-- Answer
select * from rides_payment_using_UPI;



-- Q8. Average Customer Rating per Vehicle Type
Create view average_customer_rating_per_vehicle_type as
select Vehicle_Type, avg(Customer_Rating) as avg_customer_rating
from bookings
group by Vehicle_Type;

-- Answer
select * from average_customer_rating_per_vehicle_type;


-- Q9. Total Booking Value of Successfully Completed Rides
Create view total_booking_value_rides_completed_success as
select sum(Booking_Value) 
from bookings
where Booking_Status = 'Success';

-- Answer
select * from  total_booking_value_rides_completed_success;


-- Q10. Incomplete Rides Along with the Reason
Create View incomplete_rides_with_reasons as
select Booking_ID,Incomplete_Rides_Reason
from bookings
where Incomplete_Rides = 'Yes';

-- Answer
select * from incomplete_rides_with_reasons;
