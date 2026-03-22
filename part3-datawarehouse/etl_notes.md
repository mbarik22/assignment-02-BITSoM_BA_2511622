## ETL Decisions

### Decision 1 — Standardizing Inconsistent Date Formats
**Problem:** The raw dataset had multiple date formats such as:
01-01-2025 ; 2025/01/01 ; 1 Jan 25

This inconsistency breaks:
1. Joins with dim_date
2. Time-based aggregations (monthly, quarterly trends)

**Resolution:**

All dates were:

1. Parsed using a flexible date parser
2. Converted into a standard ISO format: YYYY-MM-DD
3. Mapped to a surrogate date_id in dim_date

👉 Example transformation:
"01-01-2025" → "2025-01-01"

### Decision 2 — Normalizing Product Category

**Problem:** Product categories appeared in inconsistent casing:
1. electronics, ELECTRONICS, Electronics
2. apparel, Apparel

This caused::
1. Duplicate groupings in reports
2. Incorrect aggregation in BI queries

**Resolution:**

1. Applied a transformation to convert all category values to UPPERCASE
2. Trimmed whitespace and removed hidden characters

👉 Example transformation:

"electronics" → "ELECTRONICS"

" Apparel " → "APPAREL"

### Decision 3 — Handling NULL and Missing Values

**Problem:** Product categories appeared in inconsistent casing:
Several fields had missing values:
1. product_name or category = NULL
2. quantity_sold or unit_price missing

This leads to:
1. Broken joins (foreign keys)
2. Incorrect revenue calculations
3. BI dashboards showing blanks

**Resolution:**

Different strategies were applied based on column type:
1. Categorical fields → replaced with 'Unknown'
2. Numeric fields → replaced with 0
3. Ensured no NULLs in foreign keys (mandatory for fact table integrity)

👉 Example transformation:
1. NULL category → 'UNKNOWN'
2. NULL quantity → 0