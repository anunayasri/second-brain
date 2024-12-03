# Anunaya's Second Brain

This repo stores all my public notes and blogs.

## Making Changes to the Repo

Make changes and commit to the `develop` branch. These changes will not be
deployed to the production site. Once you are ready to deploy, merge it with
`master` branch. A Github workflow will trigger and will deploy the changes the
production website.

## Using mkdocs 

First time setup -

```sh
cd second-brain

python -m venv .venv 
source .venv/bin/activate

pip install -r requirements.txt

# new mkdcos project
mkdocs new .
```

Making changes and testing -

```sh
# start the dev server
mkdocs serve
```

## Project layout

```
    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.
    blogs/
        index.md  # Blog homepage
        posts/
            ...   # Each entry is a blog post.

```

## TODO:

- ✅ Add existing notes to the Brain section.
- ✅ Add About section.
- ✅ Add Blog section.

## References for developing this repo

- [The Blue Book](https://lyz-code.github.io/blue-book/)
- [Mkdocs Material Blog Plugin](https://squidfunk.github.io/mkdocs-material/setup/setting-up-a-blog/)
    - The same site serves as a document and a blog. Check out the `Home` section 
      and the `Blog` section.
- [FastAPI Docs](https://github.com/fastapi/fastapi/tree/master/docs/en/docs)
- [Andy's Digital Garden](https://notes.andymatuschak.org/About_these_notes?stackedNotes=z5E5QawiXCMbtNtupvxeoEX)
    - checkout his concepts of Evergreen notes
