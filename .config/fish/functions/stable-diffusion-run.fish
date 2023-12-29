function stable-diffusion-run 
  # docker run -it --name StableDiffusion --network=host --device=/dev/kfd --device=/dev/dri --group-add=video --ipc=host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v /media/storage/development/stable-diffusion/:/stable-diffusion rocm/pytorch
  docker restart StableDiffusion
  docker exec -it StableDiffusion bash -c \
  "cd /stable-diffusion/stable-diffusion-webui;\
  REQS_FILE='requirements.txt'\
  PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512\
  python launch.py --medvram --always-batch-cond-uncond --precision full --no-half\
  --no-half-vae --opt-split-attention-v1 --opt-sub-quad-attention --disable-nan-check --opt-sdp-attention"
end


# python launch.py --precision full --no-half --opt-sub-quad-attention"
