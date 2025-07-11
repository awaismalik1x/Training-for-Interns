# Generate Reviews data
def generate_reviews_data(num_reviews, customers_df, products_df, order_items_df):
    review_texts = {
        5: ["Excellent product!", "Love it!", "Perfect quality", "Highly recommend", "Amazing value"],
        4: ["Very good", "Satisfied with purchase", "Good quality", "Would buy again", "Nice product"],
        3: ["It's okay", "Average quality", "Does the job", "Could be better", "Decent product"],
        2: ["Not great", "Poor quality", "Disappointing", "Below expectations", "Issues with product"],
        1: ["Terrible", "Waste of money", "Very poor quality", "Do not buy", "Completely unsatisfied"]
    }
    
    reviews = []
    # Get orders that have been delivered (customers can only review delivered items)
    delivered_orders = orders_df[orders_df['status'] == 'Delivered']
    
    for i in range(1, num_reviews + 1):
        # Select a random delivered order
        if len(delivered_orders) > 0:
            order = delivered_orders.sample(1).iloc[0]
            
            # Get items from this order
            order_items = order_items_df[order_items_df['order_id'] == order['order_id']]
            if len(order_items) > 0:
                order_item = order_items.sample(1).iloc[0]
                
                rating = random.choices([1, 2, 3, 4, 5], weights=[0.05, 0.1, 0.2, 0.35, 0.3])[0]
                review_text = random.choice(review_texts[rating])
                
                # Review date should be after delivery
                delivery_date = datetime.strptime(order['delivery_date'], '%Y-%m-%d')
                review_date = delivery_date + timedelta(days=random.randint(1, 30))
                
                reviews.append({
                    'review_id': i,
                    'customer_id': order['customer_id'],
                    'product_id': order_item['product_id'],
                    'order_id': order['order_id'],
                    'rating': rating,
                    'review_text': review_text,
                    'review_date': review_date.strftime('%Y-%m-%d'),
                    'helpful_votes': random.randint(0, 50)
                })
    
    return pd.DataFrame(reviews)

reviews_df = generate_reviews_data(num_reviews, customers_df, products_df, order_items_df)
print("Reviews DataFrame:")
print(reviews_df.head())
print(f"Shape: {reviews_df.shape}")
print("\nRating distribution:")
print(reviews_df['rating'].value_counts().sort_index())