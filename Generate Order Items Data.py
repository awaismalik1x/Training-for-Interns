# Generate Order Items data
def generate_order_items_data(num_order_items, orders_df, products_df):
    order_items = []
    order_totals = {}
    
    # Ensure each order has at least one item
    for order_id in orders_df['order_id']:
        order_totals[order_id] = 0
    
    for i in range(1, num_order_items + 1):
        order = orders_df.sample(1).iloc[0]
        product = products_df.sample(1).iloc[0]
        
        quantity = random.randint(1, 5)
        unit_price = product['price']
        total_price = round(quantity * unit_price, 2)
        
        order_items.append({
            'order_item_id': i,
            'order_id': order['order_id'],
            'product_id': product['product_id'],
            'quantity': quantity,
            'unit_price': unit_price,
            'total_price': total_price
        })
        
        # Update order total
        if order['order_id'] in order_totals:
            order_totals[order['order_id']] += total_price
    
    # Update orders_df with calculated totals
    orders_df['total_amount'] = orders_df['order_id'].map(order_totals).fillna(0)
    
    return pd.DataFrame(order_items)

order_items_df = generate_order_items_data(num_order_items, orders_df, products_df)
print("Order Items DataFrame:")
print(order_items_df.head())
print(f"Shape: {order_items_df.shape}")

# Check updated orders with totals
print("\nOrders with calculated totals:")
print(orders_df[['order_id', 'total_amount']].head())
print(f"\nTotal order amount statistics:")
print(f"Mean: ${orders_df['total_amount'].mean():.2f}")
print(f"Median: ${orders_df['total_amount'].median():.2f}")
print(f"Max: ${orders_df['total_amount'].max():.2f}")