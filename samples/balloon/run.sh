#!/bin/bash
set -e
result_dir="$1"
if [ -z "$result_dir" ]; then
    result_dir=/data/results/
fi
echo "Result dir: $result_dir"
python3.6 balloon.py --dataset /data/output_data_merged_256/ --weights coco --layers all --checkpoint /data/best_model.h5 train
python3.6 balloon.py --dataset /data/output_data_merged_256/ --checkpoint /data/best_model.h5 test

# Collect results
mkdir -p "$result_dir"
mv visualization* "$result_dir"
cp "$0" "$result_dir"
git rev-parse HEAD | head -c8 > "$result_dir/commit.txt"

