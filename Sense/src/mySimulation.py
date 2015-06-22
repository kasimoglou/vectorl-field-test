from TOSSIM import *
import sys

t = Tossim([]);
t.addChannel("Output", sys.stdout);

t.getNode(1).bootAtTime(100001);

for i in range(0, 1000):
    t.runNextEvent();
