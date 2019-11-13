#!/bin/bash

cmd="perl \$CONDA_PREFIX/bin/variant_effect_predictor.pl --offline --dir \$CONDA_PREFIX/vep_cache --force_overwrite --species $2 $3 $4 --buffer_size $5 --input_file $6 --output_file $7 --stats_file stat.htm $8"

if [ "$1" == 1 ]; then cmd="$cmd --fork \${GALAXY_SLOTS:-4}"; fi

eval $cmd


