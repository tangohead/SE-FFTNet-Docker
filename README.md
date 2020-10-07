# SE-FFTNet in a handy Docker container

This is a small repo to make it easier to use SE-FFTNet to clean up audio samples. It wraps the model in Docker, takes in noisy WAV files and outputs cleaned up WAVs.

Requirements:
* Linux (currently, until CUDA for WSL2 is released)
* Docker & Nvidia-docker (tested on 19.03.6)

The container follows the requirements of [SE-FFTNet](https://github.com/shifaspv/SE-FFTNet-tensorflow-implemenatation), so is based on [`tensorflow/tensorflow:1.14.0-gpu-py3`](https://hub.docker.com/layers/tensorflow/tensorflow/1.14.0-gpu-py3/images/sha256-e72e66b3dcb9c9e8f4e5703965ae1466b23fe8cad59e1c92c6e9fa58f8d81dc8?context=explore). 

You can build with:

```
docker build -t se-fftnet:<version number> -f build_tf.dockerfile .
```

Set up a directory for output (called `output` here) and inside that, put a directory called `input`. Put the files you wish to convert in `input`, then run the container, mounting it as below:

```
docker container run --runtime=nvidia -v <local path>:/se-fftnet/output/ se-fftnet:<version number>
```

Note that this uses the model provided in the SE-FFTNet repo.

## Changing the Config

SE-FFTNet comes with a prebuilt config file called `config.json` - you can find this in the `SE-FFTNet-tensorflow-implemenatation` repo, under `config`. To keep this as a submodule and avoid changing the files, I have created a local config which Docker will use to overwrite the default config on build. You can find this [here](config/config_params.json). Some useful things you might wish to change are:

* `data_dir` - sets the base directory that the model takes input from
* `test_noisy_audio_dir` - the directory within the base directory, where the model expects to find WAVs
* `base_dir` - the base directory for the model
* `output_dir` - where the model outputs clean WAVs

