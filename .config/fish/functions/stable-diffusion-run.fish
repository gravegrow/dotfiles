function stable-diffusion-run 
  docker container restart 07e59d1b4be0 
  docker exec -it 07e59d1b4be0 bash -c \
  "cd /stable-diffusion/stable-diffusion-webui;\
  git pull;\
  REQS_FILE='requirements.txt'\
  PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512\
  python launch.py --medvram --always-batch-cond-uncond --precision full --no-half\
  --no-half-vae --opt-split-attention-v1 --opt-sub-quad-attention --disable-nan-check --opt-sdp-attention"
end


# python launch.py --precision full --no-half --opt-sub-quad-attention"
