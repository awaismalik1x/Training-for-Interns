# Generate Suppliers data
def generate_suppliers_data():
    suppliers_data = [
        {'supplier_id': 1, 'supplier_name': 'TechSource Inc', 'contact_person': 'John Smith', 
         'email': 'john@techsource.com', 'phone': '+1-555-0101', 'address': '123 Tech Ave',
         'city': 'San Francisco', 'state': 'CA', 'country': 'USA', 'rating': 4.5},
        {'supplier_id': 2, 'supplier_name': 'Fashion Forward Ltd', 'contact_person': 'Sarah Johnson',
         'email': 'sarah@fashionforward.com', 'phone': '+1-555-0102', 'address': '456 Style St',
         'city': 'New York', 'state': 'NY', 'country': 'USA', 'rating': 4.2},
        {'supplier_id': 3, 'supplier_name': 'Home Essentials Co', 'contact_person': 'Mike Chen',
         'email': 'mike@homeessentials.com', 'phone': '+1-555-0103', 'address': '789 Garden Rd',
         'city': 'Chicago', 'state': 'IL', 'country': 'USA', 'rating': 4.7},
        {'supplier_id': 4, 'supplier_name': 'Sports Gear Direct', 'contact_person': 'Lisa Brown',
         'email': 'lisa@sportsgear.com', 'phone': '+1-555-0104', 'address': '321 Athletic Way',
         'city': 'Denver', 'state': 'CO', 'country': 'USA', 'rating': 4.3},
        {'supplier_id': 5, 'supplier_name': 'Global Books Publishing', 'contact_person': 'David Wilson',
         'email': 'david@globalbooks.com', 'phone': '+1-555-0105', 'address': '654 Literature Lane',
         'city': 'Boston', 'state': 'MA', 'country': 'USA', 'rating': 4.6}
    ]
    return pd.DataFrame(suppliers_data)

suppliers_df = generate_suppliers_data()

# Generate Product Suppliers mapping
def generate_product_suppliers_data(products_df, suppliers_df):
    product_suppliers = []
    for _, product in products_df.iterrows():
        # Each product can have 1-3 suppliers
        num_suppliers = random.randint(1, 3)
        selected_suppliers = suppliers_df.sample(num_suppliers)
        
        for _, supplier in selected_suppliers.iterrows():
            product_suppliers.append({
                'product_id': product['product_id'],
                'supplier_id': supplier['supplier_id'],
                'supply_price': round(product['cost'] * random.uniform(0.8, 1.2), 2),
                'lead_time_days': random.randint(5, 30),
                'min_order_quantity': random.randint(10, 100)
            })
    
    return pd.DataFrame(product_suppliers)

product_suppliers_df = generate_product_suppliers_data(products_df, suppliers_df)

# Generate Employees data
def generate_employees_data():
    departments = ['Sales', 'Marketing', 'Customer Service', 'Warehouse', 'IT', 'Finance', 'HR']
    positions = {
        'Sales': ['Sales Representative', 'Sales Manager', 'Account Executive'],
        'Marketing': ['Marketing Specialist', 'Marketing Manager', 'Content Creator'],
        'Customer Service': ['Customer Service Rep', 'Support Manager', 'Chat Agent'],
        'Warehouse': ['Warehouse Worker', 'Inventory Manager', 'Shipping Clerk'],
        'IT': ['Software Developer', 'IT Support', 'System Administrator'],
        'Finance': ['Accountant', 'Financial Analyst', 'Finance Manager'],
        'HR': ['HR Specialist', 'Recruiter', 'HR Manager']
    }
    
    first_names = ['Alice', 'Bob', 'Carol', 'Dan', 'Eva', 'Frank', 'Grace', 'Henry', 'Ivy', 'Jack']
    last_names = ['Adams', 'Brown', 'Clark', 'Davis', 'Evans', 'Ford', 'Green', 'Hall', 'Irwin', 'Jones']
    
    employees = []
    for i in range(1, 51):  # 50 employees
        dept = random.choice(departments)
        position = random.choice(positions[dept])
        first_name = random.choice(first_names)
        last_name = random.choice(last_names)
        
        employees.append({
            'employee_id': i,
            'first_name': first_name,
            'last_name': last_name,
            'email': f"{first_name.lower()}.{last_name.lower()}@company.com",
            'department': dept,
            'position': position,
            'hire_date': (datetime(2015, 1, 1) + timedelta(days=random.randint(0, 3000))).strftime('%Y-%m-%d'),
            'salary': random.randint(35000, 120000),
            'manager_id': random.randint(1, 10) if i > 10 else None  # First 10 are managers
        })
    
    return pd.DataFrame(employees)

employees_df = generate_employees_data()

print("Suppliers DataFrame:")
print(suppliers_df)
print(f"\nProduct Suppliers DataFrame shape: {product_suppliers_df.shape}")
print(product_suppliers_df.head())
print(f"\nEmployees DataFrame shape: {employees_df.shape}")
print(employees_df.head())