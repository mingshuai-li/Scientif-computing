#!/usr/bin/env python
'''
  Author: Denis Jarema
    Date: October 30, 2014
 Lecture: SciComp
Tutorial: 5
Exercise: 1
-------------------------
'''
import pylab as pl  # PLOTTING, very much like MATLAB
import numpy as np  # VECTORS, MATRICES...

def plotDirectionField(X, Y, U, V, pname):  # A FUNCTION CREATED WITH def funname(args):
    """ simple plotting of direction field."""
    M = np.sqrt(U**2 + V**2)
    U = U/M
    V = V/M
    Q = pl.quiver( X, Y, U, V, units='xy', pivot='mid', width=0.06, scale=1/.5)  # plotting command for vector field
    pl.title(pname)

def vectorField(y, p):  # ANOTHER FUNCTION
    """
    Defines the ODE y'(t) = lam*y(t)^2+mu*y(t)-nu

    Arguments:
    y : vector of variables
    p : vecor of parameters [lam, mu, nu]
    """

    lam, mu, nu = p  # access list elements

    # Create f = lam*Y^2 + mu*Y - nu
    return lam*Y*Y + mu*Y - nu  # ELEMENTWISE MULTIPLICATION!

# Saddle point
X,Y = np.meshgrid( np.arange(0,20.1,1.),np.arange(-1.,1.1,.1) )  # are two np.array.
lam = 1.
mu = 0.
nu = 0.

U = np.copy(X)
U.fill(1) # matrix full of ones
V = vectorField(Y,[lam,mu,nu])  # [...] is a list of things. evaluation of ODE
pl.figure()
plotDirectionField(X, Y, U, V, "Saddle Point: lam = 1, mu = 0, nu = 0")

# just some other plots coming here, same structure like the first one
#---------------------------------------------------------------------

# Two critical points
X,Y = np.meshgrid( np.arange(0,20.1,1.), np.arange(-2.,1.1,.2) )
lam = 5.
mu = 4.
nu = 1.

U = np.copy(X)
U.fill(1)
V = vectorField(Y,[lam,mu,nu])
pl.figure()
plotDirectionField(X, Y, U, V, "Two Critical Points: lam = 5, mu = 4, nu = 1")

# unstable
X,Y = np.meshgrid( np.arange(0,20.1,1.), np.arange(-1.,2.1,.2) )
lam = 0.
mu = 1.
nu = 1.

U = np.copy(X)
U.fill(1)
V = vectorField(Y,[lam,mu,nu])
pl.figure()
plotDirectionField(X, Y, U, V, "unstable: Lambda = 0, mu = 1, nu = 1")

# Lambda = 0, mu = -1
X,Y = np.meshgrid( np.arange(0,20.1,1.), np.arange(-2.,1.1,.2) )
lam = 0.
mu = -1.
nu = 1.

U = np.copy(X)
U.fill(1)
V = vectorField(Y,[lam,mu,nu])
pl.figure()
plotDirectionField(X, Y, U, V, "stable: Lambda = 0, mu = -1, nu = 1")

# Lambda = 0, mu = 0
X,Y = np.meshgrid( np.arange(0,20.1,1.), np.arange(-2.,1.1,.2) )
lam = 0.
mu = 0.
nu = 1.

U = np.copy(X)
U.fill(1)
V = vectorField(Y,[lam,mu,nu])
pl.figure()
plotDirectionField(X, Y, U, V, "no critical pt: Lambda = 0, mu = 0, nu = 1")

pl.show()
