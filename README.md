# School Management System Database

## Project Overview

This project involves designing a relational database to manage the information of a school, including students, teachers, grades, promotions, absences, and subject assignments. The goal is to modernize the school’s information management system and ensure that all data is stored securely and efficiently.

## Database Design

The database schema has been designed using the principles of normalization up to the **third normal form (3NF)**. The design consists of several entities, including `Teacher`, `Student`, `Subject`, `Grade`, `Absence`, `Promotion`, and `PromotionHistory`, with appropriate relationships between them.

### Entity Relationship Diagram (ERD)

The schema is structured as follows:

- **Teacher**: Contains information about teachers (name, email, date of joining).
- **Student**: Contains information about students (name, email, promotion).
- **Subject**: Contains information about the subjects (name).
- **Grade**: Stores students' grades for each subject, along with the teacher who evaluated the student.
- **Absence**: Tracks the absences of students, including whether they were justified and the duration.
- **Promotion**: Represents the different promotions in the school.
- **PromotionHistory**: Keeps a record of the student's past promotions for historical purposes.
- **TeacherSubject**: Represents the many-to-many relationship between teachers and subjects.

### Tables and Attributes

- **Teacher**: `id`, `first_name`, `last_name`, `email`, `date_of_joining`
- **Subject**: `id`, `subject_name`
- **Student**: `id`, `first_name`, `last_name`, `email`, `promotion_id`
- **Grade**: `id`, `student_id`, `subject_id`, `teacher_id`, `grade`, `date_of_publication`
- **Absence**: `id`, `student_id`, `absence_date`, `minutes_late`, `justified`
- **Promotion**: `id`, `promotion_name`
- **PromotionHistory**: `id`, `student_id`, `promotion_id`, `year`
- **TeacherSubject**: `teacher_id`, `subject_id`

## SQL Script

### Create Database Schema

The SQL script `create_schema.sql` contains the instructions for creating all the tables, establishing relationships, and setting constraints (primary and foreign keys, unique constraints, etc.).
