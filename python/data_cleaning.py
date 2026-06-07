import pandas as pd
from pathlib import Path

# Get the project root directory (parent of the python folder)
project_root = Path(__file__).parent.parent

# Defining file paths relative to project root
input_file = project_root / "1,00,000 rows data of online_retail.xlsx"
output_file = project_root / "cleaned_online_retail.csv"

df = pd.read_excel(input_file)

print(df.head())
print(df.info())
print(df.describe(include="all"))
print(df.isnull().sum())

# Removing Null Customer IDs
df = df.dropna(subset="CustomerID")

# checking for duplicate rows
# print(df.duplicated().sum()) #924 duplicate rows

# Removing duplicate transactions
df.drop_duplicates(inplace=True)

# Checking duplicates
print(df.duplicated().sum())


# Removing Cancelled Orders
df = df[~df["InvoiceNo"].astype(str).str.startswith("C")]


# Removing Negative Quantities
df = df[df["Quantity"] > 0]


# Removing Zero or Negative Prices
df = df[df["UnitPrice"] > 0]


# Created Revenue Column
df["Revenue"] = df["Quantity"] * df["UnitPrice"]


# Converted datatype of Invoice date from str to datetime
df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"])


# Extracting Month
df["Month"] = df["InvoiceDate"].dt.month


# Extracting Year
df["Year"] = df["InvoiceDate"].dt.year

print(df.head())


# EDA

# Total Revenue
print(df["Revenue"].sum())

# Top Countries
print(df.groupby("Country")["Revenue"].sum().sort_values(ascending=False))


# Top customers
print(df.groupby("CustomerID")["Revenue"].sum().sort_values(ascending=False))


# Top Products
print(df.groupby("Description")["Quantity"].sum().sort_values(ascending=False))


# Monthly Revenue Trend
print(df.groupby("Month")["Revenue"].sum())


# Yearly Revenue Trend
print(df.groupby("Year")["Revenue"].sum())


print(df.head())

df.to_csv(output_file, index=False, encoding="utf-8")

print(f"Cleaned data saved to: {output_file}")
