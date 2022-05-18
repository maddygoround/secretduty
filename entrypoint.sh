#!/bin/sh -l

echo "Hello $1"
whispers $1
time=$(date)
echo "::set-output name=time::$time"