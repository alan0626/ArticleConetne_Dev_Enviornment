#!/bin/bash

# MAC OS need to install this command to use realpath: brew install coreutils
curDir=$(dirname "$(realpath $0)")

# Clean-up old image if existed.
for image_name in atom-kobuta-dev atom-kobuta-base
do
    if [ $(docker images $image_name -q | wc -l) == "1" ]; then
        docker rmi $image_name
        echo "Docker image: $image_name was removed."
    fi
done

# Clone atom-kobuta project and dev package into it
cd $curDir
#git clone <GitHub_Source_Code>
cp -R docker-dev/* atom-kobuta

# Build base and dev docker images
cd $curDir/atom-kobuta
docker build -t atom-kobuta-base .
docker build -t atom-kobuta-dev -f Dockerfile-dev .

