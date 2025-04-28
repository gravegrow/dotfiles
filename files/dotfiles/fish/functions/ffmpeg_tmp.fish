function ffmpeg_vr
    set -l FILE $argv[1]
    set -l OUTPUT_DIR $argv[2]

    ffmpeg -y -hide_banner \
        -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi \
        #-ss 00:01:00 -to 00:02:00 \
        -i $FILE \
        -vf 'format=vaapi,hwupload,scale_vaapi=-2:1440' -c:v hevc_vaapi \
        -qp 30 \
        "$OUTPUT_DIR/$FILE"
end
