# Olist Medallion Data Warehouse Pipeline

Medallion-architecture data pipeline for the [Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), orchestrated as a **Databricks Workflow** and modeled with **dbt**.

## Architecture

```
Raw CSVs → [Bronze: Databricks notebook] → [Silver: Databricks notebook] → [Gold: dbt build]
```

| Layer  | Tool                 | What it does |
|--------|----------------------|--------------|
| Bronze | Databricks (PySpark) | Load raw CSVs from a Volume into Delta tables, no transformation |
| Silver | Databricks (PySpark) | Clean, dedupe, cast types, fix timestamps, derive `delivery_days` / `is_delayed` |
| Gold   | dbt                  | Build `views` (dims, facts) on top of Silver |

Orchestrated as one **Databricks Workflow**: `Bronze ingest → Silver transform → dbt build`, each task gated on the previous one succeeding.

## Data Model

- **Dimensions:** `dim_customers`, `dim_products`, `dim_sellers`
- **Facts:** `fct_orders`, `fct_order_items`, `fct_order_payments`
- **Marts:** `mart_monthly_revenue`, `mart_delivery_performane`, `mart_category_performance`, `mart_cutomer`

## Project Structure

```
notebooks/{bronze,silver}/   # Databricks notebooks (dev + _prod versions run by the Workflow)
models/{staging,marts}/      # dbt models
tests/                       # dbt data tests
```

## Getting Started

```bash
# 1. Run the Databricks Workflow (Bronze → Silver → dbt build)
# 2. Or run dbt manually against the Silver schema:
dbt deps
dbt build
```

## Tech Stack

Databricks (Unity Catalog, Delta Lake, PySpark, Workflows) · dbt (dbt-databricks, dbt_utils)

## Data Source

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle.
