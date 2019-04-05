FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# INSERT MAINTAINER BELOW!
#LABEL maintainer ""

# #############################
# ### Install Python
# #############################
RUN apt-get update --fix-missing
RUN yes | apt-get install python3
RUN yes | apt-get install python3-pip
RUN yes | pip3 install --upgrade pip

#############################
### Create ML Environment
#############################
COPY ./requirements.txt /tmp/requirements.txt
RUN yes | pip3 install -r /tmp/requirements.txt
RUN yes | rm /tmp/requirements.txt

# #############################
# ### Install Additional Stuff
# #############################
RUN yes | apt-get install git

# # Necessary for unzipping files on valohai.
RUN apt-get install -y unzip

# # Install gdal related libraries.
RUN apt-get install -y binutils libproj-dev gdal-bin libgdal-dev libgdal1i
RUN pip3 install -q GDAL==1.10.0 --global-option=build_ext --global-option="-I/usr/include/gdal"

# Necessary for opencv
RUN yes | apt-get install libsm6 libxrender1 libfontconfig1 libglib2.0-0

# Alias python3 and pip3. Mind that this works only in interactive shells, i.e. you won't be able to call python3 with python within this Dockerfile.
RUN echo "alias pip=pip3" >> ~/.bash_aliases
RUN echo "alias python=python3" >> ~/.bash_aliases

RUN /bin/bash -c "source ~/.bash_aliases"