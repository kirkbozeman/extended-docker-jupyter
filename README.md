### JupyterLab in Docker

This repo contains a dockerization of the most recent version of JupyterLab on an Ubuntu 18.04 image. The image uses Python 3.8 with a number of extra language kernels. 

This was written to avoid future issues with having to reinstall Jupyter w/ these extra kernels on new or different machines, as it is a pain to do. 

Why ubuntu? To play. Also to make installing Java a little easier. Unfortunately it makes the build a little long, but you only have to do it once.

Also note I run this on port 8890 instead of the traditional 8888, this is to avoid clashes with any local notebook servers that are running.

Current kernel support:
- Java (https://github.com/SpencerPark/IJava)
- scala (https://almond.sh/)
- Python 3.8
- R (https://github.com/IRkernel/IRkernel)
- Ruby
- spylon (spark/scala) (https://pypi.org/project/spylon-kernel/0.0.1/)

Kernels to be added eventually:
- Go
- ???

Useful docker commands:
```bash
docker build -t docker-jupyterlab:local .
docker run -it -p 8890:8890 -v ~:/mnt/local docker-jupyterlab:local
docker exec -it $(docker ps -q --filter ancestor=docker-jupyterlab:local) /bin/bash
docker stop $(docker ps -q --filter ancestor=docker-jupyterlab:local)
```
