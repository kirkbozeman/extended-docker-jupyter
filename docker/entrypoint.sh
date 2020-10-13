#!/bin/bash

# run jupyter
jupyter lab --ip=0.0.0.0 --port=8890 \
    --NotebookApp.token='' --NotebookApp.password='' \
    --allow-root --notebook-dir='mnt/local/'
