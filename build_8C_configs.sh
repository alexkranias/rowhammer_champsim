#!/bin/bash

while IFS= read -r config
do
	./config.py configs/8C_${config}
	make -j8
	echo
	echo built $config
	echo
	sleep 3
done < configs/configs.txt
