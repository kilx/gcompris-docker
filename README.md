# gcompris-docker

gcompris build env for android builds

Build the image:
```
docker build -t gcompris_build .
```

Run the image and attach to it:
```
docker run -it --entrypoint=/bin/bash gcompris_build -i
```

In conteiner run the cmake wrapper:
```
../cmake.sh
```

And compile:
```
make
```

TODO
