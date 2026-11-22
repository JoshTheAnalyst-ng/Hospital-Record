-- PRACTICING JOINS
-- Show each doctor's first_name, last_name and specialty together with the number of admissions they attended. Include only doctors who have attended at least one admission, and sort by that number from highest to lowest.
SELECT d.first_name,
    d.last_name,
    d.specialty,
    COUNT(*) AS Total_admissions
FROM doctors d
    INNER JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY d.doctor_id,
    d.first_name,
    d.last_name,
    d.specialty
ORDER BY total_admissions DESC;
-- For each province_name, show the number of patients and their average weight. Sort the provinces by average weight from highest to lowest.
SELECT Province_Name,
    COUNT(patient_id) AS Patient_No,
    AVG(weight) AS Average_Weight
FROM patients AS p
    INNER JOIN province_names AS pn ON p.province_id = pn.province_id
GROUP BY province_name
ORDER BY Average_Weight DESC;
-- Show every patient's first_name, last_name and city with the number of admissions they have had. Patients with no admissions must still appear, with 0. Sort by number of admissions from highest to lowest, then by last_name alphabetically
SELECT p.First_name,
    p.Last_name,
    p.City,
    COUNT(a.patient_id) AS No_of_Admission
FROM patients as p
    LEFT JOIN admissions AS a ON p.patient_id = a.patient_id
GROUP BY p.First_name,
    p.Last_name,
    p.City
ORDER BY No_of_Admission DESC,
    p.last_name;
-- Show every doctor's first_name, last_name and specialty with the number of admissions they attended from 2019-01-01 onward. Doctors with no such admissions must still appear, with 0.
SELECT d.first_name,
    d.last_name,
    d.specialty,
    COUNT(a.attending_doctor_id) AS admissions_from_2019
FROM doctors AS d
    LEFT JOIN admissions AS a ON d.doctor_id = a.attending_doctor_id
    AND a.admission_date >= '2019-01-01'
GROUP BY d.doctor_id,
    d.first_name,
    d.last_name,
    d.specialty;
-- Show every province_name with the number of patients living there, including provinces that have no patients (show 0). Sort by number of patients from highest to lowest, then by province_name alphabetically.
SELECT Province_Name,
    COUNT(patient_id) AS Patients
FROM patients AS p
    RIGHT JOIN province_names AS pn ON p.province_id = pn.province_id
GROUP BY province_name
ORDER BY Patients DESC,
    pn.province_name;
-- Show every patient and every admission in one result with the columns first_name, last_name, admission_date and diagnosis. A patient with no admission should show Not admitted as the diagnosis, and an admission with no patient should show Unknown as the first_name.
SELECT p.first_name,
    p.last_name,
    a.admission_date,
    IF(
        a.patient_id IS NULL,
        'Not admitted',
        a.diagnosis
    ) AS diagnosis
FROM patients p
    LEFT JOIN admissions a ON p.patient_id = a.patient_id
UNION ALL
SELECT 'Unknown' AS first_name,
    p.last_name,
    a.admission_date,
    a.diagnosis
FROM patients p
    RIGHT JOIN admissions a ON p.patient_id = a.patient_id
WHERE p.patient_id IS NULL;
-- Show only the unmatched records between patients and province_names: patients whose province has no match, and provinces that have no patients. Display first_name, last_name and province_name.
SELECT p.first_name,
    p.last_name,
    pn.province_name
FROM patients p
    LEFT JOIN province_names pn ON p.province_id = pn.province_id
WHERE pn.province_id IS NULL
UNION ALL
SELECT p.first_name,
    p.last_name,
    pn.province_name
FROM patients p
    RIGHT JOIN province_names pn ON p.province_id = pn.province_id
WHERE p.patient_id IS NULL;