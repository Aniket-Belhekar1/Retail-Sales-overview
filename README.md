# Retail Sales Analytics – SQL + Power BI Integrated Architecture

## Project Upgrade (v2 – SQL Integrated Architecture)

This project was upgraded from a Power BI-only dashboard to a layered data architecture:

Raw Data (SQL Staging) → Clean Star Schema → Certified Revenue View → Power BI Reporting

Enhancements include:

- SQL staging layer implementation
- Referential integrity (PK/FK constraints)
- Certified revenue & profit logic in SQL
- Data Quality Scorecard in Power BI
- End-to-end validation between SQL and DAX

## Architecture Overview

### Data Layers

**1. Staging Layer (SQL)**
- Raw data import
- Data validation checks
- No transformations applied

**2. Clean Layer (Star Schema)**
- Dimension tables (Customers, Products, Stores)
- Fact table (Transactions)
- Primary and foreign key enforcement

**3. Certified Metric Layer**
- Revenue and Gross Profit centralized in SQL view
- Prevents metric drift
- Used for validation and governance

**4. Power BI Layer**
- DAX measures for time intelligence and KPIs
- Star schema modeling
- Data Quality monitoring dashboard

## Skills Demonstrated
- SQL data modeling (Star schema, PK/FK constraints)
- Data governance & certified metric design
- DAX (Time intelligence, segmentation, retention logic)
- CTEs & Window functions (LAG, RANK)
- Data Quality monitoring framework
- End-to-end validation across data layers

## Data Quality & Governance

A dedicated Power BI scorecard monitors:

- Null record detection
- Invalid discount validation
- Referential integrity (orphan checks)
- Revenue variance validation
- Valid record percentage

## Key Outcomes

- Transitioned from BI-only dashboard to layered SQL + BI architecture
- Implemented controlled metric definitions to prevent revenue inconsistency
- Enforced referential integrity at the database level
- Validated SQL outputs against DAX measures for consistency
- Designed a governance-focused Data Quality monitoring framework

This ensures data reliability before business reporting.

## Tech Stack
- SQL Server (SSMS)
- Power BI Desktop
- DAX
- Power Query
- Star Schema Modeling
- Data Governance & Validation

## Repository Structure

### /SQL
- 01_Staging_Tables.sql
- 02_Clean_Model.sql
- 03_Certified_View.sql
- 04_Analytical_Queries.sql

### /PowerBI
- Retail_Sales_Dashboard.pbix

Link for snapshot: https://github.com/Aniket-Belhekar1/Retail-Sales-overview/blob/main/Snapshot%20of%20Retail%20Sales%20overwiew.png
Link for Power BI file: https://github.com/Aniket-Belhekar1/Retail-Sales-overview/blob/main/Retail%20Sales%20Dashboard.pbix
