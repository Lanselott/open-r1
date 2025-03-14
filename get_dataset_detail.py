from datasets import load_dataset

# Login using e.g. `huggingface-cli login` to access this dataset
dataset = load_dataset("Lansechen/bs17k_collection_filtered_hard_maxlength600", split="train")
none_example = [
    example for i, example in enumerate(dataset)
    if any(value is None for value in example['solution'])
]

# for data in dataset:
from IPython import embed;embed()