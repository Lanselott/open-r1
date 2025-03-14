from datasets import load_dataset

results_org = "Lansechen"
model_name = "Lansechen/Qwen2.5-3B-Instruct-Distill-bs17k-batch32-epoch3-8192-addthinktoken"
sanitized_model_name = model_name.replace("/", "__")
task = "custom|gpqa_diamond|0"
public_run = False

dataset_path = f"{results_org}/details_{sanitized_model_name}{'_private' if not public_run else ''}"
details = load_dataset(dataset_path, task.replace("|", "_"), split="latest")


# dict_keys(['choices', 'cont_tokens', 'example', 'full_prompt', 'gold', 'gold_index', 'input_tokens', 'instruction', 'metrics', 'num_asked_few_shots', 'num_effective_few_shots', 'padded', 'pred_logits', 'predictions', 'specifics', 'truncated'])

for detail in details:
    print(detail)