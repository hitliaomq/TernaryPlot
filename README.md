#### [![DOI](https://zenodo.org/badge/160682550.svg)](https://zenodo.org/badge/latestdoi/160682550)

## TernaryPlot *V1.2*

***

## Function

 Plot Ternary figure for ternary system

---

## Please Cite

Mingqing Liao. (2018, December 6). hitliaomq/TernaryPlot 1.1.1 (Version 1.1.1). Zenodo. http://doi.org/10.5281/zenodo.1998782

***

## Syntax

TernaryPlot(X, Y, Z)
TernaryPlot(X, Y, Z, PlotType)
TernaryPlot(__, Name, Value)

## Description

TernaryPlot(X, Y, Z) creates a 3-D ternary surf with A+B+C=1 
TernaryPlot(X, Y, Z, PlotType) creates ternary plot with type defined by PlotType
TernaryPlot(__, Name, Value) specifies the ternary axies properties using one or more Name, Value pair arguments

## Input Arguments
X, Y, Z: The data need to be drawn
​            They should be same in size, 1D or 2D
​             X0, Y0 [0, 1], Z0 no limit
PlotType: surf or s - for surface
​           contour or c - for countour
​           contourl or c+l - for contour + label
​           contourf or c+f - for contour with color
​           contourfl or c+f+l - for contour with color with label
 Others Name, Value pair arguments
   Grid: on or off(default)
   Tick: on(default) | off
   Label: {'A', 'B', 'C'}(default)
   LabelPos: 'center'(default) | corner
   Caxis: [cmin, cmax]

## Author Information
Author: Liao Mingqing
E-mail: liaomq1900127@163.com
GitHub: https://github.com/hitliaomq/TernaryPlot
Cite: Mingqing Liao. (2018, December 6). hitliaomq/TernaryPlot. Zenodo.
​      DOI:http://doi.org/10.5281/zenodo.1998782 
 Acknowledge: When coding this package, the following code was taken as a reference. https://github.com/alchemyst/ternplot

***

## TEST

For test, just load the file *TEST.mat* , then type *TernaryPlot(X, Y, Z)*

<img src="https://github.com/hitliaomq/TernaryPlot/blob/master/TEST/TEST.png" width="280" height="210"></img>

load the test data *TEST.mat* , then type TernaryPlot(X, Y, Z, ''Box', 'on', 'Grid', 'on', 'Tick', 'off', 'LabelPos', 'corner')

then rotate the figure:

<img src="https://github.com/hitliaomq/TernaryPlot/blob/master/TEST/TernaryPlot3D.png" width="280" height="210"></img>

---

## Change Log

*V2.0*

Data: 2018-12-27

New Feather: 1. add some new parameters: e.g. Box, LabelPos to control the Box and Label Position

2. remove the N parameters, using the default 100
3. Change the input type, using Name, Value pair arguments.

---

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




