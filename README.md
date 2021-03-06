# Hammerspoon

A suite of Lua scripts for [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) that provide functionality and keyboard shortcuts for actions I commonly use.

## Installation

1. Install [Hammerspoon](https://github.com/Hammerspoon/hammerspoon).
1. Clone this repository into your `~/.hammerspoon` directory.
1. Open Hammerspoon or reload your config from the Hammerspoon menubar menu.

## Features

### DNS Menu
Displays the current DNS server settings in the menubar (useful in conjunction with [sdns](https://github.com/senorprogrammer/sdns))

### File Deleter
A script to delete `.bash-history` and `.zsh-history` files.

* `Cmd-Alt-Ctrl-d` : delete the files

### Firewall
Displays two dots in the top-right of the menubar:
* Firewall state: red for off, green for on
* Firewall stealth mode: red for off, green for on

Checks the status every two minutes

### Hammerspoon Development
A script to automatically reload the Hammerspoon configuration whenever a file in the `.hammerspoon` dir changes

### iTunes Control
* `Alt-Ctrl-Space` : play/pause
* `Alt-Ctrl-x`     : next track
* `Alt-Ctrl-z`     : previous track
* `Alt-Ctrl-c`     : display current track

### Mouse Location
* `Cmd-Alt-Ctrl-m` : find the cursor on the screen

### UTC Menu
Displays a universal time (UTC) clock in the menubar

### Volume Control
* `Cmd-Alt-Ctrl-x`     : increase system volume
* `Cmd-Alt-Ctrl-z`     : decrease system volume
* `Cmd-Alt-Ctrl-Space` : mute system volume

### Window Positioning and Sizing
* `Shift-Alt-D, 1` : halfscreen-left
* `Shift-Alt-D, 2` : halfscreen-right
* `Shift-Alt-D, 3` : threequarters-left
* `Shift-Alt-D, 0` : fullscreen

### Misc
* `Cmd-Alt-Ctrl-l` : lock the computer
