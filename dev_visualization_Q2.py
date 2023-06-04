import sqlite3
import matplotlib.pyplot as plt

# Connect to the SQLite database
conn = sqlite3.connect('collisions.db')
cursor = conn.cursor()

# Fetch the data from the table
cursor.execute("SELECT COLLISIONTYPE, FATALITIES FROM COLLISION_FATALITIES")
data = cursor.fetchall()

# Separate the collision types and fatalities into separate lists
collision_types = [row[0] for row in data]
fatalities = [row[1] for row in data]

# Create the bar chart
plt.bar(collision_types, fatalities)
plt.xlabel('Collision Type')
plt.ylabel('Fatalities')
plt.title('Fatalities by Collision Type')

# Rotate x-axis labels for better visibility
plt.xticks(rotation=45)

# Display the chart
plt.show()

# Save the chart as an image
plt.savefig('info_junction_cf_distribution_pc.png')

# Close the database connection
conn.close()
