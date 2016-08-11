# Hammerspoon

An init script for [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) that provides a bunch of keyboard shortcuts for actions I commonly use.

## Installation

1. Install [Hammerspoon](https://github.com/Hammerspoon/hammerspoon).
1. Clone this repository into your `~/.hammerspoon` directory.
1. Open Hammerspoon or reload your config from the Hammerspoon menubar
   menu.

## Features

- Find the cursor onscreen using Cmd-Alt-Ctrl-m
- Display a universal time (UTC) clock in the menubar
- Control iTunes:
    - play/pause, using Alt-Ctrl-Space
    - next track, using Alt-Ctrl-x
    - prev track, using Alt-Ctrl-z
    - display current track, using Alt-Ctrl-c
- Front-most window manipulation:
    - halfscreen-left, using Shift-Alt-D and then 1
    - halfscreen-right, using Shift-Alt-D and then 2
    - threequarters-left, using Shift-Alt-D and then 3
    - fullscreen, using Shift-Alt-D and then 0
- A script to automatically reload the Hammerspoon configuration
  whenever a file in the .hammerspoon dir changes
