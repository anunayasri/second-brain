# My Neovim Workflow

> WIP

While the cursor is on a file -

`-` : stage or unstage a file or multiple files. Ctrl+v for file selection in range.
`=` : Inline git diff. Not very useful!
`Enter` : Opens the file in the horizontal window.

While editing a file -

* `:Gvdiff` : diff in vsplit
* `[c ]c` : Prev and next hunk

Stage / Unstage the open file:

* `Gw` : Save & stage the current file.
* `Gread` : Remove the unstaged changes in the current file
* ` ` : Stage a hunk
* ` ` : Preview a hunk
* ` ` : Unstage a hunk

* `G commit -m ""` : Commit staged changes

File history -

* `Gblame` : 
* `G log` : Git log of current file in a hsplit window
    * View files changed in a commit
    * Diff in a commit : `Enter` on the commit id

`sp`, `vsp` : open same buffer in split or vsplit
`:tab sp` : opens the same buffer in a new tab

Resolving conflicts using Fugitive -

* http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
* https://www.youtube.com/watch?v=vpwJ7fqD1CE

Telescope Integration -

* Scroll the preview window?
* `:Telescope git_` use tab to autocomplete

Text objects while programming -

https://www.youtube.com/watch?v=FuYQ7M73bC0
