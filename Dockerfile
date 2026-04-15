# Base image with a pinned R version
FROM rocker/rstudio:4.4.1

# Install system dependencies that R packages might need
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install renv
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

# Copy the lockfile into the image
COPY renv.lock /home/rstudio/r-docker-demo/renv.lock

# Make sure root is not owner
RUN chown -R rstudio:rstudio /home/rstudio/r-docker-demo

# Set working directory
WORKDIR /home/rstudio/r-docker-demo

# Restore packages from the lockfile
RUN R -e "renv::restore()"

# Copy the rest of the project files
COPY . /home/rstudio/r-docker-demo/