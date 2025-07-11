# Generate Customers data
def generate_customer_data(num_customers):
    first_names = ['John', 'Jane', 'Michael', 'Sarah', 'David', 'Emily', 'Chris', 'Jessica', 'Daniel', 'Ashley',
                   'Matthew', 'Amanda', 'James', 'Jennifer', 'Robert', 'Lisa', 'William', 'Michelle', 'Charles', 'Kimberly']
    last_names = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez',
                  'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin']
    
    cities = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia', 'San Antonio', 'San Diego',
              'Dallas', 'San Jose', 'Austin', 'Jacksonville', 'Fort Worth', 'Columbus', 'Charlotte']
    
    states = ['NY', 'CA', 'IL', 'TX', 'AZ', 'PA', 'TX', 'CA', 'TX', 'CA', 'TX', 'FL', 'TX', 'OH', 'NC']
    
    customers = []
    for i in range(1, num_customers + 1):
        first_name = random.choice(first_names)
        last_name = random.choice(last_names)
        email = f"{first_name.lower()}.{last_name.lower()}{random.randint(1, 999)}@email.com"
        phone = f"+1-{random.randint(100, 999)}-{random.randint(100, 999)}-{random.randint(1000, 9999)}"
        
        city_idx = random.randint(0, len(cities) - 1)
        address = f"{random.randint(100, 9999)} {random.choice(['Main St', 'Oak Ave', 'Park Rd', 'First St', 'Second Ave'])}"
        
        registration_date = datetime(2020, 1, 1) + timedelta(days=random.randint(0, 1460))
        
        customers.append({
            'customer_id': i,
            'first_name': first_name,
            'last_name': last_name,
            'email': email,
            'phone': phone,
            'address': address,
            'city': cities[city_idx],
            'state': states[city_idx],
            'zip_code': f"{random.randint(10000, 99999)}",
            'registration_date': registration_date.strftime('%Y-%m-%d'),
            'birth_date': (datetime(1970, 1, 1) + timedelta(days=random.randint(0, 19000))).strftime('%Y-%m-%d')
        })
    
    return pd.DataFrame(customers)

customers_df = generate_customer_data(num_customers)
print("Customers DataFrame:")
print(customers_df.head())
print(f"Shape: {customers_df.shape}")