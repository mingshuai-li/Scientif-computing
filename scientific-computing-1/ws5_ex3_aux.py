#!/usr/bin/env python
'''
Filename: ws6_ex3_aux.py
  Author: Denis Jarema
    Date: November 14, 2014
 Lecture: SciComp
Tutorial: 5
Exercise: 3 auxiliary
-------------------------
'''

from pylab import *
import numpy as np

def plotDirectionField(X, Y, U, V, pname):
    """ simple plotting of direction fields."""
    M = sqrt(pow(U, 2) + pow(V, 2))
    U = np.divide(U,M)
    V = np.divide(V,M)
    Q = quiver( X, Y, U, V, M, units='xy', pivot='mid',
                width=0.010, scale=1/0.08, cmap=cm.gist_ncar)
    title(pname)

x_min = -0.5
x_max = 4.
y_min = -0.5
y_max = 6.

f = figure(figsize=(10, 10),dpi=120)

X,Y = meshgrid( arange(x_min,x_max,.11),arange( y_min,y_max,.11) )
1
# Ex. 3 c
U = (36*X - 12*X*X - 2*X*Y)*(y_max-y_min)/(x_max-x_min)
V = 30*Y - 6*Y*Y  - 6*X*Y

plotDirectionField(X, Y, U, V,
                   "Direction Field for x'=36x-12x^2-2xy, y'=30y-6y^2-6xy System of ODEs")

xlim([x_min,x_max])
ylim([y_min,y_max])
xlabel('x')
ylabel('y')

show()
