# Use the official Rocker Tidyverse image as the base image
FROM rocker/tidyverse:4.4

# Install system dependencies and R packages
RUN apt-get update && \
    apt-get install -y libgsl-dev libglpk-dev libglu1-mesa && \
    Rscript -e "install.packages(c('cpmr', 'reticulate', 'igraph', 'ciftiTools', 'ggpmisc', 'showtext'), Ncpus = 8)"

# Install Python packages
RUN apt-get install -y python3-pip && \
    pip3 install pybids

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the workbench directory to /opt/workbench
COPY ./workbench /opt/workbench
