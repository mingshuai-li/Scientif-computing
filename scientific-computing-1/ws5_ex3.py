#!/usr/bin/env python
'''
Filename: ws6_ex3_aux
  Author: Benjamin Rüth
    Date: November 25, 2015
 Lecture: SciComp
Tutorial: 5
Exercise: 3 
-------------------------
'''

import numpy as np


def compute_jacobian(x):
    return np.array([[36 - 24 * x[0] - 2 * x[1], -2 * x[0]],
                     [-6 * x[1], 30 - 12 * x[1] - 6 * x[0]]])

x_crit  = 4 * [None]
x_crit[0] = np.array([0, 0])
x_crit[1] = np.array([0, 5])
x_crit[2] = np.array([3, 0])
x_crit[3] = np.array([2.6, 2.4])

j_crit = 4 * [None]

for i in range(4):
    j_crit[i] = compute_jacobian(x_crit[i])
    lam, v = np.linalg.eig(j_crit[i])
    print "for x_crit:\n" + str(x_crit[i])
    print "we get j_crit:\n" + str(j_crit[i])
    #print "with eigenvalues:\n" + str(lam)
    print "\n"
