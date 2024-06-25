# Neovim Haskell Docker image

This repository offers a Docker file for building an image that contains:

* Neovim,
* NvChad,
* Oh-my-zsh, with Powerlevel10K theme,
* GHC,
* Cabal,
* Haskell Language Server (HLS),
* Floskell,
* Fuzzy File Finder (FZF), and
* Lazygit.

along with some other useful tools. It uses a multiple stages to build the
tools to keep the resulting image relatively small. 

# Building

The image can be built as follows:

```bash
docker build -f neo-haskell.docker . --tag neo-haskell:latest
```

# Running

The `scripts` directory contains a shell script to run the image in a
(temporary) container. The script can be run as follows:

```bash
drun.sh neo-haskell <path>
```

The first argument is the name of the image you want to run. It will mount the
given `path` on a directory called `workspace` in the container. It is optional
to give a path, it will use the current directory otherwise (unless you run the
script from the root or you home directory).

The script will mount the local directory `~/.config/zsh_history` and the Docker
image will store the ZSH history file there, such that the command history is
persistent. 

Furthermore, the script uses SSH agent forwarding to make your local SSH key
available in the container, such that you can connect to, for example, GitHub.
Make sure you to make your key available to the ssh-agent with `ssh-add`.

# Configuration 

## GHC, Cabal and HLS

The Docker file has arguments for the GHC, Cabal, and HLS versions. These tools
are installed by `ghcup` and use by default the recommended versions. To use a
specific version you can supply a build argument to Docker. For example:

```bash
docker build -f neo-haskell.docker --build-arg="GHC=9.2.8" . --tag neo-haskell:latest
```

## Git 

The Docker file has also two argument for Git: a user name and a mail address.
These can be supplied as build arguments as well or you just change them in
the Docker file.

## ZSH

The ZSH uses Oh-my-zsh along with a couple of plugins (git and fzf) and is 
configure with the Powerlevel10K theme. Most of the configuration files come
from a git submodule `dotfiles`. 

## Neovim

The configuration of Neovim follows the NvChad starter structure and is 
configured using the following files:

- `chadr.lua`
- `options.lua`
- `mappings.lua`
- `plugins/init.lua`
- `configs/init.lua`

# Font

Use the `MesloLGLNerdFont-Regular.ttf` font for nice icons :-) 
