# 🏥 Hospital Database Creation & Data Migration

A comprehensive **MySQL-based Hospital Database Management System** designed to demonstrate relational database design, data migration, data integrity, and SQL programming. This project transforms raw hospital data into a structured relational database while implementing constraints, triggers, and stored procedures to efficiently manage healthcare information.

---

## 📖 Overview

This project focuses on designing and implementing a normalized hospital database capable of managing patients, doctors, departments, appointments, prescriptions, laboratory reports, and billing information.

The project demonstrates the complete database development lifecycle—from schema creation and data migration to implementing business rules using SQL triggers and stored procedures.

---

## 🛠️ Tools & Technologies

<p align="left">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Database%20Design-005C84?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Relational%20Database-4CAF50?style=for-the-badge"/>
</p>

---

## 🎯 Objectives

- Design a normalized relational hospital database
- Migrate raw hospital data into structured SQL tables
- Maintain data integrity using constraints and foreign keys
- Automate business validations using SQL triggers
- Implement stored procedures for data retrieval and reporting
- Demonstrate efficient healthcare database management

---

## 🗄️ Database Modules

The database consists of multiple interconnected tables:

- 🏥 Departments
- 👨‍⚕️ Doctors
- 🧑‍🤝‍🧑 Patients
- 📅 Appointments
- 💊 Prescriptions
- 🧪 Lab Reports
- 💳 Bills

These tables are connected using **Primary Keys** and **Foreign Keys** to ensure referential integrity.

---

## ✨ Features

- Relational database schema design
- Data migration from CSV to MySQL
- Primary & Foreign Key implementation
- Data validation using CHECK constraints
- Appointment validation using SQL Trigger
- Role-based data retrieval using Stored Procedures
- Monthly revenue reporting
- Structured healthcare data management

---

## 📌 SQL Concepts Used

- DDL (CREATE, ALTER)
- DML (INSERT, SELECT)
- Primary Keys
- Foreign Keys
- CHECK Constraints
- AUTO_INCREMENT
- JOIN Operations
- Aggregate Functions
- GROUP BY
- Stored Procedures
- Triggers
- Date & Time Functions
- INFORMATION_SCHEMA

---

## 📊 Key Functionalities

### 👤 Patient Management
- Store patient demographic information
- Maintain patient records
- Enforce data validation

### 👨‍⚕️ Doctor Management
- Department mapping
- Specialization tracking
- Role management

### 📅 Appointment Management
- Schedule appointments
- Prevent overlapping appointments using triggers
- Track appointment status

### 💳 Billing System
- Store billing information
- Manage payment status
- Generate monthly revenue reports

### 🧪 Laboratory Reports
- Store diagnostic reports
- Link reports with appointments

### 💊 Prescription Management
- Record prescribed medications
- Maintain dosage information
- Associate prescriptions with appointments

---

## 🔒 Database Integrity

The project ensures reliable data management using:

- Primary Keys
- Foreign Keys
- CHECK Constraints
- Trigger-based validations
- Referential Integrity
- Date validation
- Duplicate appointment prevention

---

## 📚 Learning Outcomes

Through this project, I gained hands-on experience in:

- Relational Database Design
- Database Normalization
- MySQL Database Development
- Data Migration
- SQL Programming
- Trigger Implementation
- Stored Procedure Development
- Healthcare Database Management
- Data Integrity & Validation

---

## 🚀 Future Enhancements

- Python-based ETL pipeline
- Interactive Power BI Dashboard
- Automated CSV import
- Role-based authentication
- Query optimization using indexes
- Advanced analytical SQL reports

---
