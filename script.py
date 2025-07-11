import json
import pandas as pd
import numpy as np
orders = orders_df[['order_id','total_amount']]
# Use 50 bins histogram.
hist, bin_edges = np.histogram(orders['total_amount'], bins=50)
# prepare data for chart
chart_data = pd.DataFrame({'bin_start': bin_edges[:-1], 'bin_end': bin_edges[1:], 'count': hist})
chart_data.head()
data_json = chart_data.to_json(orient='records')
print(data_json[:500])