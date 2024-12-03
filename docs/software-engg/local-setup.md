# Local Setup

> Tools & setup for a great developer experience

<!-- more -->

> Link to my dotfiles
> Quick guide to install & work with them

## Working with the Terminal

> Why is learning terminal important for new devs?
> Tools I use to work efficiently with the terminal

### Terminal emulator: alacrity

> What is a terminal emulator?

### `brew` on MacOS

### tmux

### Text Editor: neovim

> What do you need from a modern text editor?

### docker

### fzf

### zoxide

### git

> git aliases for fast dev work

### vifm

### envrc

## Free up memory in local machine

```sh
# -a : remove all unused images, containers, networks etc
docker system prune -a

# Cleans cache at `go env GOCACHE`
# -x : prints the remove commands
go clean -cache -x  

# delete module download cache ie `$GOHOME/pkg/mod`
go clean -modcache -x 
```
