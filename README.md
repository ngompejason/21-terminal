# 21 Terminal Profile

![terminal](./terminal.png)

This is my profile for UNIX or Ubuntu, I just use the default the gnome-terminal app. my starship config is highly inspire by the [Gruvbox Rainbow Preset](https://starship.rs/presets/gruvbox-rainbow).

These commands were last tested on August 2024 on Ubuntu 22.04.

**Update your software repositories and Install Git.**

```bash
sudo apt-get update && sudo apt-get upgrade && sudo apt-get install -y git
```

# Installation

**Clone the git repo(using hppts)**

```bash
git clone https://github.com/ngompejason/21-terminal.git
```

**Go to the path of the clone git**

```bash
cd path/to/21-terminal
```

### Starship

First, we'll install the [Starship](https://starship.rs/) a minimal, blazing-fast, and infinitely customizable prompt for any shell!

```bash
./install_01.sh
```

### Font, Ble.sh and termisl colour

The shell that I use is "Bash", the script below will:
- Install the font and set it as terminal font, I used the _0xProto_ Nerd Font at 12.
- Change the Background of the terminal
- Install ble.sh, which is the tool i used of autocompletion

```bash
./install_02.sh
```
**I'm still a noob when it comes to shell scripts, so if you have any issues, better way of _doing_ things, or complaints, use the Issues tab and let me know. I will be happy to work on it with you.**

