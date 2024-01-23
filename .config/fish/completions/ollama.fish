complete --command fisher --exclusive --long help --description "help for ollama"
complete --command fisher --exclusive --long version --description "Show version information"

complete --command ollama --exclusive --condition __fish_use_subcommand --arguments serve    --description   "Start ollama"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments create   --description   "Create a model from a Modelfile"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments show     --description   "Show information for a model"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments run      --description   "Run a model"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments pull     --description   "Pull a model from a registry"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments push     --description   "Push a model to a registry"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments list     --description   "List models"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments cp       --description   "Copy a model"
complete --command ollama --exclusive --condition __fish_use_subcommand --arguments rm       --description   "Remove a model"

complete --command ollama --exclusive --condition "__fish_seen_subcommand_from rm cp run"    --arguments '(ollama list | rg -o "^[^NAME]+" | rg -o "^[^:]+")'


