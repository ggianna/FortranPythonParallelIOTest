#!/bin/bash
echo Compiling...
gfortran iotest.f

echo Removing any ghost processes left
killall -9 a.out

echo Clearing lock and logs...
rm lock.file
rm out?.log err?.log

for loop in 1 2 3; do
	echo "import time; from datetime import datetime; time.sleep(0.3); print('Starting $loop at %s'%(datetime.now()))" | python
	./a.out 2> err$loop.log > out$loop.log &
done;
