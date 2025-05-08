# Python

## Installation (MacOS)

We don't want to change the default python installation in MacOS. We will install via [python.org/downloads](https://www.python.org/downloads/).

Detailed guide to installing python is available on python.org [here](https://docs.python.org/3/using/mac.html).

Install the certificates that come with the python installer too. This is mentioned in the guide above.

The installer installs `python3` executable in a sub-folder in `/Library/Frameworks/Python.framework`. To use `python`
executable(with the suffix `3`) create the following symlink.

```sh
sudo ln -s /usr/local/bin/python3 /usr/local/bin/python
sudo ln -s /usr/local/bin/pip3 /usr/local/bin/pip
```

### Install pyright

Install via nvm
```sh
# Update the version number with the latest version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

# .shellrc file has the config to udpate env vars

nvm --version

# Install the latest version
nvm install node
```

```sh
npm install -g pyright
```

### Install ruff

```sh
brew install ruff
```

## Working with a new project

1. Check the python version: `python --version`.
1. Create virtual env in the `PROJECT_ROOT`.
    ```sh
    # Conventionally call the virtaual env '.venv'
    python -m venv .venv
    ```
1. `.envrc` file to auto activate the env when entering the folder.
    
    ```sh
    touch .envrc

    # .envrc
    VIRTUAL_ENV=."venv"
    layout python3
    ```
1. Define and install dependencies
    ```sh
    touch requirements.txt
    # Specify deps
    pip install -r requirements.txt
    ```
1. Add a `.gitignore` file. Taken from [`github/gitignore`](https://github.com/github/gitignore/blob/main/Python.gitignore).
    ```sh
    curl -fsSL https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore -o .gitignore
    ```

## `requirements.txt`

| Syntax           | Meaning                                      | Example            |
| ---------------- | -------------------------------------------- | ------------------ |
| `package`        | Latest available version                     | `requests`         |
| `package==1.2.3` | Exactly version 1.2.3                        | `requests==2.31.0` |
| `package>=1.2.3` | At least version 1.2.3                       | `requests>=2.0.0`  |
| `package<=1.2.3` | At most version 1.2.3                        | `requests<=2.31.0` |
| `package>1.2.3`  | Greater than version 1.2.3                   | `requests>2.0.0`   |
| `package<1.2.3`  | Less than version 1.2.3                      | `requests<3.0.0`   |
| `package~=1.4.5` | Compatible release (e.g., `>=1.4.5, <1.5.0`) | `requests~=2.25.1` |
| `package!=1.2.3` | Exclude version 1.2.3                        | `requests!=2.20.0` |

