import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta
import uuid
import os

# Set random seed for reproducibility
np.random.seed(42)
random.seed(42)

# Create directories for data
os.makedirs('ecommerce_data', exist_ok=True)

# Define data generation parameters
num_customers = 1000
num_products = 500
num_orders = 2500
num_order_items = 5000
num_reviews = 1800

# Generate Categories data
categories = [
    'Electronics', 'Clothing', 'Home & Garden', 'Sports & Outdoors', 
    'Books', 'Health & Beauty', 'Toys & Games', 'Automotive',
    'Food & Beverages', 'Arts & Crafts'
]

categories_df = pd.DataFrame({
    'category_id': range(1, len(categories) + 1),
    'category_name': categories,
    'description': [f'All {cat.lower()} products' for cat in categories]
})

print("Categories DataFrame:")
print(categories_df.head())