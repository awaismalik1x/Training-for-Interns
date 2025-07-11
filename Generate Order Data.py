# Generate Orders data
def generate_orders_data(num_orders, customers_df):
    order_statuses = ['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled']
    status_weights = [0.05, 0.1, 0.15, 0.65, 0.05]  # Most orders are delivered
    
    payment_methods = ['Credit Card', 'Debit Card', 'PayPal', 'Apple Pay', 'Google Pay']
    
    orders = []
    for i in range(1, num_orders + 1):
        customer = customers_df.sample(1).iloc[0]
        
        # Order date should be after customer registration
        reg_date = datetime.strptime(customer['registration_date'], '%Y-%m-%d')
        latest_date = datetime(2024, 6, 1)
        order_date = reg_date + timedelta(days=random.randint(1, (latest_date - reg_date).days))
        
        status = random.choices(order_statuses, weights=status_weights)[0]
        
        # Generate shipping and delivery dates based on status
        shipping_date = None
        delivery_date = None
        
        if status in ['Shipped', 'Delivered']:
            shipping_date = order_date + timedelta(days=random.randint(1, 3))
            if status == 'Delivered':
                delivery_date = shipping_date + timedelta(days=random.randint(1, 7))
        
        orders.append({
            'order_id': i,
            'customer_id': customer['customer_id'],
            'order_date': order_date.strftime('%Y-%m-%d'),
            'status': status,
            'payment_method': random.choice(payment_methods),
            'shipping_address': customer['address'],
            'shipping_city': customer['city'],
            'shipping_state': customer['state'],
            'shipping_zip': customer['zip_code'],
            'shipping_date': shipping_date.strftime('%Y-%m-%d') if shipping_date else None,
            'delivery_date': delivery_date.strftime('%Y-%m-%d') if delivery_date else None,
            'total_amount': 0  # Will be calculated after order items
        })
    
    return pd.DataFrame(orders)

orders_df = generate_orders_data(num_orders, customers_df)
print("Orders DataFrame:")
print(orders_df.head())
print(f"Shape: {orders_df.shape}")
print("\nOrder status distribution:")
print(orders_df['status'].value_counts())