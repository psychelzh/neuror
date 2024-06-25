# Use the official Rocker Tidyverse image as the base image
FROM rocker/tidyverse:4.4

COPY DESCRIPTION /tmp/DESCRIPTION
COPY sources.list /etc/apt/

# Install system dependencies and R packages
WORKDIR /tmp
RUN apt-get update && \
    apt-get install -y libgsl-dev libglpk-dev && \
    Rscript -e "install.packages('pak')" && \
    Rscript -e "pak::local_install_deps(dependencies = 'all')"

# Install Python packages
RUN apt-get install -y python3-pip && pip3 install pybids

# Used for surface-based analysis
RUN apt-get install -y connectome-workbench

# add chinese fonts
RUN apt-get install -y fontconfig fonts-wqy-zenhei
RUN fc-cache -fv

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
