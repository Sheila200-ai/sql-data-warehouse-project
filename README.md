# SQL Data Warehouse Project

A small, self-built SQL pipeline created to practice the core skills used in data warehousing — extracting raw data, cleaning it, joining multiple sources, and loading it into a reporting-ready table. Built using MySQL Workbench.

## The Problem This Solves

Real businesses often have data scattered across separate systems — for example, a customer list in one place and an order list in another. This project simulates that: two separate, deliberately messy source tables get cleaned and combined into a single, reliable table that's ready for reporting and analysis.

## Project Structure

| File | What it does |
|---|---|
| `01_create_staging_tables.sql` | Creates two raw "source" tables — `RawCustomers` and `RawOrders` — and loads them with sample data that includes realistic data quality issues (inconsistent capitalization, a missing value) |
| `02_transform_load.sql` | Creates the final `FactCustomerSales` warehouse table, then cleans and joins the two staging tables into it — standardizing text casing, converting data types, and flagging rows with missing values |
| `03_reporting_query.sql` | A sample reporting query showing the warehouse table in use — total orders and spend per customer |

## Key Concepts Demonstrated

- **Extract, Transform, Load (ETL):** moving data from raw source tables into a clean, structured warehouse table
- **Data cleaning:** fixing inconsistent capitalization, converting text fields to proper date and decimal types
- **Joining multiple sources:** combining customer and order data on a shared `CustomerID` key
- **Data quality tracking:** an `AmountWasMissing` flag preserves the fact that a value was missing, rather than silently hiding it
- **Metadata documentation:** clear table structure, consistent naming conventions (PascalCase), and an audit column (`LoadedAt`) to track when data was loaded

## A Note on Tooling

This was built in MySQL since it was readily available, but the logic maps directly to SQL Server/T-SQL (the environment used in many enterprise data warehouses) — for example, `IFNULL()` here is equivalent to `ISNULL()` in SQL Server, and `NOW()` is equivalent to `GETDATE()`.

## What I'd Improve With More Time

- The capitalization fix only standardizes the first word of multi-word text (e.g. "western cape" becomes "Western cape", not "Western Cape") — a production version would use a more robust function or a reference/lookup table
- Make the load process repeatable (e.g. a truncate-and-reload or incremental load pattern) so it could safely run on a schedule without creating duplicates
