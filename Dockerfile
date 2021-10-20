FROM conda/miniconda3

RUN apt-get update && yes|apt-get install git

RUN git clone https://github.com/RainierBarrett/MSE463-563.git && \
    cd MSE463-563 && conda update -n base --file=environment.yml && conda clean --all --yes -f

# Make RUN commands use `bash --login`: -- fixes conda init
# https://pythonspeed.com/articles/activate-conda-dockerfile/
SHELL ["conda", "run", "-n", "base", "/bin/bash", "--login", "-c"]

# Prevent python from loading packages from outside the container
# default empty pythonpath
ENV PYTHONPATH=/ignore/pythonpath

CMD jupyter notebook --port=8888 --ip='*' --no-browser --notebook-dir=/home/ --allow-root --NotebookApp.iopub_data_rate_limit=100000000