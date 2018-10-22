FROM zee7han/todobackend-base:latest
MAINTAINER Mohammad Zeeshan <zee7han@gmail.com>


# Install dev/build dependencies
RUN apt-get update && \
  apt-get install -qy python-dev libmysqlclient-dev

# Activate virtual environment and install wheel support
RUN . /appenv/bin/activate && \
  pip install wheel --upgrade

# PIP environment variable (NOTE: must be set after wheel installation)
ENV WHEELHOUSE=/wheelhouse PIP_WHEEL_DIR=/wheelhouse PIP_FIND_LINKS=/wheelhouse XDG_CACHE_HOME=/cache

# OUTPUT: Build artifacts (wheel) output are here
VOLUME /wheelhouse

#OUTPUT: Build cache
VOLUME /build

# OUTPUT: Test reports output are here
VOLUME /reports

# Add entrypoint script
ADD scripts/test.sh /usr/local/bin/test.sh
RUN chmod +x /usr/local/bin/test.sh

# Set default for the entrypoint and string command
ENTRYPOINT ["test.sh"]
CMD ["python", "manage.py", "test", "--noinput"]


# Add application source code
COPY src /application
WORKDIR /application
