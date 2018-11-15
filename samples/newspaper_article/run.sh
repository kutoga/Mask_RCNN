#!/bin/bash
set -e
result_dir="$1"
if [ -z "$result_dir" ]; then
    result_dir=/data/results/
fi
echo "Result dir: $result_dir"
best_model="/data/best_model.h5"
python3.6 newspaper_article.py --dataset /data/output_data_merged_256/ --weights coco --layers all --checkpoint "$best_model" train
python3.6 newspaper_article.py --dataset /data/output_data_merged_256/ --weights coco --layers all --checkpoint "$best_model" test

# Collect results
mkdir -p "$result_dir"
mv visualization* "$result_dir"
cp "$0" "$result_dir"
git rev-parse HEAD | head -c8 > "$result_dir/commit.txt"

