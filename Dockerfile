##################################  Notes  ##################################
# build:
#   docker build --no-cache -t freedpays .
#
# run:
#   docker run -it -p 15015:15015 freedpays
#
# run with a mounted directory for ~/.FreedPays:
#   docker run -it -p 15015:15015 -v /path/to/a/local/directory:/root/.FreedPays freedpays
#
# run will exec you into docker /bin/bash
# from there, you can run:
# freedpaysd # starts the freedpays deamon
#
# For accessing the freedpays JSON-RPC api from the host:
# 1. Expose RPC port in when running docker
#    docker run -it -p 15015:15015 -p 5000:XXX -v /path/to/a/local/directory:/root/.FreedPays freedpays # Replace XXX with set rpcPort in freedpays.conf
# 2. From host access the API via:
# `curl --user rpc_user:rpc_pass --data '{"method": "getinfo"}' http://127.0.0.1:5000`
#############################################################################

FROM ubuntu:16.04

# Build essentials
RUN apt-get install git build-essential libboost1.58-all-dev libssl-dev libdb5.3++-dev libminiupnpc-dev

RUN apt-get clean

RUN git clone https://github.com/FreedPays/FreedPays.git FreedPays && cd FreedPays/src/ && make -f makefile.unix && cp freedpaysd /usr/local/sbin/freedpaysd

RUN mkdir /root/.FreedPays/

CMD ["/bin/bash"]
