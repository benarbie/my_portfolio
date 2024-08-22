# Here i just export the dataset without the Adidas title (The excel file has a visual Adidas title)

import pandas as pd

# Read the data, start reading from the 5th row
df = pd.read_excel('Adidas US Sales Datasets.xlsx', skiprows=4)

# Skip the first empty column reading from ['Retailer']
df = df.loc[:, 'Retailer':]

# Output the data
df.to_excel('Adidas US Sales Datasets Updated.xlsx', index=False)

# Convert to csv for visibility in Github
df.to_csv('adidas_us_sales.csv', index=False)