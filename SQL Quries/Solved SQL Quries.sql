create database hospital_management;

-- Total Revenue
select concat(round(sum(amount) / 1000, 2), 'K') as Total_Revenue from billing;

-- Total Patients
select count(patient_id) as Total_Patients from patients;

-- Total Doctors
select count(doctor_id) as Total_Doctors from doctors;

-- Total Appointments
select count(appointment_id) as Total_Appointments from appointments;

-- Avg Treatment Cost
select concat(round(avg(cost) /1000 ,2), 'K') as Avg_Treatment_Cost from treatments;

-- Avg Bill Amount
select concat(round(avg(amount) /1000 , 2), 'K') as Avg_Bill_Amount from billing;


-- Appointments by Month
update appointments set appointment_date = str_to_date(appointment_date, '%Y-%m-%d');

select count(appointment_id) as appointment, date_format(appointment_date, '%b') as month_name 
from appointments
group by month(appointment_date), date_format(appointment_date, '%b') 
order by month(appointment_date);


-- Appointments by Hospital Branch
select count(appointment_id) as appointment, d.hospital_branch from appointments as a
left join doctors as d
on a.doctor_id = d.doctor_id
group by hospital_branch;


-- Appointments by Status
select count(appointment_id) as appointment, status from appointments
group by status;


-- Total Bill by Payment Status
select count(bill_id) as Total_Bill, payment_status from billing
group by payment_status;


-- Top 5 Avg Revenue by Per Patient
select concat(round(avg(amount)/1000, 2),'K') as Avg_Revenue, concat(first_name, ' ', last_name)  as Full_Name from billing as b
left join patients as p
on b.patient_id = p.patient_id
group by Full_Name
order by avg_Revenue desc
limit 5;


-- Total Patients by Insurance Provider
select count(patient_id) as Total_Patient, insurance_provider from patients
group by insurance_provider
order by Total_Patient desc;


-- Patients Registered by Month
select count(patient_id) as patients, date_format(registration_date, '%b') as Month 
from patients
group by month(registration_date), date_format(registration_date, '%b')
order by month(registration_date);


-- Total Patients by Gender
select count(patient_id) as total_patient, replace(replace(gender, 'M', 'Male'), 'F', 'Female')
from patients
group by gender;


-- Total Patients by Reason For Visit
select count(p.patient_id) as Total_Patients, a.reason_for_visit from appointments as a
left join patients as p
on p.patient_id = a.patient_id
group by reason_for_visit
order by Total_Patients desc;


-- Patients by Age Group
select count(*),
case
when patient_age between 20 and 29 then '20-29'
when patient_age between 30 and 39  then '30-39'
when patient_age between 40 and 49  then '40-49'
when patient_age between 50 and 59 then '50-59'
when patient_age between 60 and 69  then '60-69'
when patient_age between 70 and 79  then '70-79'
else '80+'
end as Age_Group
from(
select timestampdiff(Year, date_of_birth, curdate()) as patient_age
from patients
)t
group by Age_Group
order by Age_Group;


-- Top 5 Total Appointments by Patients
select count(a.appointment_id) as Total_Appointment, concat(first_name, ' ', last_name) as Patient_Name
from appointments as a
left join patients as p
on a.patient_id = p.patient_id
group by Patient_Name
order by Total_appointment desc
limit 5;


-- Appointments by Doctor
select count(appointment_id) as Appointments , concat(first_name, ' ', last_name) as Doctor_Name from appointments as a
left join doctors as d
on a.doctor_id = d.doctor_id
group by Doctor_Name
order by Appointments desc;


-- Total Revenue by Doctor
select concat(round(sum(b.amount)/1000,0), 'K') as Total_Revenue, concat(d.first_name, ' ', d.last_name) as Doctor_Name 
from doctors as d
join appointments as a
on a.doctor_id = d.doctor_id
join treatments as t
on a.appointment_id = t.appointment_id
join billing as b
on t.treatment_id = b.treatment_id
group by Doctor_Name
order by Total_Revenue desc;


-- Avg Treatment Cost by Treatment Type
select concat(round(avg(cost)/1000,2), 'K') as avg_treatment_cost, treatment_type from treatments
group by treatment_type
order by avg_treatment_cost desc;


-- Payment Method Most Preferred by Patients
select payment_method, count(patient_id) as patient from billing
group by payment_method
order by patient desc;


-- Total Treatments by Treatment Type
select treatment_type, count(treatment_id) as Total_Treatment from treatments
group by treatment_type;


-- Total Revenue by Specialization
select d.specialization, concat(round(sum(b.amount)/1000,0), 'K') as total_revenue 
from doctors as d
join appointments as a 
on d.doctor_id = a.doctor_id
join treatments as t
on a.appointment_id = t.appointment_id
join billing as b
on t.treatment_id = b.treatment_id
group by specialization
order by total_revenue;



select * from appointments;
select * from billing;
select * from doctors;
select * from patients;
select * from treatments;
