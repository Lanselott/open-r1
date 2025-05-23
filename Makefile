.PHONY: style quality

# make sure to test the local checkout in scripts and not the pre-installed one (don't use quotes!)
export PYTHONPATH = src

check_dirs := src tests


# dev dependencies
install:
	uv venv openr1 --python 3.11 && . openr1/bin/activate && uv pip install --upgrade pip
	uv pip install vllm==0.8.4
	uv pip install setuptools
	uv pip install flash-attn --no-build-isolation
	GIT_LFS_SKIP_SMUDGE=1 uv pip install -e ".[dev]"

style:
	ruff format --line-length 119 --target-version py310 $(check_dirs) setup.py
	isort $(check_dirs) setup.py

quality:
	ruff check --line-length 119 --target-version py310 $(check_dirs) setup.py
	isort --check-only $(check_dirs) setup.py
	flake8 --max-line-length 119 $(check_dirs) setup.py

test:
	pytest -sv --ignore=tests/slow/ tests/

slow_test:
	pytest -sv -vv tests/slow/

# Evaluation

evaluate:
	$(eval PARALLEL_ARGS := $(if $(PARALLEL),$(shell \
		if [ "$(PARALLEL)" = "data" ]; then \
			echo "data_parallel_size=$(NUM_GPUS)"; \
		elif [ "$(PARALLEL)" = "tensor" ]; then \
			echo "tensor_parallel_size=$(NUM_GPUS)"; \
		fi \
	),))
	$(if $(filter tensor,$(PARALLEL)),export VLLM_WORKER_MULTIPROC_METHOD=spawn &&,) \

	MODEL_ARGS="pretrained=$(MODEL),dtype=bfloat16,$(PARALLEL_ARGS),max_model_length=2048,max_num_batched_tokens=2048,gpu_memory_utilization=0.8,trust_remote_code=True,\
	generation_parameters={max_new_tokens:2048,temperature:0.0,top_p:1.0}" && \
	lighteval vllm $$MODEL_ARGS "custom|$(TASK)|0|0" \
		--custom-tasks src/open_r1/evaluate.py \
		--use-chat-template \
		--system-prompt="You are a helpful AI Assistant that provides well-reasoned and detailed responses. You first think about the reasoning process as an internal monologue and then provide the user with the answer. Respond in the following format: <think>\n...\n</think>\n<answer>\n...\n</answer>" \
		--output-dir data/evals/$(MODEL) \
		--save-details \
		--push-to-hub \
		--results-org Lansechen

# 		--system-prompt="You are a helpful AI Assistant that provides well-reasoned and detailed responses. You first think about the reasoning process as an internal monologue and then provide the user with the answer. Respond in the following format: <think>\n...\n</think>\n<answer>\n...\n</answer>" \


evaluatebase:
	$(eval PARALLEL_ARGS := $(if $(PARALLEL),$(shell \
		if [ "$(PARALLEL)" = "data" ]; then \
			echo "data_parallel_size=$(NUM_GPUS)"; \
		elif [ "$(PARALLEL)" = "tensor" ]; then \
			echo "tensor_parallel_size=$(NUM_GPUS)"; \
		fi \
	),))
	$(if $(filter tensor,$(PARALLEL)),export VLLM_WORKER_MULTIPROC_METHOD=spawn &&,) \
	MODEL_ARGS="pretrained=$(MODEL),dtype=bfloat16,$(PARALLEL_ARGS),max_model_length=32768,gpu_memory_utilization=0.8,trust_remote_code=True,\
	generation_parameters={max_new_tokens:32768,temperature:1.0,top_p:1.0}" && \
	lighteval vllm $$MODEL_ARGS "custom|$(TASK)|$(SHOT)|0" \
		--custom-tasks src/open_r1/evaluate.py \
		--system-prompt="Please reason step by step, and put your final answer within \boxed{}." \
		--output-dir data/evals/$(MODEL) \
		--save-details \
		--push-to-hub \
		--results-org Lansechen

evaluateofficial:
	$(eval PARALLEL_ARGS := $(if $(PARALLEL),$(shell \
		if [ "$(PARALLEL)" = "data" ]; then \
			echo "data_parallel_size=$(NUM_GPUS)"; \
		elif [ "$(PARALLEL)" = "tensor" ]; then \
			echo "tensor_parallel_size=$(NUM_GPUS)"; \
		fi \
	),))
	$(if $(filter tensor,$(PARALLEL)),export VLLM_WORKER_MULTIPROC_METHOD=spawn &&,) \
	MODEL_ARGS="pretrained=$(MODEL),dtype=bfloat16,$(PARALLEL_ARGS),max_model_length=32768,gpu_memory_utilization=0.8,trust_remote_code=True" && \
	lighteval vllm $$MODEL_ARGS "lighteval|$(TASK)|$(SHOT)|0" \
		--use-chat-template \
		--system-prompt="Please reason step by step, and put your final answer within \boxed{}." \
		--output-dir data/evals/$(MODEL)
		--save-details \
		--push-to-hub \
		--results-org Lansechen

# Example usage:
# Single GPU:
#   make evaluate MODEL=deepseek-ai/DeepSeek-R1-Distill-Qwen-32B TASK=aime24
# Data parallel:
#   make evaluate MODEL=deepseek-ai/DeepSeek-R1-Distill-Qwen-32B TASK=aime24 PARALLEL=data NUM_GPUS=8
# Tensor parallel:
#   make evaluate MODEL=deepseek-ai/DeepSeek-R1-Distill-Qwen-32B TASK=aime24 PARALLEL=tensor NUM_GPUS=8
