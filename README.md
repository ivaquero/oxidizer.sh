# Oxidizer.sh

[![CI](https://github.com/ivaquero/oxidizer.sh/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer.sh/actions/workflows/main.yml)
[![license](https://img.shields.io/github/license/ivaquero/oxidizer.sh)](https://github.com/ivaquero/oxidizer.sh/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

Minimalistic & Extensible Dotfile Management Solution using Rust Toolchains (PRs and Forks are welcome !)

<p align="left">
<a href="README.md">English</a> |
<a href="README-CN.md">简体中文</a>
</p>

Let's Oxidize Development Environments

![oxidizer](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer.png)

## 1. Get Started

For macOS / Linux

```bash
# define path for Oxidizer
export OXIDIZER=$HOME/oxidizer

git clone --depth=1 https://github.com/ivaquero/oxidizer.sh.git $OXIDIZER
bash $OXIDIZER/install.sh
```

Note that Homebrew is an essential dependency for Oxidizer on macOS / Linux. For China mainland users, you may set `BREW_CN` variable to install Homebrew through domestic mirror

```bash
export BREW_CN=1
```

For Windows

```powershell
# define path for Oxidizer
$env:OXIDIZER = "$env:USERPROFILE\oxidizer"

git clone --depth=1 https://github.com/ivaquero/oxidizer.sh.git $env:OXIDIZER
. $env:OXIDIZER\install.ps1
```

Note that Scoop is an essential dependency for Oxidizer on Windows. For China mainland users, you may set `SCOOP_CN` variable to install Scoop through domestic mirror

```powershell
$env:scoop_mirror = 1
```

After installation, you might personalize your preference in `custom.sh` (check `demo-custom.sh`). Open `custom.sh` by following command

```shellscript
ef ox
```

To keep up the updates, simply use `upox` function.

## 2. Philosophy

Oxidizer is origenally designed for **non-administrator** users. It quickly sets up a minimal but powerful coding environment, and it aims to provide with following features:

- Cross-Platform (Mainly Rust Tool chains)
- Minimal dependencies & Minimal Installation
- Extensible Architecture
- Unified Interface & Smooth Usage
- Super-Fast! (Loading time < 0.50 s)

## 3. Oxidization Progress

### 3.1. Command Line Replacement (Recommand all following)

☑️ means required in the installation.

- [x] Use `bat` instead of `cat`
- [x] Use `fd` instead of `find`
- [x] Use `gitui` instead of `lazygit`
- [x] Use `lsd` instead of `ls`
- [x] Use `ls --tree` instead of `tree`
- [x] Use `ripgrep` instead of `grep`
- [x] Use `sd` instead of `sed`
- [x] Use `tealdeer` instead of `tldr` or `man`
- [x] Use `zoxide` instead of `cd` or `z.lua`
- [x] Use `zellij` instead of `tmux` (not support windows)
- [ ] Use `bottom` instead of `top` or `htop`
- [ ] Use `dust` instead of `du`
- [ ] Use `tokei` instead of `cloc`

### 3.2. Software Replacement

- [ ] Use `Alacritty` instead of `iTerm2` or `Windows Terminal` (Not required, but strongly recommend)
- [ ] Use `Helix` instead of `NeoVim`
- [ ] Use `Deno` instead of `Node`
- [ ] Use `Nushell` instead of `Zsh` or `Powershell`

> For `Nushell`: Its nu language is new and will add learning cost. Besides, nu scripts do not have any linter or formatter, which is not convinient for coding.

### 3.3. Other Useful Rust Tools

- [x] `pueue`: Command-line task management tool for sequential and parallel execution of long-running tasks.
- [x] `hyperfine`: Command-line benchmarking tool
- [ ] `delta`: A syntax-highlighting pager for git, diff, and grep output
- [ ] `mdbook`: A utility to create modern online books from Markdown files.

### 3.4. Summary of Plugins

Oxidizer is designed to be extensible, you can personalize `PLUGINS` in `custom.sh` to load the plugins by your need.

Of course, you are allowed to write your own plugins, see `10. Writing A Plugin` for details.

| index | Plugin  | Linux | macOS | Windows | required ? |
| :---: | :-----: | :---: | :---: | :-----: | :--------: |
|   1   |  Brew   |  ✅   |  ✅   |   ❌    |     ✅     |
|   2   |  Scoop  |  ❌   |  ❌   |   ✅    |     ✅     |
|   3   | Utility |  ✅   |  ✅   |   ✅    |     ✅     |
|   4   | System  |  ✅¹  |  ✅   |   ✅    |     ✅     |
|   5   |  Pueue  |  ✅   |  ✅   |   ✅    |     ✅     |
|   6   |   Git   |  ✅   |  ✅   |   ✅    |            |
|   7   |  Conan  |  ✅   |  ✅   |   ✅    |            |
|   8   |  Conda  |  ✅   |  ✅   |   ✅    |            |
|   9   | Docker  |  ✅   |  ✅   |   ✅    |            |
|  10   |  Julia  |  ✅   |  ✅   |   🚧    |            |
|  11   |  Node   |  ✅   |  ✅   |   ✅    |            |
|  12   |  Rust   |  ✅   |  ✅   |   ✅    |            |
|  13   | TeXLive |  ✅   |  ✅   |   ✅    |            |
|  14   | VS Code |  ✅   |  ✅   |   ✅    |            |
|  15   | Formats |  🕒   |  🕒   |   🕒    |            |
|  16   | Widgets |  🕒   |  🕒   |   🕒    |            |
|  17   | Zellij  |  ✅   |  ✅   |   ❌    |            |
|  18   | NeoVim  |       |       |         |            |
|  19   |  Helix  |       |       |         |            |

✅: complete functionality
🚧: partial functionality
🕒: basic functionality, needs more features
❌: not exist

> ¹: Currently, on Linux only provide with Ubuntu-specific shortcuts.

Oxidizer uses Homebrew or Scoop to manage packages and softwares to bypass the requirement of administrator privilege.

For Linux users, you can try to add Homebrew tap [Hombrew-Linux](https://github.com/ivaquero/homebrew-linux/) to install GUI Applications.

## 4. File Management

![design](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer-design.png)

- `ff`
  - refresh file by `source`
- `ef`
  - file: edit by `$EDITOR` (default: VSCode)
- `bf`
  - file: browse by `bat` / `cat`
  - folder: browse by `lsd` / `ls`
- `ipf`
  - file: overwrite system configurations by customized (backup) files
- `epf`
  - file: export system configurations to back up folder
- `iif`
  - file: overwrite system configurations in by Oxidizer defaults.

For example, if you want to edit `~/.zshrc`, you can type `ef zs`.

When you use `epf zs`, `~/.zshrc` will be copied and save in `$BACKUP/shell` folder, where `$BACKUP` is the backup path that can be personalized in `$OXIDIZER/custom.sh`. As mentioned in `1. Get Started`, you can open `custom.sh` simply by `ef ox`.

The table below shows the informatioin of specific configuration files.

|   Origin   | Abbr.  | Corresponding File  |
| :--------: | :----: | :-----------------: |
|  oxidizer  |  `ox`  |     `custom.sh`     |
|    zsh     |  `zs`  |      `.zshrc`       |
| powershell |  `ps`  |    `Profile.ps1`    |
| alacritty  |  `al`  |   `alacritty.yml`   |
|   aria2    |  `ar`  |    `aria2.conf`     |
|   conda    |  `c`   |     `.condarc`      |
|    git     |  `g`   |    `.gitconfig`     |
|   conan    |  `cn`  |      `default`      |
|   conan    | `cnr`  |    `remote.json`    |
|   helix    |  `hx`  |    `config.toml`    |
|   helix    | `hxl`  |  `languages.toml`   |
|   julia    | `jls`  |    `startup.jl`     |
|   julia    | `jlp`  |   `Project.toml`    |
|   julia    | `jlm`  |   `Manifest.toml`   |
|   pueue    |  `pu`  |     `pueue.yml`     |
|   pueue    | `pua`  | `pueue_aliases.yml` |
|   cargo    |  `cg`  |        `env`        |
|   cargo    | `cg_`  |      `.cargo`       |
|   neovim   |  `nv`  |     `init.lua`      |
|   neovim   | `nvp`  |    `plugins.lua`    |
|   neovim   | `nvv`  |     `init.vim`      |
|    vim     |  `vi`  |      `.vimrc`       |
|   vscode   |  `vs`  |   `settings.json`   |
|   vscode   | `vsk`  | `keybindings.json`  |
|   vscode   | `vss_` |     `snippets`      |
|   winget   |  `w`   |   `settings.json`   |
|   zellij   |  `zj`  |    `config.yaml`    |
|   zellij   | `zjl_` |      `layouts`      |

> `_` denotes folder

## 5. Software management

- `back_*`
  - file: export package/extension configurations to `$BACKUP` folder
- `up_*`
  - file: update package/extension configurations in `$BACKUP` folder to system
- `init_*`
  - file: install by package/extension configuration files in `$Oxygen/install` folder

More specifically

- `back_conda`: backup Conda package list `$BACKUP` folder
- `back_node`: backup NodeJS package list to `$BACKUP` folder
- `back_julia`: backup Julia package list `$BACKUP` folder
- `back_texlive`: backup TeXLive collection list `$BACKUP` folder
- `back_vscode`: backup VSCode extension list `$BACKUP` folder

`update_*` and `init_*` work similarly.

### 5.1. NeoVim

For NeoVim, a pure Lua configuration (using `init.lua` ) is recommended instead of classic Vim configuration (using `init.vim` ).

However, if you would like to the native vim but haven't configure it, you can try Oxidizer's default configuration by `iif vi`.

### 5.2. TeXLive

## 6. Package Management

Oxidizer aims to provide a unified interface for all package manager-related commands to reduce typing and memory burden of command-line users.

|        |   action    | brew [b] | scoop [s] | conda [c] | npm [n] | cargo [cg] | rustup [rs] | julia [jl] | conan [cn] | tlmgr [tl] |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: | :--------: |
|  `*h`  |    help     |    ✅    |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*is`  |   install   |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*up`  |   update    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*ups` | update self |    ✅    |    ✅     |           |         |            |             |            |            |     ✅     |
| `*ls`  |    list     |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |     ✅     |     ✅     |
| `*lv`  |   leaves    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |            |            |
| `*sc`  |   search    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |     ✅     |            |
| `*cl`  |    clean    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |            |            |
| `*if`  |    info     |    ✅    |    ✅     |    ✅     |   ✅    |            |             |            |     ✅     |     ✅     |
| `*st`  |   status    |    ✅    |    ✅     |           |   ✅    |            |             |     ✅     |            |            |
| `*ck`  |    check    |    ✅    |    ✅     |           |   ✅    |     ✅     |     ✅      |            |            |     ✅     |
| `*pn`  |     pin     |    ✅    |           |           |         |            |             |     ✅     |            |            |
| `*upn` |    unpin    |    ✅    |           |           |         |            |             |     ✅     |            |            |
| `*dp`  |   depends   |    ✅    |           |    ✅     |         |            |             |            |            |            |
| `*dpt` | depend tree |    ✅    |           |    ✅     |         |            |             |            |            |            |

Particularly, Oxidizer provides with two groups of experimental functions with suffix `p` for installing and downloading packages in parallel

- brew: `bisp`, `biscp`, `bupp`, `bupap`
- scoop: `sisp`, `supp`

For example, when you have more than 1 packages to install, instead of using `bis [pkg1] [pkg1]`, you can use `bisp [pkg1] [pkg1]` then the packages will be downloaded and installed in parallel.

Similary, `biscp`, `bupp`, `bupap` are the parallel version of `bisc`, `bup`, `bupa`, respectively.

Before using parallel functions, pueue service need to be enabled by

```bash
# All OS
pueued -d
# or macOS / Linux
bss pu
```

Some package managers also have functionality of project management

|       | action  | brew [b] | conda [c] | npm [n] | cargo [cg] | rustup [rs] | julia [jl] | conan [cn] |
| :---: | :-----: | :------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: |
| `*ii` |  init   |    ✅    |    ✅     |   ✅    |     ✅     |             |            |     ✅     |
| `*b`  |  build  |          |           |         |     ✅     |             |     ✅     |     ✅     |
| `*r`  |   run   |          |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |            |
| `*e`  |  edit   |    ✅    |           |   ✅    |            |             |            |            |
| `*ts` |  test   |    ✅    |           |   ✅    |     ✅     |             |     ✅     |     ✅     |
| `*pb` | publish |          |           |   ✅    |     ✅     |             |            |            |

Some of package manager shortcuts are included in corresponding system plugins.

- `zsh-macos` [zsm]: auto-loaded, contains `mas`.
- `zsh-ubuntu` [zsub]: contains `apt`
- `pwsh-windows` [pswd]: auto-loaded, contains `winget`, `wsl`.

|        |   action    | apt [ub] | winget [app] | wsl [wl] | mas [app] |
| :----: | :---------: | :------: | :----------: | :------: | :-------: |
|  `*h`  |    help     |    ✅    |      ✅      |          |    ✅     |
| `*is`  |   install   |    ✅    |      ✅      |    ✅    |    ✅     |
| `*us`  |  uninstall  |    ✅    |      ✅      |          |    ✅     |
| `*up`  |   update    |    ✅    |      ✅      |          |    ✅     |
| `*ups` | update self |    ✅    |              |          |           |
| `*ls`  |    list     |    ✅    |      ✅      |    ✅    |           |
| `*lv`  |   leaves    |          |              |          |           |
| `*sc`  |   search    |    ✅    |              |          |    ✅     |
| `*cl`  |    clean    |    ✅    |              |          |           |
| `*if`  |    info     |    ✅    |      ✅      |          |    ✅     |
| `*st`  |   status    |          |              |          |    ✅     |
| `*ck`  |    check    |    ✅    |              |          |           |
| `*pn`  |     pin     |          |              |          |           |
| `*upn` |    unpin    |          |              |          |           |
| `*dp`  |   depends   |    ✅    |              |          |           |
| `*dpt` | depend tree |          |              |          |           |

### 6.1. Homebrew

- [x] Integrated Aria2 to download Homebrew Casks
- [x] Enable Homebrew installation by using pre-download installers

- `bis`: brew install
- `bris`: brew reinstall

suffix `c` is a flag to specify brew commands only work on casks

- `bisc`: brew install --cask
- `brisc`: brew reinstall --cask
- `bupc`: brew upgrade --cask

suffix `a` is for `all` which will force brew to upgrade every cask including ones with `auto_update` flags

- `bupa`: brew upgrade --greedy

- `bdl`: download brew cask by `aria2`
- `brp`: replace brew cache file by pre-downloaded file
- `bmr`: using brew mirror
- `bmrq`: reset brew git source to official repositories, `q` is for quit.

### 6.2. Conda

Note that the conda plugin is based on `mamba` (a parallel version of conda) and `conda-tree`, so you need to install mamba by

```bash
conda install -c conda-forge mamba conda-tree
```

Besides the shortcuts mentioned above in `6. Package Management`, the conda plugin also provides with Conda environment management shortcuts which start with `ce`

- `ceat`: activate environment
  - `$1` length = 0: activate `base` env
  - `$1` length = 1 or 2: activate predefined env `Conda_Env`
  - `$1` length > 2: activate new env

`Conda_Env` can be personalize in `custom.sh`

For example, if you conda environment name is `hello`, you can set

```bash
# macOS / Linux
Conda_Env[h]="hello"
# Windows
$global:Conda_Env.h = "hello"
```

then, you will be able to manipulate the environment by

```bash
# create environment
cecr h
# remove environment
cerm h
# update all packages in the specific environment
cup h
# list all packages in the specific environment
cls h
```

- `cerat`: reactivate environment, works live `ceat`
- `ceq`: quit environment ( `q` is for `kill/quit` )
- `cecr`: create
- `cerm`: remove environment, works live `ceat` but won't remove `base` env
- `cels`: environment list
- `cesd`: change environment's conda-forge subdir
- `ceep`: export environment

## 7. Project & Task Management

Oxidizer's task & system management follows the same phylosopy of package management, _i.e._ to provide unified interfaces to faciliate workflows.

|       |   action    | git [g] | docker <br> container [dkc] | docker <br> image [dki] | lima [lm] | pueue [pu] | brew <br> services [bs] |
| :---: | :---------: | :-----: | :-------------------------: | :---------------------: | :-------: | :--------: | :---------------------: |
| `*h`  |    help     |   ✅    |                             |                         |    ✅     |     ✅     |           ✅            |
| `*ii` |    init     |   ✅    |                             |                         |           |            |                         |
| `*df` |    diff     |   ✅    |             ✅              |                         |           |            |                         |
| `*cl` |    clean    |   ✅    |             ✅              |                         |    ✅     |     ✅     |           ✅            |
| `*ls` |    list     |         |             ✅              |           ✅            |    ✅     |            |           ✅            |
| `*st` |   status    |   ✅    |                             |                         |           |     ✅     |                         |
| `*s`  |    start    |         |             ✅              |                         |    ✅     |     ✅     |           ✅            |
| `*rs` |   restart   |         |             ✅              |                         |           |     ✅     |           ✅            |
| `*pa` |    pause    |         |             ✅              |                         |           |     ✅     |                         |
| `*q`  | kill / stop |         |             ✅              |                         |    ✅     |     ✅     |           ✅            |
| `*rt` |    reset    |         |                             |                         |    ✅     |     ✅     |                         |
| `*a`  |     add     |   ✅    |                             |                         |           |     ✅     |                         |
| `*rm` |   remove    |         |             ✅              |           ✅            |    ✅     |     ✅     |                         |
| `*e`  |    edit     |         |                             |                         |    ✅     |     ✅     |                         |
| `*pl` |    pull     |   ✅    |                             |           ✅            |           |            |                         |
| `*ps` |    push     |   ✅    |                             |           ✅            |           |            |                         |
| `*if` |    info     |         |             ✅              |                         |    ✅     |            |           ✅            |

### 7.1. Git

- [x] delete ignored files in `.gitignore`: `gig`
- [x] find fat blob files: `gjk`
- [ ] integration of `git filter-repo` command
  - [x] clean files by size bigger than `gcl -s`
  - [x] clean files by id `gcl -i`
  - [x] clean files by path `gcl -p`

### 7.2. Docker

### 7.3. Pueue

### 7.4. Homebrew Services

## 8. Utils Management

### 8.1. Zellij

- [x] Predefined layouts
- [x] Integrated in Alacritty
  - [x] Shortcuts to move the cursor
  - [x] Shortcuts to move the pane border
  - [x] Shortcuts to split the pane

### 8.2. Formats

- [x] Convert markdown: `mdto`
  - [x] to PDF with Unicode (for CJK)

```bash
mdto [filename] [format]
```

### 8.3. Widgets

- [x] Weather report (using wttr/in)

```bash
wtr [location]
```

## 9. System Management

### 9.1. macOS

- `update`: update system
- `clean`
  - `clean`: empty trash
  - `clean bdl`: clean homebrew downloaded files
  - `clean cc`: clean cache files in `$HOME/Library/Caches/`
  - `clean log`: clean logs
- `allow`: allow installation of uncertified apps

### 9.2. Linux

## 10. Writing A Plugin

A plugin in Oxidizer is refered as Oxygen, a key-value object whose key starts with `oxp`.

For a Vim plugin on macOS / Linux, you can write

```bash
Oxygen[oxpvi]=plugin_path
```

And add the _key of Oxygen_ into `PLUGINS` object in `custom.sh` like

```bash
PLUGINS=(oxp1 oxp2 oxpvi)
```

For Windows users, do these in a similar way

```powershell
$global:Oxygen.oxpvi = "plugin_path"
```

And add it into `PLUGINS` object in `custom.ps1`

### 10.1. Config Files

A system / software / tool configuration file in Oxidizer is refered as Element, set it like what you do with Oxygen

```bash
# macOS / Linux
Element[vi]=$HOME/.vimrc
# Windows
$global:Element.vi = "$env:USERPROFILE/.vimrc"
```

If you need to set a folder in Oxygen, plus a `_` as the suffix of the key.

```bash
# macOS / Linux
Element[vi_]=$HOME/.vim
# Windows
$global:Element.vi_ = "$env:USERPROFILE/vim"
```

### 10.2. Backup Files

A backup file in Oxidizer is refered as Oxide whose key starts with `bk`, set it like

```bash
# macOS / Linux
Oxide[bkvi]=$BACKUP/.vimrc
# Windows
$global:Oxide.bkvi = "$env:BACKUP/.vimrc"
```

Do remember the key in Oxygen, Element, Oxide must be consistent: `oxvi`, `vi`, `bkvi` works, others don't.

## 11. Credits

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 12. License

This work is released under the GPL-v3 license.
