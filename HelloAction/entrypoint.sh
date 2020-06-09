#!/bin/sh -l

echo "Hello $1"
time=$(date)
echo "::set-output name=surname::monkey"
echo "::set-output name=time::$time"
echo "MY CUSTOM TEXT CAPS"
