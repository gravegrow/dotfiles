function mayalog
  if pgrep -f maya > /dev/null
    clear
    python /media/storage/dev/maya/tools/maya-sender.nvim/rplugin/python3/log.py
  end
end
