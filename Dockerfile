# Use the official Rocker Tidyverse image as the base image
FROM rocker/tidyverse:4.4

COPY ./workbench /opt/workbench
COPY r-package.list /tmp
COPY sources.list /etc/apt/

# Install system dependencies and R packages
RUN apt-get update && \
    apt-get install -y libgsl-dev libglpk-dev libglu1-mesa && \
    Rscript -e "install.packages(readLines('/tmp/r-package.list'), Ncpus = 8)"

# Install Python packages
RUN apt-get install -y python3-pip && \
    pip3 install pybids

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
