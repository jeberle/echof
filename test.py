#! /usr/bin/env python2.7

from __future__ import print_function
import sys

def main(argv):
    if len(argv) == 2:
        n = int(argv[1])
    else:
        n = 3
    f1 = open('f1', 'w')
    f2 = open('f2', 'r')
    for r in range(n):
        print('hello', file=f1)
        f1.flush()
        print(f2.readline().rstrip())
    f1.close()
    f2.close()

if __name__ == '__main__':
    main(sys.argv)

