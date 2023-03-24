# Coc

"Make your Vim/Neovim as smart as VSCode"

I love it, it just works

## Install

[Install rust-analyzer in coc](https://rust-analyzer.github.io/manual.html#vimneovim)

[coc install page](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim)

To check and see if the coc.nvim service is running, use command **:checkhealth** in neovim (not supported by vim);
Another useful command is **:CocInfo** — use it after the service has started to get some useful information on it.

**Coc dependencies**

[coc.nvim](https://github.com/neoclide/coc.nvim)
[coc.nvim install](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim)

-- macos commands
```sh
brew install node
```
```vim
:CocInstall coc-rust-analyzer
```

[coc rust analyzer](https://github.com/fannheyward/coc-rust-analyzer)


## Language support


## Configure

[Coc configuration manual](https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file)
[Rust-analyzer config manual](https://github.com/fannheyward/coc-rust-analyzer)
`:CocConfig` will open editor for `$HOME/.config/nvim/coc-settings.json` which is JSON
`CocInstall coc-json` will install intellisense for coc-settings.json


## Commands

`:CocConfig` - open coc config file for reading (~/.config/nvim/coc-settings.json)
[See](https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file)

`:CocList sources` - list completion sources
[See](https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#completion-sources)


## Coc extensions

### Coc marketplace

[github marketplace](https://github.com/fannheyward/coc-marketplace)
To install run `:CocInstall coc-marketplace`

Usage
    :CocList marketplace list all available extensions
    :CocList marketplace python to search extension that name contains python
    You can tab on an extension to do install, uninstall, homepage actions.
