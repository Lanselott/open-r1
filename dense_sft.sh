#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/Qwen2.5-3B-Instruct/sft/config_ot_114k.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/Qwen2.5-3B-Instruct/sft/config_or_math_220k.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/Qwen2.5-3B-Instruct/sft/config_bs_17k.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/Qwen2.5-3B-Instruct/sft/config_ot_114k.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/Qwen2.5-3B-Instruct/sft/config_bs_17k.yaml

accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
    --config recipes/Qwen2.5-3B-Instruct/sft/config_bs_17k_filtered.yaml

#---base---
#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/Qwen2.5-3B-base/sft/config_bs_17k.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#  --config recipes/Qwen2.5-3B-base/sft/config_ot_114k.yaml
