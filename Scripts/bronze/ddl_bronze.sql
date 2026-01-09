/*
===============================================================================
PostgreSQL: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This script loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses client-side \copy command to load data from CSV files to bronze tables.
    - Tracks the start and end time of each load.

Note:
    1. This script is for PostgreSQL 13+.
    2. \copy is a psql (client-side) command. It works in pgAdmin Query Tool or psql.
    3. The CSV files must be accessible from your local machine (client), not the server.

Manual Import Notes (for Git documentation):
    - Right-click the target table in pgAdmin → Import/Export.
    - Select CSV file path.
    - Format: CSV
    - Check "Header" if CSV has column names.
    - Delimiter: ,
    - Quote: "
    - Click OK to load.
    - Repeat for all bronze tables.
===============================================================================
*/
-- ============================================================================
-- PostgreSQL: Load Bronze Layer (Source -> Bronze)
-- ============================================================================
-- This script truncates and loads CSV data into bronze tables.
-- Note: \copy is a client-side command. Run in pgAdmin Query Tool or psql.
-- ============================================================================

-- CRM Tables
TRUNCATE TABLE bronze.crm_cust_info;
\copy bronze.crm_cust_info(cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date)
FROM 'C:/sql/dwh_project/datasets/source_crm/cust_info.csv' WITH (FORMAT csv, HEADER, DELIMITER ',', QUOTE '"');

TRUNCATE TABLE bronze.crm_prd_info;
\copy bronze.crm_prd_info(prd_id, prd_name, prd_category)
FROM 'C:/sql/dwh_project/datasets/source_crm/prd_info.csv' WITH (FORMAT csv, HEADER, DELIMITER ',', QUOTE '"');

TRUNCATE TABLE bronze.crm_sales_details;
\copy bronze.crm_sales_details(sale_id, cst_id, prd_id, sale_date, sale_amount)
FROM 'C:/sql/dwh_project/datasets/source_crm/sales_details.csv' WITH (FORMAT csv, HEADER, DELIMITER ',', QUOTE '"');

-- ERP Tables
TRUNCATE TABLE bronze.erp_loc_a101;
\copy bronze.erp_loc_a101(loc_id, loc_name, loc_region)
FROM 'C:/sql/dwh_project/datasets/source_erp/loc_a101.csv' WITH (FORMAT csv, HEADER, DELIMITER ',', QUOTE '"');

TRUNCATE TABLE bronze.erp_cust_az12;
\copy bronze.erp_cust_az12(cust_id, cust_name, cust_region)
FROM 'C:/sql/dwh_project/datasets/source_erp/cust_az12.csv' WITH (FORMAT csv, HEADER, DELIMITER ',', QUOTE '"');

TRUNCATE TABLE bronze.erp_px_cat_g1v2;
\copy bronze.erp_px_cat_g1v2(cat_id, cat_name, cat_group)
FROM 'C:/sql/dwh_project/datasets/source_erp/px_cat_g1v2.csv' WITH (FORMAT csv, HEADER, DELIMITER ',', QUOTE '"');

