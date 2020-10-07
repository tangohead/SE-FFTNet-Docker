from pathlib import Path
import os
import json
import subprocess

DEFAULT_CONFIG = "/se-fftnet/config/config_params.json"
DEFAULT_MODEL = 1

if __name__ == "__main__":
    # Load the config file to get the directories
    with open(DEFAULT_CONFIG, "r") as f:
        config_data = json.load(f)

    input_dir_path = Path(os.path.join(config_data["data_dir"], config_data["test_noisy_audio_dir"]))

    # Run for each file in input
    for input_file_path in input_dir_path.iterdir():
        # We need to remove the file extension because the model
        # adds it
        trimmed_name = input_file_path.stem
        print(f"Input filename {trimmed_name}")

        subprocess.run(["python3", 
                            "/se-fftnet/src/generate.py", 
                            f"--config={DEFAULT_CONFIG}",
                            f"--model_id={DEFAULT_MODEL}",
                            f"--noisy_speech_filename={trimmed_name}"
                        ])
