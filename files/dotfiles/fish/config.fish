alias ls='exa --oneline --icons --group-directories-first --color=always'
alias la='ls --all'
alias tree='tree -C'
alias py='python3'
alias lg='lazygit'

if type -q bat
    alias cat='bat'
end

function ffmpeg_vr
    set -l FILE $argv[1]
    set -l OUTPUT_DIR $argv[2]

    ffmpeg -y -hide_banner \
    -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi \
    #-ss 00:01:00 -to 00:02:00 \
    -i $FILE \
    -vf 'format=vaapi,hwupload,scale_vaapi=w=2160:h=1080' -c:v hevc_vaapi \
    -qp 30 \
    "$OUTPUT_DIR/$FILE"
end

fish_vi_key_bindings
fish_ssh_agent
fish_add_path $HOME/.spicetify
pyenv init - | source

starship init fish | source
enable_transience

