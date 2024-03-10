# Use an official Python image as a parent image
FROM python:3.10-slim-bullseye

# Set environment variables
ENV ODOO_VERSION 17.0
ENV DEBIAN_FRONTEND noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev \
        libldap2-dev \
        libsasl2-dev \
        libtiff5-dev \
        libjpeg62-turbo-dev \
        libopenjp2-7-dev \
        zlib1g-dev \
        libfreetype6-dev \
        liblcms2-dev \
        libwebp-dev \
        tcl8.6-dev \
        tk8.6-dev \
        python-tk \
        libharfbuzz-dev \
        libfribidi-dev \
        libxcb1-dev \
        wget \
        git \
        node-less \
        npm \
        python3-dev \
        && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    && dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb || apt-get install -yf \
    && rm wkhtmltox_0.12.5-1.buster_amd64.deb

# Set the working directory in the container
WORKDIR /opt/odoo

# Copy only requirements.txt first to leverage Docker cache
COPY ./requirements.txt ./requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /opt/odoo
COPY . /opt/odoo

# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE 8069 8072

# Set the default command to execute
CMD ["/entrypoint.sh"]
