import sqlite3
import matplotlib.pyplot as plt

# PIE CHART FOR JUNCTION COLLISIONS
# Connect to sqlite3 database collisions.db and get the data from JUNCTION_COLLISIONS
connection = sqlite3.connect('collisions.db')
cursor = connection.cursor()
query = "SELECT JUNCTIONTYPE, FATALITIES FROM JUNCTIONTYPE_FATALITIES"
cursor.execute(query)
rows = cursor.fetchall()

# Save the data in an empty dictionary
data = {}
for row in rows:
    junction_type = row[0]
    distinct_count = row[1]
    data[junction_type] = distinct_count

# Close the database connection
cursor.close()
connection.close()

# Remove data points with a percentage less than 0.02
total_count = sum(data.values())
filtered_data = {k: v for k, v in data.items() if (v / total_count) >= 0.02}

# Create labels, size and aspect ratio for the pie chart (Create the details of the pie chart)
labels = filtered_data.keys()
sizes = filtered_data.values()
fig, ax = plt.subplots(figsize=(8, 8))
ax.pie(sizes, labels=labels, autopct='%1.1f%%')
ax.axis('equal')
plt.title('Junction Collisions Distribution')

# Save the image as a PNG file
plt.savefig('info_junction_jf_distribution_pc.png', dpi=1000)

# Display the chart
plt.show()
