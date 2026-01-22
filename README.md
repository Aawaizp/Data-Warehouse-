# Data-Warehouse-
Overview
This project implements an end-to-end Data Warehouse solution using PostgreSQL.
It follows industry-standard Data Engineering practices to transform raw data into analytics-ready datasets using a layered architecture.

The project is designed to support reporting, analysis, and business intelligence use cases.

🏗️ Architecture
The Data Warehouse follows the Medallion Architecture:

Source Data (CSV Files)
→ Bronze Layer (Raw Data)
→ Silver Layer (Cleaned and Standardized Data)
→ Gold Layer (Business-Ready Data)

🧱 Layers Description

🥉 Bronze Layer

Stores raw data ingested from source files

No transformations applied

Acts as the source of truth

🥈 Silver Layer

Data cleaning and standardization

Handling null values and data types

Business rules applied

Prepares data for analytics

🥇 Gold Layer

Final consumption layer

Designed using Star Schema

Contains dimension and fact views

Optimized for reporting and analytics

Gold Layer Objects:

Dimension Tables: Customers, Products

Fact Table: Sales

🛠️ Tech Stack

Database: PostgreSQL

SQL Features Used:

Views

Window Functions (ROW_NUMBER)

Joins

Star Schema Modeling

Architecture Pattern: Medallion Architecture

📂 Project Structure
bronze – raw data tables
silver – cleaned and transformed tables
gold – dimension and fact views
README.md

🎯 Key Learnings

Data Warehouse design principles

Medallion Architecture implementation

Star Schema modeling

Analytical SQL using PostgreSQL

Real-world Data Engineering project structure
