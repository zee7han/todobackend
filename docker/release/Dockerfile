FROM zee7han/todobackend-base:latest
MAINTAINER Mohammad Zeeshan <zee7han@gmail.com>


# Copy application artifacts
COPY target /wheelhouse

# Install applications
RUN . /appenv/bin/activate && \
  pip install --no-index -f /wheelhouse todobackend && \
  rm -rf /wheelhouse
