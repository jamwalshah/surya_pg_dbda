create database week2;
use week2;
CREATE TABLE student(
student_id INTEGER,
student_name VARCHAR(50),
course_id varchar(10)
);

INSERT INTO student (student_id, student_name, course_id) VALUES
(1, 'John', 'CS-101'),
(2, 'Jane', 'CS-101'),
(3, 'Dave', 'CS-201'),
(4, 'Alice', 'CS-201'),
(5, 'Bob', 'CS-301'),
(6, 'Frank', 'CS-301'),
(7, 'Johny', 'CS-601'),
(8, 'Jane D', 'CS-501'),
(9, 'Dave John', 'CS-401'),
(10, 'D John', 'CS-701');

CREATE TABLE course_detail (
course_id varchar(10),
course_name VARCHAR(50),
Student_id integer
);


INSERT INTO course_detail (course_id, course_name,Student_id) VALUES
('CSE-101', 'Computer Programming',1),
('CSE-102', 'Data Structure',2),
('CSE-103', 'Database Management System',1),
('CSE-104', 'Computer Network',4),
('CSE-105', 'Operating System',6);

Select * from student;
Select * from course_detail;