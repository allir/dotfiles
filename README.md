# dotfiles

My dotfiles repo.

## Installation

Before installin you may want to make sure your computer is up to date. 
* `sudo softwareupdate -i -a`

### Prerequisites

* `curl`

### Installation Steps

1. Run the `install` script.

    ```bash
    curl -s https://raw.githubusercontent.com/allir/dotfiles/master/remote_install | bash 
    ```

    OR

    ```
    git clone https://github.com/allir/dotfiles.git ~/.dotfiles
    ~/.dotfiles/install
    ```

2. A newer version of `bash` and `zsh` are installed with homebrew but the default shell has not been updated automatically. To update run `chsh`. For example `chsh -s /usr/local/bin/bash` to use homebrew's bash.
