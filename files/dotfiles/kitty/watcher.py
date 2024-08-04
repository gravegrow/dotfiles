import subprocess
from typing import Any, Dict

from kitty.boss import Boss
from kitty.window import Window

# def on_resize(boss: Boss, window: Window, data: Dict[str, Any]) -> None:
#     # Here data will contain old_geometry and new_geometry

# def on_focus_change(boss: Boss, window: Window, data: Dict[str, Any])-> None:
#     # Here data will contain focused


def on_close(boss: Boss, window: Window, data: Dict[str, Any]) -> None:
    # subprocess.run("kitty", check=False)

    cmd = ["tmux", "ls", "-F '#{session_name}: #{session_attached}'"]

    sessions = subprocess.check_output(cmd, universal_newlines=True)

    if sessions:
        print(sessions.split("\n"))

    # called when window is closed, typically when the program running in
    # it exits


# def on_set_user_var(boss: Boss, window: Window, data: Dict[str, Any]) -> None:
#     # called when a "user variable" is set or deleted on a window. Here
#     # data will contain key and value

# def on_title_change(boss: Boss, window: Window, data: Dict[str, Any]) -> None:
#     # called when the window title is changed on a window. Here
#     # data will contain title and from_child. from_child will be True
#     # when a title change was requested via escape code from the program
#     # running in the terminal

# def on_cmd_startstop(boss: Boss, window: Window, data: Dict[str, Any]) -> None:
#     # called when the shell starts/stops executing a command. Here
#     # data will contain is_start and time.
