import numpy as np
import matplotlib
import pylab
from mpl_toolkits.mplot3d import Axes3D
#from CombiGrid import evalCombiGridOnFullGrid, generateIndex


def printSparseGrid(sg):
    '''Simple print routine to see what's in the grid'''
    for af in sg.values():
        x = af.computeCoordinate()
        print(af.getKey(), ": u_h(", x, ")=", af.getSurplus())

def evaluateSparseGrid(sg, x):
    '''Evaluates a given sparse grid at given point x'''
    #return sum(map(lambda ansatz: ansatz(x), sg.values()))
    result = 0.0
    for ansatz in sg.values():
        result += ansatz(x)
    return result


def plotHierarchical1d(sg, basis="linear", flat=False):
    '''
    Plot the vector u as a 1-D vector of linear surpluses sorted along the x-axis.

    Depending on the basis employed a minimum number of samples is used to plot the
    function. Still, plotting is rather a lot of effort, as the piecewise symbolic
    functions are added up to the global solution.
    '''
    colors = [ 'b', 'g', 'r', 'c', 'm', 'y', 'k']

    import sympy
    x = sympy.symbols('x')

    if (basis == "linear"):
        samples = 2
    #elif (basis == "polynomial"):
    #    samples = 8
    else:
        raise ValueError

    levels = [0*x,]
    for af in sg.values():
        l = af.getLevel()
        # add new levels if necessary
        for i in range(l+1-len(levels)):
            levels.append(0*x)
        levels[l] += af.getSurplus() * af.getPhi()

    from numpy import linspace
    from matplotlib.pyplot import plot, legend
    for l in range(1, len(levels)):
        if not flat:
            levels[l] += levels[l-1]
        r = linspace(0, 1, (samples << l) + 1)
        plot(r, list(map(lambda t: levels[l].subs(x, t), r)), colors[l-1] + "-", label="l=%d" % l)

    legend()


def plotSG1d(sg, func):
    from numpy import linspace
    from matplotlib.pyplot import plot,legend

    x = np.linspace(0, 1, 50+1)
    y = list(map(lambda t: evaluateSparseGrid(sg, t), x))
    yy = list(map(lambda t: func(t), x))
    plot(x, y, 'b', label="sg")
    plot(x, yy, 'r', label="func")
    legend()


def plotHierarchical2d(sg, minLevel=4, showGrid=True, elevation=None, azimuth=None):
    '''
    Shows 3-D wireframe plot for 2-D sparse grids

    @param sg the 2-D sparse grid
    @param minLevel 2-D plotting grid has (2**minLevel+1)**2 values
    @param elevation elevation angle of view
    @param azimuth azimuth angle of view
    '''
    for key in sg:
        if len(key[0]) != 2:
            import sys
            print >> sys.stderr, "Plotting is only supported for 2-D grids!"
            return

    fig = pylab.figure()

    # create the underlying mesh
    x = np.linspace(0, 1, (1<<minLevel)+1)
    y = np.linspace(0, 1, (1<<minLevel)+1)
    X, Y = np.lib.meshgrid(x, y)

    Z = X.copy()
    #Z.flat = list(map(func, zip(X.flat, Y.flat)))
    Z.flat = list(map(lambda x: evaluateSparseGrid(sg, x), zip(X.flat, Y.flat)))

    # create a surface plot
    ax = Axes3D(fig)
    _ = ax.plot_wireframe(X, Y, Z, rstride=1, cstride=1, color='b', linestyle='-')
    if showGrid:
        sgX, sgY, sgZ = [], [], []
        for af in sg.values():
            x = af.computeCoordinate()
            sgX.append(x[0])
            sgY.append(x[1])
            sgZ.append(0)
        _ = ax.scatter(sgX, sgY, sgZ, marker='o', c='r')

    _ = ax.view_init(elevation, azimuth)

    matplotlib.pyplot.show()





def plotCombi2d(cg, minLevel=None, showGrid=True, elevation=None, azimuth=None):
    '''
    Shows 3-D wireframe plot for 2-D combi grids

    @param cg the 2-D combi grid
    @param minLevel 2-D plotting grid has (2**minLevel+1)**2 values
    @param elevation elevation angle of view
    @param azimuth azimuth angle of view
    '''
    level = 0
    for grid in cg:
        if len(grid) != 2:
            import sys
            print >> sys.stderr, "Plotting is only supported for 2-D grids!"
            return
        level = max(sum(grid) - 1, level)

    if minLevel is None or minLevel < level:
        minLevel = level

    fig = pylab.figure()

    # create the underlying mesh
    x = np.linspace(0, 1, (1 << minLevel) + 1)
    y = np.linspace(0, 1, (1 << minLevel) + 1)
    X, Y = np.lib.meshgrid(x, y)

    Z = evaluateCombiGridOnFullGrid(cg, minLevel)

    # create a surface plot
    ax = Axes3D(fig)
    _ = ax.plot_wireframe(X, Y, Z, rstride=1, cstride=1, color='b', linestyle='-')
    if showGrid:
        cgX, cgY, cgZ = [], [], []
        for lvec in cg:
            if sum(lvec) - 1 == level:
                h0 = 1.0 / (1 << lvec[0])
                h1 = 1.0 / (1 << lvec[1])
                xlvec = np.linspace(h0, 1 - h0, (1 << lvec[0]) - 1)
                ylvec = np.linspace(h1, 1 - h1, (1 << lvec[1]) - 1)
                Xlvec, Ylvec = np.lib.meshgrid(xlvec, ylvec)
                for x, y in zip(Xlvec.flat, Ylvec.flat):
                    cgX.append(x)
                    cgY.append(y)
                    cgZ.append(0)
        _ = ax.scatter(cgX, cgY, cgZ, marker='o', c='r')

    _ = ax.view_init(elevation, azimuth)

    matplotlib.pyplot.show()
