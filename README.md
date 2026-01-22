# Data Warehouse Project (PostgreSQL)

## Overview
This project demonstrates an end-to-end Data Warehouse implementation using PostgreSQL.
It follows standard Data Engineering practices to transform raw source data into clean,
analytics-ready datasets using a layered architecture.

The final output is a business-ready Gold layer designed for reporting and analytical use cases.

---

## Architecture
The Data Warehouse follows the Medallion Architecture:

Source Data (CSV Files)  
→ Bronze Layer (Raw Data)  
→ Silver Layer (Cleaned & Standardized Data)  
→ Gold Layer (Business-Ready Data)

---

## Layers Description

### Bronze Layer
- Stores raw data ingested directly from source files
- No transformations applied
- Serves as the source of truth

### Silver Layer
- Cleans and standardizes raw data
- Handles null values, data types, and formatting
- Applies basic business rules
- Prepares data for analytics

### Gold Layer
- Final consumption layer
- Designed using Star Schema
- Contains dimension and fact views
- Optimized for reporting and BI tools

Gold Layer Objects:
- Dimension: Customers
- Dimension: Products
- Fact: Sales

---

## Tech Stack
- Database: PostgreSQL
- SQL Concepts Used:
  - Views
  - Window Functions (ROW_NUMBER)
  - Joins
  - Star Schema Modeling
- Architecture Pattern: Medallion Architecture

---

## Project Structure
- bronze: raw data tables
- silver: cleaned and transformed tables
- gold: dimension and fact views
- README.md

---

## Key Learnings
- Data Warehouse design principles
- Medallion Architecture implementation
- Star Schema modeling
- Analytical SQL using PostgreSQL
- Real-world Data Engineering project structure

---

## Project Status
Completed  
PostgreSQL based  
Interview-ready Data Warehouse project
