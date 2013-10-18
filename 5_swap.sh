#!/bin/bash
dd if=/dev/zero of=/knoppix.temp bs=1M count=250
mkswap /knoppix.temp 
swapon /knoppix.temp