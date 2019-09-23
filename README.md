# dotfiles

My dotfiles repo.

## Installation

### Prerequisites

* `curl`

### Installation Steps

1. Run the `install` script.

    ```bash
    curl -s https://raw.githubusercontent.com/allir/dotfiles/master/remote_install | bash 2>&1 | tee ~/setup.log
    ```

2. A newer version of `bash` and `zsh` are installed with homebrew but the default shell has not been updated automatically. To update run `chsh`. For example `chsh -s /usr/local/bin/bash` to use homebrew's bash.
