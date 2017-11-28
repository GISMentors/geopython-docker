# Docker image for GISMmentors/GeoPython workshop

Docker image configuration of [Jupyter notebook](http://jupyter.org/) for the
GeoPython training courses provided by [GISMentors](http://gismentors.cz).

* http://training.gismentors.eu/geopython-zacatecnik
* http://training.gismentors.eu/geopython-pokrocily

## Run it

1. Install Docker
2. Download Docker image

```
docker pull opengeolabs/gismentors:geopython
```

3. Run Docker container

```
docker run -p 8888:8888 \
           -v $(pwd):/localdata/ \
           --rm --name geopython-workshop \
           opengeolabs/gismentors:geopython
```

4. Open browser and go to http://localhost:8888

5. Enter password: `geopython`

6. Follow the workshop at http://training.gismentors.eu/geopython-zacatecnik

Data are located in `/data/data` folder, student working directories should be
created in `/outputs/` dir.

## Build it

```
docker build ./ --rm --tag opengeolabs/gismentors:geopython
```

## Upload it to Docker hub

```
docker login
docker push opengeolabs/gismentors:geopython
```

## Connect to the server using shell

```
docker exec -i -t geopython-workshop /bin/bash
```
