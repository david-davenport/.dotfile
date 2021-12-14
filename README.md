# Dotfiles

## Requirements

- GNU stow

## Usage
1. Clone the repo
2. CD into the repo
3. Stow a package. Example for nvim:
```sh
stow -t ~ -d stow -S nvim
```

This assumes you are calling from the root of this repo. If not, change
the `-d` option to be the path to the stow directory.
