import numpy as np
import matplotlib.pyplot as plt

severity_codes = ['Unknown', 'Property Damage Only Collision', 'Injury Collision', 'Serious Injury Collision', 'Fatality Collision']
dui_percentages = [0.0, 3.8, 5.65, 11.45, 21.91]
distracted_percentages = [0.0, 13.28, 16.55, 10.12, 3.73]

# Define the width of the bars and the gap between them
bar_width = 0.4
gap = 0.4

# Calculate the positions of the bars
x = np.arange(len(severity_codes))
x1 = x - gap / 2
x2 = x + gap / 2

# Plotting combined bar chart
plt.figure(figsize=(10, 6))
plt.bar(x1, dui_percentages, width=bar_width, label='DUI')
plt.bar(x2, distracted_percentages, width=bar_width, color='orange', label='Distracted')
plt.xlabel('Severity Code')
plt.ylabel('Percentage')
plt.title('Comparing Percentages of Collisions Involving DUI VS Collisions Involving Distracted Driving for Each Severity Type')
plt.legend()

# Adding value labels for DUI percentages
for i, percentage in enumerate(dui_percentages):
    plt.text(x1[i], percentage, f'{percentage}%', ha='center', va='bottom')

# Adding value labels for distracted driving percentages
for i, percentage in enumerate(distracted_percentages):
    plt.text(x2[i], percentage, f'{percentage}%', ha='center', va='bottom')

# Adjust the x-axis tick positions and labels
plt.xticks(x, severity_codes)

# Display the plot
plt.show()
