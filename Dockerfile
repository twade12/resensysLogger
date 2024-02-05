ARG SID
FROM ubuntu:22.04
ARG SID
RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
        apt-transport-https \
        wget \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 40976EAF437D05B5 \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3B4FE6ACC0B21F32

# create alpha server directory and set as current working directory
RUN mkdir ./alpha_server
WORKDIR /alpha_server

# handle installation of mysql dependencies
COPY loadMysqlclient.sh loadMysqlclient.sh
RUN bash loadMysqlclient.sh
RUN apt-get update \
    && apt-get install -y \
        gcc \
        build-essential \
        mysql-server

# Copy indexing script
COPY indexSingleSite.sh indexSingleSite.sh
RUN mkdir -p ./log \
    && touch ./log/logger.log

RUN echo "The site ID is $SID"

# Command to run the logger executable
CMD ["./DbLogger"]
