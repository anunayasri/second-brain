# Working with Python Dependencies

## pyproject.toml

WIP

## What does `pip install` do?

WIP

## pip : Get Dependency List of a Package at PyPI

Visit: `https://pypi.org/pypi/{package}/json`

Search for `requires_dist`. You can see the list of deps and the supported
versions.

You can do the same from the command line

```sh
# to get the deps of package `dvclive`
curl https://pypi.org/pypi/dvclive/json | jq '.info.requires_dist' | nvim -
```

## Install a local package that you are developing

You are working on a package, say `dvc`, in your local. You can to install this 
local package as a dependency in your current project, say `dvc-demo`. 

This happens because of [pip's editable install feature](https://pip.pypa.io/en/stable/topics/local-project-installs/#editable-installs).
Editable installs allow you to install your project without copying any files.
Instead, the files in the development directory are added to Python’s import
path.

```sh
cd dvc-demo
pip install -e /path/to/local/dvc
# the folder should have setup.py or pyproject.toml file
```
