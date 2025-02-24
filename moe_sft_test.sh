#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/DeepSeek-V2-Lite-Chat/sft/config_demo_moe.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/DeepSeek-V2-Lite-Chat/sft/config_moe_ot114k.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/DeepSeek-V2-Lite-Chat/sft/config_moe_numinamath.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft_lora.py  --trust_remote_code True \
#    --config recipes/DeepSeek-V2-Lite-Chat/sft/config_moe_lora_numinamath.yaml

## single gpu test
#accelerate launch --main_process_port 29499 --config_file recipes/accelerate_configs/zero3_singlegpu.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/DeepSeek-V2-Lite-Chat/sft/config_moe_numinamath.yaml

#accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/OLMoE-1B-7B-0125-Instruct/sft/config_bs_17k.yaml

accelerate launch --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
    --config recipes/OLMoE-1B-7B-0125-Instruct/sft/config_ot_114k.yaml

#accelerate launch --main_process_port 29499 --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/DeepSeek-V2-Lite-Chat/sft/config_moe_bs_17k.yaml

#accelerate launch --main_process_port 29499 --config_file recipes/accelerate_configs/zero3.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/DeepSeek-V2-Lite-Chat/sft/config_moe_ot114k.yaml


#accelerate launch --main_process_port 29499 --config_file recipes/accelerate_configs/zero3_no_offload.yaml src/open_r1/sft.py  --trust_remote_code True \
#    --config recipes/OLMoE-1B-7B-0125-Instruct/sft/config_or_math_220k.yaml