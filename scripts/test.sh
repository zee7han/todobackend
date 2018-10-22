#!/bin/bash
# Activate the virtual environment
. /appenv/bin/activate

# Install the python dependencies
pip install -r requirements_test.txt

# Run test.sh arguments
exec $@
