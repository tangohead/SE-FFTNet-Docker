FROM tensorflow/tensorflow:1.14.0-gpu-py3

WORKDIR /se-fftnet/

RUN apt-get -y install libsndfile1

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY SE-FFTNet-tensorflow-implemenatation .

# Overwrite the config with friendlier input and output dirs
COPY config/config_params.json /se-fftnet/config/

# Overwrite the run script to use python3 and point to the correct dirs
COPY scripts/generate.sh /se-fftnet/src/

COPY scripts/run_sefftnet.py /se-fftnet/src/

WORKDIR /se-fftnet/src/

CMD [ "python3", "run_sefftnet.py" ]