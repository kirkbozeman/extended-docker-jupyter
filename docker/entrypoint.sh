#!/bin/bash

# run jupyter
jupyter lab --ip=0.0.0.0 --port=8890 \  # send to 8890 to avoid clashes with local on 8888
    --NotebookApp.token='' --NotebookApp.password='' \  # do not require auth
    --allow-root --notebook-dir='mnt/local/'  # mount local home as default dir
