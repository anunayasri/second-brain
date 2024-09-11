# Introduction

Hi 👋. Anunaya here. Welcome to my personal corner of the internet.

I am a software engineer by profession and by interest. I want a place to store 
my learnings from the various things I read and work upon. These include things 
from life advice, time management, software engineering etc. Hence, this space 
was born.

## Visiting the Garden

If this is your first visit, welcome! You might be overwhelmed by the amount of 
content here. You can browse the topics in the navigation tree on the left. 
Start reading the first article that grabs your attention. You can also use the 
search bar at the top.

## History and the Future

This space is inspired by [The Blue Book](https://lyz-code.github.io/blue-book/)
which I stumbled upon while googling about a software engineering concept. In fact,
The Blue Book was one of the top results in the Google search. I learnt that this 
concept is called _Digital Garden_.

The idea is to have a knowledge repository 💡 which can grow over time. These posts 
are like sapplings 🍀 which will be nurtured and grow in a beautiful garden 🌴. 
The garden will bear fruits 🍊 for gardener and other people visiting the garden.

This space is in its nacent stage. It will be restructured and reformatted in 
multiple ways in the coming future.

> Currently the garden has content about Software Enggineering particularly 
> Python, Go

## How is this Garden made?

I wanted a setup where I can use a simple text editor, like `neovim`, to write the 
content, store the content in a version control tool, like `git`, and easily 
publish it on the internet. I came up with the following setup.

1. Write content using `markdown` in `neovim`.
1. Use [MkDocs](https://www.mkdocs.org/) site generator with [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
    to generate a site. This setup provides a good navigational website with 
    a beautiful UI. MkDocs has a good suite of plugins to provide functinoality 
    like search.
1. Use `git` and `Github` for versioning and storage.
1. Use `Github Pages` and `Github Actions` to publish the website with each commit
    or merge to the `main` branch. MkDocs comes with built-in command `mkdocs gh-deploy`
    to build and deploy the site on Github Pages.

