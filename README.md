# Hospital Records SQL Practice
SQL queries I wrote while learning, from SELECT basics to joins, all on one hospital database in MySQL.

## Database: `hospital_record`
| Table | Columns |
|---|---|
| `patients` | patient_id, first_name, last_name, gender, birth_date, city, province_id, allergies, height, weight |
| `admissions` | patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id |
| `doctors` | doctor_id, first_name, last_name, specialty |
| `province_names` | province_id, province_name |

Relationships:
- `patients.province_id` links to `province_names.province_id`
- `admissions.patient_id` links to `patients.patient_id`
- `admissions.attending_doctor_id` links to `doctors.doctor_id`

## Tools
MySQL, VS Code with SQLTools, Git and GitHub
