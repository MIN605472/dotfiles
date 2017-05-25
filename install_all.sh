# !/bin/bash

for d in $(ls -d */); do
  ( stow $d )
done
