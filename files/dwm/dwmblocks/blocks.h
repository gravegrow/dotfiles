// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/

    {"", "dwm-sound-device", 0, 1},
    {"", "dwm-status-volume", 5, 2},
    {"", "dwm-status-clock", 5, 3},
    {"", "dwm-status-power", 0, 4},
};

// sets delimeter between status commands. NULL character ('\0') means no
// delimeter.
static char delim[] = " ";
static unsigned int delimLen = 2;
