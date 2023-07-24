
#from __future__ import division

class AnsatzFunction(object):
    '''
    Grid point suitable for a one-dimensional sparse grid.
    '''
    
    def __init__(self, level, index, funcValue = None, surplus = None):
        '''
        Constructor
        '''
        import sympy
        symx = sympy.symbols('x')

        self.__key = (level, index)
        self.__funcValue = funcValue
        self.__surplus = funcValue if surplus is None else surplus
        h = 1 / float(1<<level)
        x_i = index * h
        x_l = x_i - h
        x_r = x_i + h
        self.__phi = sympy.Piecewise( (0, symx < x_l), (2**level*symx-index+1,symx<x_i), (-2**level*symx+index+1, symx<x_r), (0, True) )

    def __call__(self, x):
        '''
        Evaluate the ansatz function at point x.
        '''
        import sympy
        symx = sympy.symbols('x')
        return (self.__surplus if not self.__surplus is None else 1.0) * self.__phi.subs(symx, x)

   
    def getPhi(self):
        '''
        The (unscaled) symbolic function itself.
        '''
        return self.__phi
 

    def getLevel(self):
        '''
        The grid point's level.
        '''
        return self.__key[0]

    
    def getIndex(self):
        '''
        The grid point's index.
        '''
        return self.__key[1]
    
    
    def getKey(self):
        '''
        The grid point's key pair.
        '''
        return self.__key
    
    
    def getSurplus(self):
        '''
        The grid point's surplus.
        '''
        return self.__surplus
    
    
    def getFunctionValue(self):
        '''
        The grid point's associated function value.
        '''
        return self.__funcValue
    
    
    def setSurplus(self, surplus):
        '''
        Sets the grid point's surplus.
        '''
        self.__surplus = surplus
    
    
    def setFunctionValue(self, funcValue):
        '''
        Sets the grid point's function value.
        
        Also sets the surplus to this value to prepare for hierarchization.
        '''
        self.__funcValue = funcValue
        self.__surplus = funcValue
    

    def computeCoordinate(self):
        '''
        Computes the grid point's x-coordinate.
        '''
        return float(self.__key[1]) / (1 << self.__key[0]) 


    def computeLeftNeighbor(self):
        '''
        Computes the key of the direct left neighbor (on lower levels only).
        '''
        (level, index) = self.__key[:]
        while index % 4 == 1 and level > 0:
            index += 1
            index /= 2
            level -= 1
        index /= 2
        level -= 1
        return None if level < 1 else (level, index)


    def computeRightNeighbor(self):
        '''
        Computes the key of the direct right neighbor  (on lower levels only).
        '''
        (level, index) = self.__key[:]
        while index % 4 == 3 and level > 0:
            index /= 2
            level -= 1
        index += 1
        index /= 2
        level -= 1
        return None if level < 1 else (level, index)

