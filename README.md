# The E-Commerce Dataset Documentation

## Project Overview

The project aims to build an end-to-end solution for managing and analyzing The E-Commerce dataset. The dataset comprises five main tables:

1. **Orders table**: Records all orders placed by customers.
2. **Order_items table**: Contains the list of items purchased in each order.
3. **Products table**: Stores details of products sold.
4. **Customers table**: Records details of customers who have made orders.
5. **Distrbution Centres**: The list of distribution centres of prodcuts.

## Project Goal

The goal of the project is to build an end-to-end solution to manage and analyze the dataset. This involves transforming the raw data into a format suitable for analysis, ensuring data integrity, implementing data security measures, and visualizing the data for insights.

## Solution Overview

### Extract

Data is loaded into Snowflake from internal stages, serving as the raw layer.

### Transform & Load

The transformation process is facilitated through dbt, with the following layers modeled:

- **Staging Layer**: Source files are modified to align with business needs. Validation of columns such as email, age, SKU, and brand is performed using regular expressions. Price columns are standardized as decimal(16,4) digits.
  
- **Marts Layer**: Fact and dimension tables are created:
  - Fact table: Contains valid order items with sales value and units sold per order, customer, and product.
  - Dimension tables: Include a customers table with order and demographic details, and a products table with sales and product information.

- **Analytics Layer**: Aggregated values for customers and products are maintained in separate tables, with sales data aggregated by country, brand, and category on a yearly and monthly basis.

### Data Integrity

Tables across raw, staging, and marts layers are reconciled for total counts. Key columns are checked for null and unique constraints, and data integrity is ensured through custom tests in dbt. Status and gender columns are checked for accepted values.Sales price and units columns are checked for non-negative values using custom tests.

### Data Security and Governance

Personally Identifiable Information (PII) such as email is masked based on user roles. Age and gender columns are tagged as PII for access control purposes.

### Visualization

A dashboard has been created using Looker Studio for visualizing data.

## How to Run the Transformation Job

Ensure raw tables are populated.
Run the transformation job deployed in dbt.

---

This README provides an overview of the project structure and key components. For more detailed information, refer to the project documentation.
