import plotly.graph_objects as go
import pandas as pd
import json

# Load the data
data_json = [{"bin_start":0.0,"bin_end":380.7414,"count":1221},{"bin_start":380.7414,"bin_end":761.4828,"count":432},{"bin_start":761.4828,"bin_end":1142.2242,"count":229},{"bin_start":1142.2242,"bin_end":1522.9656,"count":132},{"bin_start":1522.9656,"bin_end":1903.707,"count":79},{"bin_start":1903.707,"bin_end":2284.4484,"count":63},{"bin_start":2284.4484,"bin_end":2665.1898,"count":58},{"bin_start":2665.1898,"bin_end":3045.9312,"count":34},{"bin_start":3045.9312,"bin_end":3426.6726,"count":19},{"bin_start":3426.6726,"bin_end":3807.414,"count":16},{"bin_start":3807.414,"bin_end":4188.1554,"count":11},{"bin_start":4188.1554,"bin_end":4568.8968,"count":8},{"bin_start":4568.8968,"bin_end":4949.6382,"count":4},{"bin_start":4949.6382,"bin_end":5330.3796,"count":11},{"bin_start":5330.3796,"bin_end":5711.121,"count":5},{"bin_start":5711.121,"bin_end":6091.8624,"count":9},{"bin_start":6091.8624,"bin_end":6472.6038,"count":5},{"bin_start":6472.6038,"bin_end":6853.3452,"count":4},{"bin_start":6853.3452,"bin_end":7234.0866,"count":3},{"bin_start":7234.0866,"bin_end":7614.828,"count":3},{"bin_start":7614.828,"bin_end":7995.5694,"count":2},{"bin_start":7995.5694,"bin_end":8376.3108,"count":2},{"bin_start":8376.3108,"bin_end":8757.0522,"count":2},{"bin_start":8757.0522,"bin_end":9137.7936,"count":2},{"bin_start":9137.7936,"bin_end":9518.535,"count":1},{"bin_start":9518.535,"bin_end":9899.2764,"count":1},{"bin_start":9899.2764,"bin_end":10280.0178,"count":1},{"bin_start":10280.0178,"bin_end":10660.7592,"count":0},{"bin_start":10660.7592,"bin_end":11041.5006,"count":1},{"bin_start":11041.5006,"bin_end":11422.242,"count":0},{"bin_start":11422.242,"bin_end":11802.9834,"count":0},{"bin_start":11802.9834,"bin_end":12183.7248,"count":1},{"bin_start":12183.7248,"bin_end":12564.4662,"count":0},{"bin_start":12564.4662,"bin_end":12945.2076,"count":0},{"bin_start":12945.2076,"bin_end":13325.949,"count":0},{"bin_start":13325.949,"bin_end":13706.6904,"count":0},{"bin_start":13706.6904,"bin_end":14087.431800000001,"count":0},{"bin_start":14087.431800000001,"bin_end":14468.1732,"count":0},{"bin_start":14468.1732,"bin_end":14848.914600000001,"count":0},{"bin_start":14848.914600000001,"bin_end":15229.656,"count":0},{"bin_start":15229.656,"bin_end":15610.3974,"count":0},{"bin_start":15610.3974,"bin_end":15991.1388,"count":0},{"bin_start":15991.1388,"bin_end":16371.8802,"count":0},{"bin_start":16371.8802,"bin_end":16752.6216,"count":0},{"bin_start":16752.6216,"bin_end":17133.363,"count":0},{"bin_start":17133.363,"bin_end":17514.104400000002,"count":0},{"bin_start":17514.104400000002,"bin_end":17894.845800000002,"count":0},{"bin_start":17894.845800000002,"bin_end":18275.587200000003,"count":0},{"bin_start":18275.587200000003,"bin_end":18656.328600000002,"count":0},{"bin_start":18656.328600000002,"bin_end":19037.07,"count":1}]

# Convert to DataFrame for easier manipulation
df = pd.DataFrame(data_json)

# Calculate bin centers for x-axis
df['bin_center'] = (df['bin_start'] + df['bin_end']) / 2

# Calculate bin width for consistent bar width
bin_width = df['bin_end'].iloc[0] - df['bin_start'].iloc[0]

# Create the histogram
fig = go.Figure(data=[
    go.Bar(
        x=df['bin_center'],
        y=df['count'],
        width=bin_width * 0.98,  # Slightly smaller to ensure bars touch properly
        cliponaxis=False,
        marker_color='#1FB8CD'
    )
])

# Update layout
fig.update_layout(
    title='E-Commerce Order Distribution',
    xaxis_title='Order Total ($)',
    yaxis_title='# of Orders',
    bargap=0  # No gaps between bars
)

# Format x-axis with better tick spacing and k formatting for thousands
fig.update_xaxes(
    tickmode='linear',
    tick0=0,
    dtick=2000,
    tickformat=',.0f',
    range=[0, 20000]  # Set explicit range to show full distribution
)

# Format y-axis with k formatting for thousands
fig.update_yaxes(
    tickformat=',.0f'
)

# Save the chart
fig.write_image("order_distribution_histogram.png")