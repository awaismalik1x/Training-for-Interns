# Generate Products data
def generate_product_data(num_products, categories_df):
    product_names_by_category = {
        'Electronics': ['Smartphone', 'Laptop', 'Headphones', 'Tablet', 'Smart Watch', 'Speaker', 'Camera', 'Monitor'],
        'Clothing': ['T-Shirt', 'Jeans', 'Dress', 'Sweater', 'Jacket', 'Sneakers', 'Boots', 'Hat'],
        'Home & Garden': ['Coffee Maker', 'Vacuum Cleaner', 'Garden Hose', 'Plant Pot', 'Bedding Set', 'Lamp'],
        'Sports & Outdoors': ['Running Shoes', 'Yoga Mat', 'Bicycle', 'Backpack', 'Water Bottle', 'Tent'],
        'Books': ['Fiction Novel', 'Cookbook', 'Science Textbook', 'Biography', 'Self-Help Book'],
        'Health & Beauty': ['Face Cream', 'Shampoo', 'Vitamins', 'Perfume', 'Makeup Kit'],
        'Toys & Games': ['Board Game', 'Action Figure', 'Puzzle', 'Toy Car', 'Doll'],
        'Automotive': ['Car Mat', 'Air Freshener', 'Phone Mount', 'Tire Gauge'],
        'Food & Beverages': ['Coffee Beans', 'Tea Set', 'Chocolate', 'Protein Bar'],
        'Arts & Crafts': ['Paint Set', 'Sketchbook', 'Craft Paper', 'Glue Set']
    }
    
    brands = ['BrandA', 'BrandB', 'BrandC', 'BrandD', 'BrandE', 'Premium', 'Basic', 'Elite', 'Standard', 'Deluxe']
    
    products = []
    for i in range(1, num_products + 1):
        category = categories_df.sample(1).iloc[0]
        category_id = category['category_id']
        category_name = category['category_name']
        
        base_name = random.choice(product_names_by_category[category_name])
        brand = random.choice(brands)
        product_name = f"{brand} {base_name}"
        
        # Generate realistic prices based on category
        price_ranges = {
            'Electronics': (50, 2000),
            'Clothing': (15, 200),
            'Home & Garden': (20, 500),
            'Sports & Outdoors': (25, 300),
            'Books': (10, 50),
            'Health & Beauty': (8, 100),
            'Toys & Games': (12, 80),
            'Automotive': (15, 150),
            'Food & Beverages': (5, 50),
            'Arts & Crafts': (8, 75)
        }
        
        price_min, price_max = price_ranges[category_name]
        price = round(random.uniform(price_min, price_max), 2)
        cost = round(price * random.uniform(0.4, 0.7), 2)  # Cost is 40-70% of price
        
        products.append({
            'product_id': i,
            'product_name': product_name,
            'category_id': category_id,
            'brand': brand,
            'price': price,
            'cost': cost,
            'stock_quantity': random.randint(0, 200),
            'weight_kg': round(random.uniform(0.1, 10.0), 2),
            'dimensions': f"{random.randint(5, 50)}x{random.randint(5, 50)}x{random.randint(2, 25)}",
            'description': f"High-quality {base_name.lower()} from {brand}",
            'created_date': (datetime(2019, 1, 1) + timedelta(days=random.randint(0, 1095))).strftime('%Y-%m-%d')
        })
    
    return pd.DataFrame(products)

products_df = generate_product_data(num_products, categories_df)
print("Products DataFrame:")
print(products_df.head())
print(f"Shape: {products_df.shape}")
print("\nPrice statistics by category:")
merged_df = products_df.merge(categories_df, on='category_id')
print(merged_df.groupby('category_name')['price'].agg(['mean', 'min', 'max']).round(2))