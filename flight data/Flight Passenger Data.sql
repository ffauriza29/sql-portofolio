#7. Berapa rata-rata skor kepuasan penerbangan (Flight_Satisfaction_Score)  untuk setiap kelas tempat duduk (Seat_Class)?
Select Seat_Class, round(avg(Flight_Satisfaction_Score),2) As 'Average Score'
From synthetic_flight_passenger_data
Group By Seat_Class
Order By round(avg(Flight_Satisfaction_Score),2) Desc;

#8. Berapa banyak penumpang yang menggunakan metode check-in tertentu (Check_in_Method)?
Select 
	Check_in_Method, 
    count(Passenger_ID) as 'Total Passenger', 
    round((count(Passenger_ID)/(Select count(Passenger_ID) From synthetic_flight_passenger_data))*100,2) As 'Percentage (%)'
From synthetic_flight_passenger_data
Group By Check_in_Method
order by count(Passenger_ID) Desc;

#9. Berapa banyak penerbangan yang mengalami delay lebih dari 30 menit?
Select count(Delay_Minutes)
From synthetic_flight_passenger_data
Where Delay_Minutes > 30;

#10. Berapa rata-rata harga tiket untuk setiap bandara tujuan (Arrival_Airport)?
Select Arrival_Airport, round(avg(Price_USD),2) As 'Average Price (USD)'
From synthetic_flight_passenger_data
Group by Arrival_Airport
Order by round(avg(Price_USD),2);

#Tambahan
SELECT Airline,
       AVG(Flight_Duration_Minutes) AS Avg_Duration,
       AVG(Distance_Miles) AS Avg_Distance
FROM synthetic_flight_passenger_data
GROUP BY Airline;

#Tambahan
WITH Early_Booking AS (
    SELECT COUNT(*) AS Count_Early_Booking
    FROM synthetic_flight_passenger_data
    WHERE Booking_Lead_Time > 30 AND Delay_Minutes > 60
),
Late_Booking AS (
    SELECT COUNT(*) AS Count_Late_Booking
    FROM synthetic_flight_passenger_data
    WHERE Booking_Lead_Time <= 30 AND Delay_Minutes > 60
)
SELECT 
    Early_Booking.Count_Early_Booking,
    Late_Booking.Count_Late_Booking
FROM Early_Booking, Late_Booking;