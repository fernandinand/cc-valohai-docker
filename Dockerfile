FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# INSERT MAINTAINER BELOW!
#LABEL maintainer ""
COPY ./requirements.txt /tmp/requirements.txt

# #############################
# ### Install Python
# #############################
RUN apt-get update --fix-missing && apt-get install -y python3 python3-pip git unzip binutils libproj-dev gdal-bin libgdal-dev libgdal1i libsm6 libxrender1 libfontconfig1 libglib2.0-0
RUN yes | pip3 install --upgrade pip

#############################
### Create ML Environment
#############################
RUN yes | pip3 install -r /tmp/requirements.txt && pip3 install -q GDAL==1.10.0 --global-option=build_ext --global-option="-I/usr/include/gdal"


# Alias python3 and pip3. Mind that this works only in interactive shells, i.e. you won't be able to call python3 with python within this Dockerfile.
RUN echo "alias pip=pip3" >> ~/.bash_aliases && echo "alias python=python3" >> ~/.bash_aliases
CMD cd code; export PYTHONPATH=$PYTHONPATH:/code/predictions/species_prediction/regressors; celery -A distributed.app worker -Q PREDICTIONS --concurrency 1 --loglevel=INFO -n predictions-worker@%h

