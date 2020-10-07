if [ $# -ne 1 ]; then
    echo 'Error in parameters' 
    echo Usage: $0' model_id'
    exit
fi

filenames="KJFK-Twr_2020-09-09T0030Z_chunk-0007"

for filename in $filenames
do
    echo $filename
    echo $1
    python3 generate.py --config=/se-fftnet/config/config_params.json --model_id=$1 --noisy_speech_filename=$filename
done


