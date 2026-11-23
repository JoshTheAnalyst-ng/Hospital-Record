-- show patient's, first_name, last_name, gender and height for female patients (F) taller than 160, tallest first, and show only the first 10.
SELECT first_name,
    last_name,
    gender,
    height
FROM patients
WHERE gender = 'F'
    AND height > 160
ORDER BY height DESC
LIMIT 10;
-- From admissions, list each different diagnosis once, sorted A to Z.
SELECT DISTINCT Diagnosis
FROM admissions
ORDER BY diagnosis ASC;
-- From patients, count the patients in each city, named Total_Patients, largest first.
SELECT City,
    COUNT(patient_id) AS Total_Patients
FROM patients
GROUP BY city
ORDER BY Total_Patients DESC;
-- From patients, for each gender show the average height named Avg_Height and the average weight named Avg_Weight, highest Avg_Weight first.
SELECT Gender,
    AVG(height) AS Avg_Height,
    AVG(weight) AS Avg_Weight
FROM patients
GROUP by gender
ORDER BY Avg_Weight DESC;
-- From admissions, find the 5 attending_doctor_id values with the most admissions, named Total_Admissions.
SELECT attending_doctor_id,
    COUNT(*) AS Total_Admissions
FROM admissions
GROUP BY attending_doctor_id
ORDER BY Total_Admissions DESC
LIMIT 5;
-- Using patients and province_names, show the number of patients in each province_name, named Total_Patients, largest first.
SELECT pn.Province_name,
    COUNT(p.patient_id) AS Total_Patients
FROM patients AS p
    LEFT JOIN province_names AS pn ON p.province_id = pn.province_id
GROUP BY pn.province_name
ORDER BY Total_Patients DESC;
-- Using admissions and doctors, show each doctor's first_name, last_name and specialty with the number of admissions they handled, named Total_Admissions, highest first.
SELECT first_name,
    last_name,
    specialty,
    COUNT(a.patient_id) AS Total_Admissions
FROM admissions AS a
    LEFT JOIN doctors AS d ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id,
    first_name,
    last_name,
    specialty
ORDER BY Total_Admissions DESC;
-- Using admissions, patients and province_names, show the number of admissions for each province_name, named Total_Admissions, highest first
SELECT Province_name,
    COUNT(a.patient_id) AS Total_Admissions
FROM admissions AS a
    INNER JOIN patients AS p ON a.patient_id = p.patient_id
    INNER JOIN province_names AS pn ON p.province_id = pn.province_id
GROUP BY Province_name
ORDER BY Total_Admissions DESC;
-- Show the patient_id, first_name and last_name of patients who have never been admitted.
SELECT p.patient_id,
    first_name,
    last_name
FROM patients p
    LEFT JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.patient_id IS NULL;
-- Using admissions, patients and doctors, for female patients only (F), show each doctor specialty with the number of admissions, named Total_Admissions, highest first
SELECT specialty,
    COUNT(a.patient_id) AS Total_Admissions
FROM admissions a
    INNER JOIN patients p ON a.patient_id = p.patient_id
    INNER JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE gender = 'F'
GROUP BY specialty
ORDER BY Total_Admissions DESC