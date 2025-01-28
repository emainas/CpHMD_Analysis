#!/usr/bin/env python3
count = -1
stacked = 0
with open('com-angle1.dat') as data:
     next(data)
     for line in data:
          count += 1
          frame,distance,angle = line.split()
          dis=float(distance)
          ang=float(angle)
          if (ang >= 0 and ang <= 45) and (dis <= 5):
               stacked += 1
               print(dis,ang)
print("Total frames:",count)
print("Total stacked frames:",stacked)
TOTALSTACKED=(stacked*100/count)
print("Total stacked %:",TOTALSTACKED)
