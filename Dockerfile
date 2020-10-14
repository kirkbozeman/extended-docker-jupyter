FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get upgrade -y \
    && apt-get install -y \
        software-properties-common \
        openjdk-11-jdk \
        nodejs \
        golang \
        r-base \
        vim \
        sudo \
        git \
        curl \
        wget
# installs go at /usr/bin/go

# install python 3.8
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install -y python3.8 \
        python3-pip

# pip install
#RUN pip3 install --upgrade pip
ADD docker/requirements.txt /root/
RUN pip3 install -r /root/requirements.txt

# install spylon kernel
RUN pip3 install spylon-kernel \
    && python3 -m spylon_kernel install

# install scala kernel
RUN curl -Lo coursier https://git.io/coursier-cli \
    && chmod +x coursier \
    && ./coursier launch --fork almond -- --install \
    && rm -f coursier

# install R kernel
RUN R -e "install.packages('IRkernel')" \
    && R -e "IRkernel::installspec()"

# install Java kernel
RUN git clone https://github.com/SpencerPark/IJava.git \
    && cd IJava/ \
    && ./gradlew installKernel

# install go kernel (https://github.com/gopherdata/gophernotes)
#RUN env GO111MODULE=off go get -d -u github.com/gopherdata/gophernotes
#RUN cd "$(go env GOPATH)"/src/github.com/gopherdata/gophernotes
#RUN env GO111MODULE=on go install  # THE SAME FUCKING BULLSHIT
#RUN mkdir -p ~/.local/share/jupyter/kernels/gophernotes
#RUN cp kernel/* ~/.local/share/jupyter/kernels/gophernotes
#RUN cd ~/.local/share/jupyter/kernels/gophernotes
#RUN chmod +w ./kernel.json # in case copied kernel.json has no write permission
#RUN sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json

#$ env GO111MODULE=on go get github.com/gopherdata/gophernotes
#$ mkdir -p ~/.local/share/jupyter/kernels/gophernotes
#$ cd ~/.local/share/jupyter/kernels/gophernotes
#$ cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.1/kernel/*  "."
#$ chmod +w ./kernel.json # in case copied kernel.json has no write permission
#$ sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json

# start me up
COPY docker/entrypoint.sh /root/
RUN chmod +x /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]
EXPOSE 8890

