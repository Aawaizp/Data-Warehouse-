/*
===============================================================================
DDL Script: Create Gold Layer Views (PostgreSQL)
===============================================================================
Script Purpose:
    This script creates the Gold layer views for the Data Warehouse.

    The Gold layer represents the final business-ready data model
    using a Star Schema approach (Dimensions + Fact).

    - Dimensions contain descriptive attributes
    - Fact table contains measurable business metrics

    Data Source:
        - Silver Layer (Cleaned & standardized data)

Usage:
    - These views are used directly for analytics, BI, and reporting
    - Gold layer is read-only and optimized for consumption

===============================================================================
*/

-- =============================================================================
-- Drop Existing Views (Safe for Re-run)
-- =============================================================================
DROP VIEW IF EXISTS gold.fact_sales;
DROP VIEW IF EXISTS gold.dim_products;
DROP VIEW IF EXISTS gold.dim_customers;

-- =============================================================================
-- Create Dimension View: gold.dim_customers
-- =============================================================================
-- Business Entity: Customers
-- Grain: One row per customer
-- Surrogate Key: customer_key
-- =============================================================================

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY ci.cst_id)        AS customer_key,      -- Surrogate key
    ci.cst_id                                     AS customer_id,       -- Natural key
    ci.cst_key                                    AS customer_number,
    ci.cst_firstname                              AS first_name,
    ci.cst_lastname                               AS last_name,
    la.cntry                                      AS country,
    ci.cst_marital_status                         AS marital_status,

    -- Gender logic:
    -- CRM is primary source, ERP is fallback
    CASE
        WHEN ci.cst_gndr <> 'N/A' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'N/A')
    END                                           AS gender,

    ca.bdate                                      AS birthdate,
    ci.cst_create_date                            AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
       ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
       ON ci.cst_key = la.cid;


-- =============================================================================
-- Create Dimension View: gold.dim_products
-- =============================================================================
-- Business Entity: Products
-- Grain: One row per active product
-- Surrogate Key: product_key
-- =============================================================================

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, -- Surrogate key
    pn.prd_id                                               AS product_id,  -- Natural key
    pn.prd_key                                              AS product_number,
    pn.prd_nm                                               AS product_name,
    pn.cat_id                                               AS category_id,
    pc.cat                                                  AS category,
    pc.subcat                                               AS subcategory,
    pc.maintenance                                          AS maintenance,
    pn.prd_cost                                             AS cost,
    pn.prd_line                                             AS product_line,
    pn.prd_start_dt                                         AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
       ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;     -- Only active products


-- =============================================================================
-- Create Fact View: gold.fact_sales
-- =============================================================================
-- Business Process: Sales
-- Grain: One row per order line
-- Measures: sales_amount, quantity, price
-- =============================================================================

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num        AS order_number,
    pr.product_key        AS product_key,      -- FK to dim_products
    cu.customer_key       AS customer_key,     -- FK to dim_customers
    sd.sls_order_dt       AS order_date,
    sd.sls_ship_dt        AS shipping_date,
    sd.sls_due_dt         AS due_date,
    sd.sls_sales          AS sales_amount,
    sd.sls_quantity       AS quantity,
    sd.sls_price          AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
       ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
       ON sd.sls_cust_id = cu.customer_id;


-- =============================================================================
-- Validation Queries (Optional)
-- =============================================================================
-- SELECT * FROM gold.dim_customers;
-- SELECT * FROM gold.dim_products;
-- SELECT * FROM gold.fact_sales;

