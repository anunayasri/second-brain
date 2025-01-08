# Git Receipes

> Useful git commands and recipes for various tasks.

!!! note
    My git config along with useful git aliases are available in my [dotfiles](https://github.com/anunayasri/dotfiles/tree/master/git)

Delete local branches that have been deleted from remote

```sh
# Confirm what branches will be deleted
# name: Name of remote, origin in most cases
git remote prune <name> --dry-run

# ACTUALLY delete the branches
git remote prune <name>
```

List the branches already merged with `master`. You can delete them if needed. However, this will not work if your commits
are squashed with merging the PR with `master`. This happens because the following command checks the presence of commits
b/w the branches and `master`.

```sh
# list the branches
git branch --merged master

# delete the branches
git branch --merged master | grep -v "^\*\\| master" | xargs -r git branch -d
```
