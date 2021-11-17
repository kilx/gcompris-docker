# gcompris-docker

gcompris build env for android builds

Build the image:
```
docker build -t gcompris-build .
```

Run the image and attach to it:
```
docker run -it --entrypoint=/bin/bash gcompris-build -i
```

In container run the cmake wrapper from the build directory, make to compile and make apk\_debug to build the apk file:
```
/opt/build/cmake.sh .. && make -j4 && make apk_debug
```
