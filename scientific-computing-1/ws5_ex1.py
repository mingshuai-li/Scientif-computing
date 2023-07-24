#!/usr/bin/env python
'''
Filename: ws6_ex1.py
  Author: Denis Jarema
    Date: November 25, 2013
 Lecture: SciComp
Tutorial: 5
Exercise: 1
-------------------------
'''

from pylab import *
import numpy as np

def plotDirectionField(X, Y, U, V, pname):
    """ simple plotting of direction fields."""
    M = sqrt(pow(U, 2) + pow(V, 2))
    U = np.divide(U,M)
    V = np.divide(V,M)
    Q = quiver( X, Y, U, V, M, units='xy', pivot='mid', width=0.010, scale=1/0.08)
    title(pname)

    
X,Y = meshgrid( arange(-1,1.08,.08),arange(-1,1.08,.08) )
1
# Ex. 1 b
U = Y
V = -X
figure()
plotDirectionField(X, Y, U, V, "Direction Field for y''=-y Equation")

# Ex. 1 c
mu = 0.25
U = Y
V = -mu*X
figure()
plotDirectionField(X, Y, U, V, "Direction Field for y''=-mu*y Equation, mu = " + str(mu))

# Ex. 1 d
mu = 0.25
U = Y
V = -mu*X+Y
figure()
plotDirectionField(X, Y, U, V, "Direction Field for y''=-mu*y+y' Equation, mu = " + str(mu))

mu = 0.12
U = Y
V = -mu*X+Y
figure()
plotDirectionField(X, Y, U, V, "Direction Field for y''=-mu*y+y' Equation, mu = " + str(mu))

mu = -1.0
U = Y
V = -mu*X+Y
figure()
plotDirectionField(X, Y, U, V, "Direction Field for y''=-mu*y+y' Equation, mu = " + str(mu))

mu = 2.0
U = Y
V = -mu*X+Y
figure()
plotDirectionField(X, Y, U, V, "Direction Field for y''=-mu*y+y' Equation, mu = " + str(mu))

show()
