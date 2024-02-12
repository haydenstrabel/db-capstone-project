import mysql.connector as connector
import pandas as pd

connection = connector.connect(host = "localhost",
                            user = "root",
                            password = "root",
                            database = "LittleLemonDB")

cursor = connection.cursor()

df = pd.read_excel(r"C:\Users\hayde\desktop\Meta Data Engineering\db-capstone-project\LittleLemonDB.xlsx")


# Populate the Orders table
# insert_orders = "INSERT INTO Orders (Quantity, Cost, Sales, Discount) VALUES (%s, %s, %s, %s)"
# order_values = [df["Quantity"], df["Cost"], df["Sales"], df["Discount"]]

# cursor.execute(insert_orders, order_values)
# connection.commit()

