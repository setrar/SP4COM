import plotly.graph_objects as go
import numpy as np

# Generating example data
x = np.outer(np.linspace(-2, 2, 30), np.ones(30))
y = x.copy().T  # Transpose to get the grid
z = np.cos(x ** 2 + y ** 2)  # A simple function to generate heights

# Create a 3D surface plot
fig = go.Figure(data=[go.Surface(z=z, x=x, y=y)])

# Adding scatter plot on the surface
scatter_x = [1, -1, 0.5, -0.5]  # example x coordinates
scatter_y = [1, -1, -0.5, 0.5]  # example y coordinates
scatter_z = np.cos(np.array(scatter_x) ** 2 + np.array(scatter_y) ** 2)  # z coordinates from the surface function

# Add scatter points to the figure
fig.add_trace(go.Scatter3d(
    x=scatter_x, 
    y=scatter_y, 
    z=scatter_z,
    mode='markers',
    marker=dict(
        size=5,
        color='red',  # set color to red for these points
        opacity=0.8
    )
))

# Update plot layout
fig.update_layout(title='3D Surface with Scatter Points', autosize=False,
                  width=800, height=800,
                  margin=dict(l=65, r=50, b=65, t=90))

# Show plot
fig.show()

