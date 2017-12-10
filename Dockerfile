FROM ubuntu:latest

LABEL com.example.version="1.0.0-alpha"
LABEL vendor="GISMentors/OpenGeoLabs"
LABEL com.example.release-date="2017-12-10"
LABEL com.example.version.is-production=""

RUN apt-get update && \
    apt-get install -y software-properties-common

RUN add-apt-repository ppa:ubuntugis/ppa && \
    apt-get update && \
    apt-get install -y python3-gdal libgdal-dev \
                       python3-pip python3 wget zip

ADD requirements.txt /tmp/

#RUN pip3 download GDAL && \
#    cd build/GDAL && \
#    python setup.py install \
#            --gdal-config=/usr/bin/gdal-config \
#            --include-dirs=/usr/include/ \
#            --library-dirs=/usr/lib/ && \
#    pip3 install ./GDAL

RUN pip3 install GDAL==2.1.3 --global-option=build_ext --global-option="-I/usr/include/gdal"

RUN pip3 install -r /tmp/requirements.txt

RUN apt-get clean

RUN useradd -c 'Pythonista' -m -d /home/pythonista -s /bin/bash pythonista

ADD jupyter_notebook_config.json /home/pythonista/.jupyter/jupyter_notebook_config.json

RUN mkdir -p /home/pythonista/geopython/data/ && \
    cd /home/pythonista/geopython/data/ && \
    wget -nv -O data-geopython.tgz http://training.gismentors.eu/geodata/geopython/data.tgz && \
    wget -nv -O data-vector.zip http://training.gismentors.eu/geodata/qgis/data.zip && \
    wget -nv -O data-raster.zip http://training.gismentors.eu/geodata/qgis/dmt.zip && \
    tar -xzf data-geopython.tgz && \
    unzip data-vector.zip && \
    unzip data-raster.zip && \
    rm data-raster.zip data-vector.zip data-geopython.tgz && \
    mkdir -p /home/pythonista/geopython/outputs && \
    chmod -R +r /home/pythonista/geopython && \ 
    chown -R pythonista.pythonista /home/pythonista/geopython &&\
    chown -R pythonista.pythonista /home/pythonista/.jupyter 

RUN ln -s /home/pythonista/geopython/data /data &&\
    ln -s /home/pythonista/geopython/data/data /data/geopython && \
    ln -s /home/pythonista/geopython/outputs /outputs


USER pythonista
ENV HOME /home/pythonista
WORKDIR /home/pythonista/geopython

EXPOSE 8888

ENTRYPOINT ["jupyter"] 
CMD ["notebook", "--ip='*'", "--no-browser"]
