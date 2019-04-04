FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# INSERT MAINTAINER BELOW!
#LABEL maintainer ""

# #############################
# ### Install Python
# #############################
RUN apt-get update
RUN yes | apt-get install python3
RUN yes | apt-get install python3-pip
RUN yes | pip3 install --upgrade pip

#############################
### Create ML Environment
#############################
COPY ./requirements.txt /tmp/requirements.txt
RUN yes | pip3 install -r /tmp/requirements.txt
RUN yes | rm /tmp/requirements.txt

#############################
### Install Additional Stuff
#############################
RUN yes | apt-get install git
# Necessary for opencv
RUN yes | apt-get install libsm6 libxrender1 libfontconfig1 libglib2.0-0

