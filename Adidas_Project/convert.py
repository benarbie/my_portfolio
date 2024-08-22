# Here i just export the dataset without the Adidas title

import pandas as pd


# Start reading from the 5th row, and skip the first empty column
df = pd.read_excel('Adidas US Sales Datasets.xlsx', skiprows=4)
df = df.loc[:, 'Retailer':]

df.to_excel('Adidas US Sales Datasets Updated.xlsx', index=False)

