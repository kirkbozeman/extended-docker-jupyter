### JupyterLab in Docker

This repo contains a dockerization of the most recent version of JupyterLab on an Ubuntu 18.04 image. The image uses Python 3.8 with a number of extra language kernels. 

This was written to avoid future issues with having to reinstall Jupyter w/ these extra kernels on new or different machines, as it is a pain to do. It was also written to practice a bit of bash scripting. :)

Why ubuntu? To play. Also to make installing Java a little easier. Unfortunately it makes the build a little long, but you only have to do it once.

Current kernel support:
- spylon (spark/scala) (https://pypi.org/project/spylon-kernel/0.0.1/)
- scala (https://almond.sh/)
- R (https://github.com/IRkernel/IRkernel)

Kernels to be added eventually:
- Java
- Go
- ???

Useful docker commands:
```bash
docker build -t docker-jupyterlab:local .
docker run -it -p 8890:8890 -v ~:/mnt/local docker-jupyterlab:local
docker exec -it $(docker ps -q --filter ancestor=docker-jupyterlab:local) /bin/bash
docker stop $(docker ps -q --filter ancestor=docker-jupyterlab:local)
```