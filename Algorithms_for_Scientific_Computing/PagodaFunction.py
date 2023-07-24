
class PagodaFunction(object):
    '''
    Grid point suitable for a multi-dimensional sparse grid.
    '''

    @staticmethod
    def hat(l, i, x):
        '''Efficiantly evaluates a one-dimensional hat function'''
        return max(0, 1-abs((1<<l)*x-i))

    def __init__(self, dim, levelVector, indexVector, funcValue = None):
        '''
        Constructor
        '''
        import sympy

        self.__dim = dim
        self.__levelVector = tuple(levelVector)
        self.__indexVector = tuple(indexVector)
        self.__surplus = funcValue
        self.__phi = 1
        self.__symx = sympy.symbols(["x" + str(d) for d in range(self.__dim)])

        for d, l, i, symx in zip(range(self.__dim), self.__levelVector, self.__indexVector, self.__symx):
            h = 1.0 / (1<<l)
            x = i * h
            self.__phi = sympy.Piecewise( (0, symx < x-h), (2**l*symx-i+1,symx<x), (-2**l*symx+i+1, symx<x+h), (0, True) ) * self.__phi


    def __call__(self, x):
        '''
        Evaluate the ansatz function at point x.
        '''
        result  = self.__surplus if not self.__surplus is None else 1.0
        #return result * self.__phi.subs(zip(self.__symx, x))
        for d in range(self.__dim):
            result *= PagodaFunction.hat(self.__levelVector[d], self.__indexVector[d], x[d])
        return result


    def getPhi(self):
        '''
        The (unscaled) symbolic function itself.
        '''
        return self.__phi


    def getLevel(self):
        '''
        The grid point's level.
        '''
        return sum(self.__levelVector) + 1 - self.__dim


    def getLevelVector(self):
        '''
        The grid point's level vector.
        '''
        return self.__levelVector


    def getIndexVector(self):
        '''
        The grid point's index vector.
        '''
        return self.__indexVector


    def getKey(self):
        '''
        The grid point's vector pair.
        '''
        return (self.__levelVector, self.__indexVector)


    def getSurplus(self):
        '''
        The grid point's surplus.
        '''
        return self.__surplus


    def setSurplus(self, surplus):
        '''
        Sets the grid point's surplus.
        '''
        self.__surplus = surplus


    def computeCoordinate(self):
        '''
        Computes the grid point's x-coordinate.
        '''
        return list(map(lambda l, i: float(i) / (1 << l),\
                    self.__levelVector, self.__indexVector))
