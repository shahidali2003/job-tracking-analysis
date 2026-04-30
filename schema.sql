-- jobs table
CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    company_name TEXT NOT NULL,
    role TEXT NOT NULL,
    status TEXT CHECK (status IN ('applied','interview','rejected','offer')) DEFAULT 'applied',
    applied_date DATE,
    job_link TEXT,
    location TEXT,
    priority TEXT CHECK (priority IN ('high','medium','low')) DEFAULT 'medium',
    expected_salary NUMERIC,
    notes TEXT
);

-- activities table
CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    job_id INT REFERENCES jobs(id) ON DELETE CASCADE,
    activity_type TEXT CHECK (activity_type IN ('applied','call','interview','followup')),
    activity_date DATE,
    notes TEXT
);


INSERT INTO jobs (company_name, role, status, applied_date, job_link, location, priority, expected_salary, notes) VALUES
('TCS','Data Analyst','applied','2026-04-01','link1','Mumbai','high',600000,''),
('Infosys','BI Analyst','interview','2026-04-02','link2','Bangalore','medium',700000,''),
('Wipro','Data Analyst','rejected','2026-04-03','link3','Hyderabad','low',500000,''),
('Accenture','Data Analyst','offer','2026-04-04','link4','Pune','high',800000,''),
('Deloitte','Data Analyst','applied','2026-04-05','link5','Delhi','medium',750000,''),
('Capgemini','BI Analyst','interview','2026-04-06','link6','Noida','high',720000,''),
('Cognizant','Data Analyst','applied','2026-04-07','link7','Chennai','low',550000,''),
('HCL','Data Analyst','rejected','2026-04-08','link8','Lucknow','medium',500000,''),
('Tech Mahindra','BI Analyst','offer','2026-04-09','link9','Pune','high',780000,''),
('IBM','Data Analyst','applied','2026-04-10','link10','Bangalore','high',900000,''),
('Amazon','Data Analyst','interview','2026-04-11','link11','Hyderabad','high',1200000,''),
('Flipkart','BI Analyst','applied','2026-04-12','link12','Bangalore','medium',950000,''),
('Google','Data Analyst','rejected','2026-04-13','link13','Hyderabad','high',1500000,''),
('Microsoft','Data Analyst','offer','2026-04-14','link14','Noida','high',1400000,''),
('Swiggy','BI Analyst','applied','2026-04-15','link15','Bangalore','low',650000,''),
('Zomato','Data Analyst','interview','2026-04-16','link16','Delhi','medium',700000,''),
('Paytm','Data Analyst','applied','2026-04-17','link17','Noida','low',600000,''),
('Razorpay','BI Analyst','offer','2026-04-18','link18','Bangalore','high',1100000,''),
('Ola','Data Analyst','rejected','2026-04-19','link19','Bangalore','medium',750000,''),
('Uber','Data Analyst','applied','2026-04-20','link20','Hyderabad','high',1300000,'');




INSERT INTO activities (job_id, activity_type, activity_date, notes) VALUES
(1,'applied','2026-04-01',''),
(2,'interview','2026-04-03',''),
(3,'applied','2026-04-03',''),
(4,'followup','2026-04-05',''),  -- offer ❌
(5,'applied','2026-04-05',''),
(6,'call','2026-04-07',''),
(7,'applied','2026-04-07',''),
(8,'followup','2026-04-09',''),  -- rejected ❌
(9,'followup','2026-04-10',''),  -- offer ❌
(10,'applied','2026-04-10',''),
(11,'interview','2026-04-12',''),
(12,'applied','2026-04-12',''),
(13,'followup','2026-04-14',''), -- rejected ❌
(14,'followup','2026-04-15',''),
(15,'applied','2026-04-15',''),
(16,'interview','2026-04-17',''),
(17,'applied','2026-04-17',''),
(18,'followup','2026-04-19',''),
(19,'followup','2026-04-20',''),
(20,'applied','2026-04-20','');


select * from jobs;
select * from activities;


SELECT status, COUNT(*) 
FROM jobs 
GROUP BY status;


SELECT * 
FROM jobs 
ORDER BY applied_date DESC;

SELECT company_name, role, status
FROM jobs
WHERE priority = 'high';

SELECT 
    j.company_name,
    j.role,
    a.activity_type,
    a.activity_date
FROM activities a
JOIN jobs j ON a.job_id = j.id
ORDER BY a.activity_date DESC;

SELECT 
    j.company_name,
    COUNT(a.id) AS total_activities
FROM jobs j
LEFT JOIN activities a ON j.id = a.job_id
GROUP BY j.company_name;

SELECT 
    COUNT(*) FILTER (WHERE status = 'interview') AS interviews,
    COUNT(*) FILTER (WHERE status = 'offer') AS offers
FROM jobs;