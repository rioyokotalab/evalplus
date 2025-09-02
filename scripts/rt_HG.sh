#!/bin/bash
#PBS -q rt_HG
#PBS -N eval_plus
#PBS -l select=1
#PBS -l walltime=1:00:00
#PBS -j oe
#PBS -m n
#PBS -koed
#PBS -V
#PBS -o outputs/

set -e
cd $PBS_O_WORKDIR

echo "Nodes allocated to this job:"
cat $PBS_NODEFILE

# environment variables
export TMP="/groups/gag51395/fujii/tmp"
export TMP_DIR="/groups/gag51395/fujii/tmp"
export HF_HOME="/groups/gag51395/fujii/hf_cache"

source .venv/bin/activate

MODEL_NAME="tokyotech-llm/Llama-3.1-8B-swallow-code-v2-exp8-iter0002500"

export CUDA_VISIBLE_DEVICES=0
evalplus.evaluate --model $MODEL_NAME \
                  --dataset humaneval \
                  --backend vllm      \
                  --tp 1              \
                  --greedy            \
                  --force-base-prompt
