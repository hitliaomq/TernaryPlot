#### [![DOI](https://zenodo.org/badge/160682550.svg)](https://zenodo.org/badge/latestdoi/160682550)

## TernaryPlot *V1.2*

***

**Function**: Plot Ternary figure for ternary system

---

## Please Cite

Mingqing Liao. (2018, December 6). hitliaomq/TernaryPlot 1.1.1 (Version 1.1.1). Zenodo. http://doi.org/10.5281/zenodo.1998783

***

**Usage:**

TernaryPlot(X0, Y0, Z0, PlotType, N, Grid, Label, Caxis)

X0, Y0, Z0: The data need to be drawn

​           They should be same in size, 1D or 2D

​           X0, Y0 [0, 1], Z0 no limit

N: The number of grid, positive integer. 100 (default)

PlotType: 'surf' or 's' - for surface

​        'contour' or 'c' - for countour

​         'contourl' or 'c+l' - for contour + label

​         'contourf' or 'c+f' - for contour with color

​         'contourfl' or 'c+f+l' - for contour with color with label

Grid: on or off(default)

Label: {'A', 'B', 'C'}(default)

Caxis: [cmin, cmax] 

Only X0, Y0 and Z0 are necessary. For example, you can run as follows

TernaryPlot(X0, Y0, Z0) or

TernaryPlot(X0, Y0, Z0, PlotType) 

***

**TEST:**

For test, just load the file *TEST.mat* , then type *TernaryPlot(X, Y, Z)*

<img src="https://github.com/hitliaomq/TernaryPlot/blob/master/TEST/TEST.png" width="280" height="210"></img>

---

**Change Log**

*V 1.2*

Data:2018-12-17

New Feather: Improve the 3D view for 's'  plot type, don't need normalized by yourself

---------------------------------------------------------------------------------------------------------------------

*V 1.1*

Data:2018-12-06

New Feather: Fix a little bug

----------------------------------------------------------------------------------

*V 1.0*

Data: 2018-11-15

Function: Plot Ternary figure for ternary system

Feathers:

1. Plot type: color mapping, contour, contour with label, contour with color, contour with label and color

2. For color mapping, it provide 3D view(need normalization)

3. Some basic default value for input




